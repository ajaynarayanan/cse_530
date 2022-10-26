# File related constants
ABS_ROOT_DIR="/home/ajay/Documents/CSE_530/Assignments/assignment_3"
LOGS_ROOT_DIR=f"{ABS_ROOT_DIR}/quicksort/"

X86MinorCPU="X86MinorCPU"
X86TimingSimpleCPU="X86TimingSimpleCPU"

LPDDR2Speed1066="LPDDR2_S4_1066_1x32"
DDDR3Speed1600="DDDR3_1600_8x8"
DDDR3Speed2133="DDDR3_2133_8x8"

# log file paramter pattern constants
X86_TIMING_PARAM_PATTERNS=[
    "simSeconds", "simInsts", "system.cpu.numCycles", "system.cpu.numInsts"
    # FU ops distribution
    "system.cpu.exec_context.thread_0.statExecutedInstType::IntAlu", "system.cpu.committedInstType_0::IntMult",
    # mem read/write
    "system.cpu.exec_context.thread_0.statExecutedInstType::MemRead", "system.cpu.exec_context.thread_0.statExecutedInstType::MemWrite",
    "system.mem_ctrls.avgRdBWSys", "system.mem_ctrls.avgWrBWSys",
    # miss latency 
    "system.cpu.dcache.overallAvgMissLatency::total", "system.l2.overallAvgMissLatency::total",
    # power metrics
    "system.mem_ctrls.dram.rank0.averagePower", "system.mem_ctrls.dram.rank1.averagePower",
    # energy metrics
    "system.mem_ctrls.dram.rank0.totalEnergy", "system.mem_ctrls.dram.rank1.totalEnergy"
]

X86_MINOR_PARAM_PATTERNS=[
    "simSeconds", "simInsts", "system.cpu.numCycles", "system.cpu.numInsts"
    # FU ops distribution 
    "system.cpu.committedInstType_0::IntAlu",  "system.cpu.committedInstType_0::IntMult",
    # mem read/write
    "system.cpu.committedInstType_0::MemRead", "system.cpu.committedInstType_0::MemWrite",
    "system.mem_ctrls.avgRdBWSys", "system.mem_ctrls.avgWrBWSys",
    # miss latency 
    "system.cpu.dcache.overallAvgMissLatency::total", "system.l2.overallAvgMissLatency::total",
    # power metrics
    "system.mem_ctrls.dram.rank0.averagePower", "system.mem_ctrls.dram.rank1.averagePower",
    # energy metrics
    "system.mem_ctrls.dram.rank0.totalEnergy", "system.mem_ctrls.dram.rank1.totalEnergy"

]

