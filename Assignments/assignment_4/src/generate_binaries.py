from constants import BRANCH_PREDICTOR, PIPELINE_WIDTH, ROB_ENTRIES
from constants import BINARY_FILE_NAME

import itertools

def generate_experiment():
    for (index, element) in enumerate(itertools.product(PIPELINE_WIDTH, ROB_ENTRIES, BRANCH_PREDICTOR)):
        pipeline_width, rob_entries, branch_predictor = element
        exp_name = f"exp_{index+1}_{pipeline_width}_width_{rob_entries}_rob_{branch_predictor}_predictor"
        experiment_sh_string = f'/home/other/CSE530-FA2022/gem5/build_a4/build/X86/gem5.opt --outdir=results/{exp_name} ' \
        + f'--redirect-stdout --redirect-stderr /home/grads/afs6372/cse530_a4/cse530_a4_sys_config.py ' \
        + f'--cse530-core-config=custom --cse530-issue-width={pipeline_width} --cse530-num-robs={rob_entries} ' \
        + f'--branch-predictor "{branch_predictor}" --binfile=/home/grads/afs6372/cse530_a4/benchmarks/Quicksort ' \
        + f'--l1i_size "4kB" --l1d_size "4kB" --l2_size "32kB"'
        yield experiment_sh_string

with open(BINARY_FILE_NAME, 'w') as file:
    for (index, experiment_sh_string) in enumerate(generate_experiment()):
        str = f'echo "running experiment {index+1}"\n{experiment_sh_string}\n'
        file.write(str)
    
