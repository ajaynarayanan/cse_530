import os

import m5

m5.util.addToPath('/home/other/CSE530-FA2022/gem5')

# Add the common scripts to our path
m5.util.addToPath('/home/other/CSE530-FA2022/gem5/configs')

from m5.objects import *

def initializeO3CPU(options, o3cpu):
    o3cpu.fetchWidth = options.cse530_issue_width
    o3cpu.decodeWidth = options.cse530_issue_width
    o3cpu.renameWidth = options.cse530_issue_width
    o3cpu.dispatchWidth = options.cse530_issue_width
    o3cpu.issueWidth = options.cse530_issue_width
    o3cpu.wbWidth = options.cse530_issue_width
    o3cpu.commitWidth = options.cse530_issue_width

    if options.branch_predictor == '2bit':
        o3cpu.branchPred = LocalBP(numThreads=1)
    elif options.branch_predictor == 'tournament':
        o3cpu.branchPred = TournamentBP(numThreads=1)
    elif options.branch_predictor == 'bimode':
        o3cpu.branchPred = BiModeBP(numThreads=1)
    elif options.branch_predictor == 'ltage':
        o3cpu.branchPred = LTAGE(numThreads=1)
    else:
        raise ValueError("Unknown branch predictor")

    o3cpu.numROBEntries = options.cse530_num_robs
    o3cpu.numPhysIntRegs = options.cse530_num_regs
    o3cpu.numPhysFloatRegs = options.cse530_num_regs

    o3cpu.SQEntries = options.cse530_store_queue_size
    o3cpu.LQEntries = options.cse530_load_queue_size

    o3cpu.LSQDepCheckShift = 2

    if options.cse530_issue_width == 2:
        o3cpu.numIQEntries = 16
        o3cpu.LQEntries = 16
        o3cpu.SQEntries = 20
        o3cpu.fuPool = Cse530O4FUPool()
    elif options.cse530_issue_width == 4:
        o3cpu.numIQEntries = 24
        o3cpu.LQEntries = 24
        o3cpu.SQEntries = 30
        o3cpu.fuPool = Cse530O4FUPool()
    elif options.cse530_issue_width == 6:
        o3cpu.numIQEntries = 28
        o3cpu.LQEntries = 42
        o3cpu.SQEntries = 36
        o3cpu.fuPool = Cse530O4FUPool()
    elif options.cse530_issue_width == 8:
        o3cpu.numIQEntries = 64
        o3cpu.LQEntries = 72
        o3cpu.SQEntries = 56
        o3cpu.fuPool = Cse530O8FUPool()
