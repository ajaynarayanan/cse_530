

from __future__ import print_function
from __future__ import absolute_import

import argparse
import sys
import os

import m5
from m5.objects import *

m5.util.addToPath('/home/other/CSE530-FA2022/gem5')

# Add the common scripts to our path
m5.util.addToPath('/home/other/CSE530-FA2022/gem5/configs')

from caches import *
from common import Options
from common import SimpleOpts
from common import Simulation
from common import MemConfig
import a4CPUConfig

def addAdditionalOptions(parser):
    parser.add_argument("--cse530-core-config", type = str, default = "large",
                      help = "Large or small")

    parser.add_argument("--binfile", type = str, default = "",
                      help = "path to the binary file")
    parser.add_argument("--binargs", type = str, default = "",
                      help = "arguments to the binary")

    parser.add_argument("--cse530-issue-width", action="store", 
                      type=int, help="""issue width""", default=8)
    parser.add_argument("--cse530-store-queue-size", action="store",
                      type=int, help="""store queue size""", default=32)
    parser.add_argument("--cse530-load-queue-size", action="store",
                      type=int, help="""load queue size""", default=32)
    parser.add_argument("--cse530-num-regs", action="store", type=int,
                      help="""num physical regs""", default=256)
    parser.add_argument("--cse530-num-robs", action="store", type=int,
                      help="""num reorder buffer entries""", default=192)
    parser.add_argument("--branch-predictor", action="store", type=str,
                      help="""branch predictor type (2bit, tournament, bimode, ltage)""", default="2bit")


parser = argparse.ArgumentParser()
Options.addCommonOptions(parser)
addAdditionalOptions(parser)

options = parser.parse_args()

binary=options.binfile
binargs=options.binargs
thispath = os.path.dirname(os.path.realpath(__file__))
if binary=="":
  print('Input the path to the binary')
  exit(1)

# create the system we are going to simulate
system = System()

# Set the clock fequency of the system (and all of its children)
system.clk_domain = SrcClockDomain()
system.clk_domain.clock = '2GHz'
system.clk_domain.voltage_domain = VoltageDomain()

# Set up the system
system.mem_mode = 'timing'               # Use timing accesses
system.mem_ranges = [AddrRange('512MB')] # Create an address range

# Create a process 
process = Process()
# Set the command 
process.cmd = [binary, binargs]

# Create a memory bus
system.membus = SystemXBar()

# Create a simple CPU
cpu = a4CPUConfig.createCPU(options, process, system)

# Connect the system up to the membus
system.system_port = system.membus.cpu_side_ports

# Create a DDR3 memory controller
#system.mem_ctrl = DDR3_1600_8x8()
#system.mem_ctrl.range = system.mem_ranges[0]
#system.mem_ctrl.port = system.membus.mem_side_ports
MemClass = Simulation.setMemClass(options)
MemConfig.config_mem(options, system)

# set up the root SimObject and start the simulation
root = Root(full_system = False, system = system)
# instantiate all of the objects we've created above
m5.instantiate()

print("Beginning simulation!")
exit_event = m5.simulate()
print('Exiting @ tick %i because %s' % (m5.curTick(), exit_event.getCause()))
