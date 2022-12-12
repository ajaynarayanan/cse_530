# File related constants
ABS_ROOT_DIR="/home/grads/afs6372/project"
LOGS_ROOT_DIR=f"{ABS_ROOT_DIR}/kernel"
HOTSPOT_ROOT_DIR=f"{ABS_ROOT_DIR}/HotSpot"
PTRACE_ROOT_DIR=f"{ABS_ROOT_DIR}/results"
INPUT_FILE_NAME="input"

KERNELS=["matrix_mul","convolution"] #, "needle_wunsh"]

# log file paramter constants
PARAMS=[
    "KERNEL_POWER",
    "IBP",
    "ICP",
    "DCP",
    "TCP",
    "CCP",
    "SHRDP",
    "RFP",
    "SPP",
    "SFUP",
    "FPUP",
    "SCHEDP",
    "L2CP",
    "MCP",
    "NOCP",
    "DRAMP",
    "PIPEP",
    "IDLE_COREP",
    "CONST_DYNAMICP"    
]

# Default log parameter to hardware component mapper
DEFAULT_PARAM_TO_COMPONENT_MAPPER = {
    "IBP"   :   "SM",   # instruction buffer power
    "ICP"   :   "SM",   # instruction cache power
    "DCP"   :   "SM",   # data cache power
    "TCP"   :   "SM",   # texture cache power
    "CCP"   :   "SM",   # constant cache power
    "SHRDP" :   "SM",   # shared memory power
    "RFP"	:	"SM",   # Register file power
    "SPP"	:	"SM",   # Stream Processor power (ALU unit)
    "SFUP"	:	"SM",   # Special Function Unit Power
    "FPUP"	:	"SM",   # Floating Point Unit Power 
    "SCHEDP"	:	"SM",   # Scheduler Power??
    "L2CP"	:	"L2",   # L2 cache power
    "MCP"	:	"SM",   # Memory Controller power
    "NOCP"	:	"SM",   # ??
    "DRAMP"	:	"DRAM",   # DRAM power
    "PIPEP"	:	"SM",   # Pipeline Duty Cycle power
    "IDLE_COREP"	:	"SM",   # Idle Core power
    "CONST_DYNAMICP"    :	"SM",   # Constant Dynamic Power
}




# AVERAGE_POWER_PARAMS=[
#     "kernel_avg_power",
#     "gpu_avg_IBP",
#     "gpu_avg_ICP",
#     "gpu_avg_DCP",
#     "gpu_avg_TCP",
#     "gpu_avg_CCP",
#     "gpu_avg_SHRDP",
#     "gpu_avg_RFP",
#     "gpu_avg_SPP",
#     "gpu_avg_SFUP",
#     "gpu_avg_FPUP",
#     "gpu_avg_SCHEDP",
#     "gpu_avg_L2CP",
#     "gpu_avg_MCP",
#     "gpu_avg_NOCP",
#     "gpu_avg_DRAMP",
#     "gpu_avg_PIPEP",
#     "gpu_avg_IDLE_COREP",
#     "gpu_avg_CONST_DYNAMICP"
# ]

# MAX_POWER_PARAMS=[
#     "kernel_max_power",
#     "gpu_max_IBP",
#     "gpu_max_ICP",
#     "gpu_max_DCP",
#     "gpu_max_TCP",
#     "gpu_max_CCP",
#     "gpu_max_SHRDP",
#     "gpu_max_RFP",
#     "gpu_max_SPP",
#     "gpu_max_SFUP",
#     "gpu_max_FPUP",
#     "gpu_max_SCHEDP",
#     "gpu_max_L2CP",
#     "gpu_max_MCP",
#     "gpu_max_NOCP",
#     "gpu_max_DRAMP",
#     "gpu_max_PIPEP",
#     "gpu_max_IDLE_COREP",
#     "gpu_max_CONST_DYNAMICP"
# ]


# MIN_POWER_PARAMS=[
#     "kernel_min_power",
#     "gpu_min_IBP",
#     "gpu_min_ICP",
#     "gpu_min_DCP",
#     "gpu_min_TCP",
#     "gpu_min_CCP",
#     "gpu_min_SHRDP",
#     "gpu_min_RFP",
#     "gpu_min_SPP",
#     "gpu_min_SFUP",
#     "gpu_min_FPUP",
#     "gpu_min_SCHEDP",
#     "gpu_min_L2CP",
#     "gpu_min_MCP",
#     "gpu_min_NOCP",
#     "gpu_min_DRAMP",
#     "gpu_min_PIPEP",
#     "gpu_min_IDLE_COREP",
#     "gpu_min_CONST_DYNAMICP"
# ]