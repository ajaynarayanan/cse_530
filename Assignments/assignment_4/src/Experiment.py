
class Experiment():
    def __init__(self, name):
        self.experiment_index = None
        self.pipeline_width = None
        self.rob_entries  = None
        self.branch_predictor = None
        self.experiment_name = name
        # extract attributes from the name
        self.__extract_attributes(name)

    def __extract_attributes(self, name):
        
        attrs = name.split("_")
        # name is in the following format 
        # exp_{experiment_index}_{pipeline_width}_width_{rob_entries}_rob_{branch_predictor}_predictor
        # set experiemnt_index
        self.experiment_index = int(attrs[1])

        # set pipeline_width
        self.pipeline_width = int(attrs[2])
        
        # set rob_entries
        self.rob_entries = int(attrs[4])

        # set branch_predictor
        self.branch_predictor = attrs[6]

    def __str__(self):
        return f"{self.experiment_name} ::: {self.pipeline_width} pipeline width, {self.rob_entries} ROB entries, {self.branch_predictor} branch predictor"

    __repr__ = __str__