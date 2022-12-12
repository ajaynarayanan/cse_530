from pathlib import Path
import csv

def dict_to_file(input_dict, file_name):
    """
    Writes the given input_dict to a file 
    """

    Path(file_name).parent.mkdir(parents=True, exist_ok=True)
    with open(file_name, 'w') as f:  # You will need 'wb' mode in Python 2.x
        w = csv.DictWriter(f, input_dict.keys(), delimiter ='\t', quoting=csv.QUOTE_NONE)
        w.writeheader()
        w.writerow(input_dict)

def read_csv_to_list_of_dict(file_name):
    """
    Reads a csv file as a list of dictionaries
    """
    # open file in read mode
    with open(file_name, 'r') as f:
        dict_reader = csv.DictReader(f)    
        list_of_dict = list(dict_reader)
        
    return list_of_dict
