# File related constants
ABS_ROOT_DIR="/home/ajay/Documents/CSE_530/Assignments/assignment_4"
LOGS_ROOT_DIR=f"{ABS_ROOT_DIR}/cse530_a4/results/"
BINARY_FILE_NAME="runbinaries.sh"

ROB_ENTRIES=[16, 32, 64, 128, 192]
PIPELINE_WIDTH=[2, 4, 6, 8]
BRANCH_PREDICTOR=["2bit", "tournament", "bimode", "ltage"]


# log file paramter pattern constants
PARAM_PATTERNS=[
    "simSeconds", "simInsts", "system.cpu.numCycles", "system.cpu.numInsts", "system.cpu.ipc", "system.cpu.commit.branchMispredicts",
    # ROB full events, IQ full events
    "system.cpu.rename.ROBFullEvents", "system.cpu.rename.IQFullEvents", "system.cpu.rename.blockCycles",
    # Squash cycles 
    "system.cpu.numSquashedInsts", "system.cpu.iew.squashCycles", "system.cpu.fetch.squashCycles", "system.cpu.decode.squashCycles",
    # FU ops distribution
    "system.cpu.commit.committedInstType_0::IntAlu", "system.cpu.committedInstType_0::IntMult",
    # mem read/write
    "system.cpu.commit.committedInstType_0::MemRead", "system.cpu.commit.committedInstType_0::MemWrite",
    "system.mem_ctrls.avgRdBWSys", "system.mem_ctrls.avgWrBWSys",
    # miss latency 
    "system.cpu.dcache.overallAvgMissLatency::total", "system.l2cache.overallAvgMissLatency::total",
    # power metrics
    "system.mem_ctrls.dram.rank0.averagePower", "system.mem_ctrls.dram.rank1.averagePower",
    # energy metrics
    "system.mem_ctrls.dram.rank0.totalEnergy", "system.mem_ctrls.dram.rank1.totalEnergy"
]
