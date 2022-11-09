from constants import LOGS_ROOT_DIR, PARAM_PATTERNS
from Experiment import Experiment

import glob
import subprocess

def parse_log(results_file_name, property_name):
    """
    This function reads the value for the given `property_name` from `results_file_name` 
    using grep, sed and head
    grep 'simSeconds' 07_x86_timing_1ghz_ddr3_2133.txt | sed 's/simSeconds//' | sed 's/#.*//' | head  -1
    1) search for `property_name` in `results_file_name` using grep
    2) remove `property_name` from the match using sed
    3) remove everything after '#' in the match using sed
    4) extract only the first match     
    """
    cmd  = f"grep '{property_name}' {results_file_name} | sed 's/{property_name}//' | sed 's/#.*//' | head  -1"
    result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip(" \n")
    return result.split()


def collect_all_params(results_file_name, params):
    """
    Returns a dictionary with key as param name and value as param value
    """
    result = {}
    for param in params:
        result[param] = parse_log(results_file_name, param)
    return result

def collect_experiments():
    files = glob.glob(f'{LOGS_ROOT_DIR}/**/*.txt')
    results = {}
    for file in files:
        exp_name = file.split("/")[-2]
        print(f"Parsing data for {exp_name}")
        experiment = Experiment(exp_name)
        results[experiment] = collect_all_params(file, PARAM_PATTERNS)
    return results
