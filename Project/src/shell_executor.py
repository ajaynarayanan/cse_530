from constants import PTRACE_ROOT_DIR, LOGS_ROOT_DIR, HOTSPOT_ROOT_DIR

from pathlib import Path
import glob
import subprocess

def compile_cu_kernel(input_kernel_name):
    """
    Compiles a C kernel with proper simulation flags
    Compiled output file will be in the format {input_kernel_name}.out
    """
    cmd  = f"cd {LOGS_ROOT_DIR}/{input_kernel_name} && nvcc {input_kernel_name}.cu -lcudart -o='{input_kernel_name}.out' && ldd {input_kernel_name}.out"
    result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip(" \n")
    print(result)

def run_cu_kernel(input_kernel_name, cmd_line_arguments):
    """
    Executes an {input_kernel_name}.out file and moves it output to a different directory
    """
    cmd = f"cd {LOGS_ROOT_DIR}/{input_kernel_name} && ./{input_kernel_name}.out {cmd_line_arguments}"
    result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip(" \n")
    print(result)

def clear_logs(input_kernel_name):
    """
    Clears log files and other run related files for a given kernelt
    """
    cmd = f"find {LOGS_ROOT_DIR}/{input_kernel_name}/* -type f  -or -type d | grep -vE 'gpuwattch_gtx480.xml|gpgpusim.config|config_fermi_islip.icnt|{input_kernel_name}.cu|input.txt|input.csv' | xargs rm -R -f"
    result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip(" \n")
    print(result)
    cmd = f"rm -rf {PTRACE_ROOT_DIR}/{input_kernel_name}/gpgpusim_outputs/* && rm -rf {PTRACE_ROOT_DIR}/{input_kernel_name}/ptraces/*"
    result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip(" \n")
    print(result)

def move_logs(input_kernel_name, folder_suffix):
    """
    Moves log files appropriate folders
    """
    logs_path = Path(f"{LOGS_ROOT_DIR}/{input_kernel_name}/")
    excluded_file_names = ['gpuwattch_gtx480.xml', 'gpgpusim.config', 'config_fermi_islip.icnt',
     f'{input_kernel_name}.cu', 'input.txt', 'input.csv', f'{input_kernel_name}.out']
    for file in logs_path.glob("*"):
        file_name = str(file).split("/")[-1] 
        if file_name not in excluded_file_names:
            if file_name.startswith("gpgpusim_power_report"):
                derive_path = f"{PTRACE_ROOT_DIR}/{input_kernel_name}/gpgpusim_outputs/args_{folder_suffix}/gpgpusim_power_report_{input_kernel_name}_args_{folder_suffix}.log"
            else:
                derive_path = f"{PTRACE_ROOT_DIR}/{input_kernel_name}/gpgpusim_outputs/args_{folder_suffix}/{file_name}"
            derived_file = Path(derive_path)
            derived_file.parent.mkdir(parents=True, exist_ok=True)
            file.rename(derived_file)


def replace_line_in_file(input_file, input_search_line, input_replace_line):
    """
    Searches for 'input_search_line' and replaces it with 'input_replace_line' in 'input_file' 
    """
    cmd = f"sed -i 's/^.*{input_search_line}.*$/{input_replace_line}/' {input_file}"
    result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip(" \n")
    print(result)

def run_hotspot(input_kernel_name):
    """
    Executes {input_kernel_name}.sh file
    """
    cmd = f"cd {PTRACE_ROOT_DIR}/{input_kernel_name} && ./run.sh"
    result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip(" \n")
    print(result)