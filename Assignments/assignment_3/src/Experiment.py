from constants import X86MinorCPU, X86TimingSimpleCPU
from constants import DDDR3Speed1600, DDDR3Speed2133, LPDDR2Speed1066

class Experiment():
    def __init__(self, name):
        self.cpu_type = None
        self.clock_freq  = None
        self.mem_type = None
        self.experiment_name = name
        # extract attributes from the name
        self.__extract_attributes(name)

    def __extract_attributes(self, name):

        # set cpu_type
        self.cpu_type = X86MinorCPU if "minor" in name else X86TimingSimpleCPU 
        
        #  set mem_type
        if "ddr3_1600" in name:
            self.mem_type = DDDR3Speed1600
        elif "lpddr2_1066" in name:
            self.mem_type = LPDDR2Speed1066
        else:
            self.mem_type = DDDR3Speed2133
        
        # set clock_freq
        for t in name.split("_"):
            if "mhz" in t:
                self.clock_freq = float(t[:-3])

    @property
    def memory_type_order(self):
        if self.mem_type == LPDDR2Speed1066:
            return 0
        elif self.mem_type == DDDR3Speed1600:
            return 1
        else:
            return 2    


    def __str__(self):
        return f"{self.experiment_name} ::: {self.cpu_type}, {self.clock_freq} Mhz, {self.mem_type}"

    __repr__ = __str__