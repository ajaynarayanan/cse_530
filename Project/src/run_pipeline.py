from constants import KERNELS, LOGS_ROOT_DIR, INPUT_FILE_NAME
from log_to_ptrace_convertor import ptrace_convertor
from shell_executor import clear_logs, replace_line_in_file, run_cu_kernel, compile_cu_kernel, move_logs, run_hotspot
from utils import read_csv_to_list_of_dict

from pathlib import Path

def execute_c_kernel_txt_input(input_kernel_name):
    """
    Clears existing logs, compiles the kernel and runs it 
    """
    clear_logs(input_kernel_name)
    compile_cu_kernel(input_kernel_name)
    input_file= f"{LOGS_ROOT_DIR}/{input_kernel_name}/{INPUT_FILE_NAME}.txt"
    print(input_file)
    with open(input_file, 'r') as f:
        for input_cmd_args in f:
            if input_cmd_args != "":
                run_cu_kernel(input_kernel_name, input_cmd_args)

                # replace space to underscore in input_cmd_args
                folder_suffix = input_cmd_args.replace(" ", "_").strip("\n")        

                move_logs(input_kernel_name, folder_suffix)

def execute_c_kernel_csv_input(input_kernel_name):
    """
    Clears existing logs, compiles the kernel and runs it 
    """
    clear_logs(input_kernel_name)
    input_file= f"{LOGS_ROOT_DIR}/{input_kernel_name}/{INPUT_FILE_NAME}.csv"
    input_list=read_csv_to_list_of_dict(input_file)
    for input_dict in input_list:

        print(f"==== Running {input_kernel_name} : {input_dict} ====")
        # make changes to the source file
        for (key, value) in input_dict.items():
            replace_line_in_file(f"{LOGS_ROOT_DIR}/{input_kernel_name}/{input_kernel_name}.cu", f"#define {key}", f"#define {key} {value}")

        # compile the kernel
        compile_cu_kernel(input_kernel_name)

        print(f"==== Done with compiling {input_kernel_name} ====")
        # run the kernel 
        run_cu_kernel(input_kernel_name, "")

        # derive folder_suffix
        folder_suffix = ""
        for key in sorted(input_dict.keys()):   
            folder_suffix += f"{input_dict[key]}_"        
        folder_suffix = folder_suffix[:-1]

        # move logs
        move_logs(input_kernel_name, folder_suffix)

def call_executor_fn(input_kernel_name):
    """
    Calls appropriate execution fn based on input file format 
    """
    input_file= f"{LOGS_ROOT_DIR}/{input_kernel_name}/{INPUT_FILE_NAME}"
    csv_file = Path(f"{input_file}.csv")
    if csv_file.exists():
        execute_c_kernel_csv_input(input_kernel_name)
    else:
        execute_c_kernel_txt_input(input_kernel_name)


if __name__ == "__main__":
    # run the C kernels
    # for kernel in KERNELS:
    #     call_executor_fn(kernel)
    
    print("==== Running ptrace convertor ====")
    # convert *.log to *.ptrace
    ptrace_convertor()
    print("==== Running hotspot ====")
    for kernel in KERNELS:
        run_hotspot(kernel)