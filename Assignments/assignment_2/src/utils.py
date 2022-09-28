from constants import ABS_ROOT_DIR, CACHE_CONFIG_FILE_PATH, LOGS_ROOT_DIR

import subprocess
import os
import glob
import matplotlib.pyplot as plt

def clear_logs():
    files = glob.glob(f'{LOGS_ROOT_DIR}/**/*.log')
    for f in files:
        os.remove(f)
        
def change_param(config_pattern, config_value, file_name=CACHE_CONFIG_FILE_PATH):
    # create the sed command dynamically 
    cmd  = f"sed -i 's/{config_pattern}.*/{config_pattern} {config_value}/' {file_name}"
    # call a subprocess, messy but works!
    subprocess.run(cmd, shell=True)

def read_results(results_file_name, property_name):
    # Example command
    # grep 'Data array: Area (mm2):' test.txt | sed 's/^.*: //'
    cmd  = f"grep '{property_name}' {results_file_name} | sed 's/^.*: //'"
    result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip("\n")
    return result

def run_cacti(path_to_log_file, path_to_cacti=f"{ABS_ROOT_DIR}/cacti/cacti", config_file=CACHE_CONFIG_FILE_PATH):
    # cacti executable results in segmentation fault when it is executed from another directory
    cmd  = f"cd {ABS_ROOT_DIR}/cacti/ && {path_to_cacti} -infile {config_file}"
    with open(path_to_log_file, "w") as outfile:
        subprocess.run([cmd], shell=True, stdout=outfile, stderr=outfile)

def plot_results(x, y, title, legend_title, color, xlabel, ylabel):
    figure, axis = plt.subplots(nrows=1, ncols=1, sharex=False,)
    plt_obj = axis
    plt_obj.plot(x, y, marker='o', color=color, linestyle='--', label=legend_title) 
    plt_obj.set_title(title) #, loc='center')
    plt_obj.set_xlabel(xlabel)
    plt_obj.set_ylabel(ylabel)    
    plt_obj.legend()