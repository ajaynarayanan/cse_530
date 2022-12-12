from constants import ABS_ROOT_DIR, KERNELS, PTRACE_ROOT_DIR
from parser import collect_experiments, parse_config_file
from utils import dict_to_file

import collections
import string 

def compute_power_value(input_power_list1, input_power_list2):
    """
    Sums two input lists of format [min_power_value, avg_power_value, max_power_value]
    """
    return [input_power_list1[i] + input_power_list2[2] for i in range(len(input_power_list1))]

def sample_power_values(input_power_list):
    """
    Samples a single number from an input lists of format [min_power_value, avg_power_value, max_power_value]
    """
    return round(input_power_list[1], 5)

def accumulate_power(simulated_power_values, hardware_components_list, component_mapper):
    """
    Sums power values from simulated component names (IBP, FCP, etc) to 
    hardware components (L2C, SM, etc)
    """
    power_values = {hardware_component:[0, 0, 0] for hardware_component in hardware_components_list}

    for param in simulated_power_values:
        if param in component_mapper:
            hardware_component = component_mapper[param]
            power_values[hardware_component] = compute_power_value(power_values[hardware_component], simulated_power_values[param])

    return power_values
    
def distribute_values(power_values, hardware_component_count_map):
    """
    Converts {SM: power_value, ..}, which capture power_values 
    for all instances of 'SM', to {SM1: power_value_1, SM2: power_Value_2, ..}
    """
    distributed_power_values = {}
    for hardware_component in hardware_component_count_map:
        count = hardware_component_count_map[hardware_component]
        for i in range(1,int(count)+1): 
            distributed_power_values[f"{hardware_component}{i}"] = sample_power_values(power_values[hardware_component])/int(count)
            distributed_power_values[f"{hardware_component}{i}"] = round(distributed_power_values[f"{hardware_component}{i}"], 5)
    return distributed_power_values


def ptrace_convertor():
    """
    Converts all gpgpusim's log files to ptrace files
    """
    print("parsing log files")
    results = collect_experiments()
    print(results)


    print("parsing config files")
    config = parse_config_file(f"{ABS_ROOT_DIR}/src/mapping_config.yml")
    print(config)


    for kernel in KERNELS:
        print(f"Generating ptrace file for {kernel}")
        for log_file_name in results[kernel]:
            # come up with ptrace name
            derived_ptrace_name = log_file_name.split(".")[0]
            derived_ptrace_name = derived_ptrace_name.replace(f"gpgpusim_power_report_", "")
            ptrace_file_name = f"{PTRACE_ROOT_DIR}/{kernel}/ptraces/{derived_ptrace_name}.ptrace"
            print(ptrace_file_name)
            r = accumulate_power(results[kernel][log_file_name], config["hardware"], config["mapping"])
            s = distribute_values(r, config["count"])
            t = collections.OrderedDict(sorted(s.items(), key=lambda x: config["hardware_ordering"][x[0].rstrip(string.digits)]))
            print(t)
            dict_to_file(t, ptrace_file_name)