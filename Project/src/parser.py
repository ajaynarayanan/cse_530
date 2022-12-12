from constants import LOGS_ROOT_DIR, KERNELS, PARAMS, PTRACE_ROOT_DIR

import subprocess
import glob
import yaml


def parse_log(results_file_name, property_name):
    """
    This function reads the value for the given `property_name` from `results_file_name` 
    using grep, cut 
    grep 'gpu_max_L2_WH' gpgpusim_power_report__Sun-Dec--4-15-15-56-2022.log | cut -f2 -d'='
    1) search for `property_name` in `results_file_name` using grep
    2) use cut to find characters after '=' and return them
    """
    cmd  = f"grep '{property_name}' {results_file_name} | cut -f2 -d'=' "
    result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip(" \n")
    try: 
        return float(result)
    except:
        print(f"Error occured while parsing {property_name} in {results_file_name}") 
        return 0.0


def collect_all_params(results_file_name, params):
    """
    Returns a dictionary with key as param name and value as a list of param values
    """
    result = {}
    for param in params:
        if param == "KERNEL_POWER":
            min_param = f"kernel_min_power"
            avg_param = f"kernel_avg_power"
            max_param = f"kernel_max_power"
        else:
            min_param = f"gpu_min_{param}"
            avg_param = f"gpu_avg_{param}"
            max_param = f"gpu_max_{param}"

        result[param] = [
            parse_log(results_file_name, min_param),    # min
            parse_log(results_file_name, avg_param),    # avg
            parse_log(results_file_name, max_param),    # max
        ]
    return result

def parse_config_file(config_file_name):
    """
    Reads a config file and returns the mapping dictionary
    """
    with open(config_file_name, "r") as stream:
        try:
            return yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print(exc)

def collect_experiments():
    """
    Returns a dictionary with key as kernel and their values being their power information
    """
    results = {}
    for kernel in KERNELS:
        results[kernel] = {}
        for log_file_path in glob.glob(f'{PTRACE_ROOT_DIR}/{kernel}/gpgpusim_outputs/*/*.log'):
            log_file_name = log_file_path.split("/")[-1]
            results[kernel][log_file_name] = collect_all_params(log_file_path, PARAMS)
    return results