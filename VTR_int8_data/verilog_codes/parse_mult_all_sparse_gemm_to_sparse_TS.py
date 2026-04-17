import os
import re
import pandas as pd # type: ignore


#specify the parent dir
parent_dir = "mult_seeds_all_sparse_gemm_to_sparse_TS"


def TS_input_pin_utilization_model(X, Y):

    b_data = 128
    a_data = 40
    K_size = 12
    sparsity_level = 2
    enable = 1
    accumulate = 1

    first_row_X_inputs = b_data + a_data + K_size + sparsity_level + enable + accumulate

    rest_X_Y_inputs = a_data + K_size + sparsity_level + enable

    average_in_pin_util = (X*first_row_X_inputs + (X*Y- X)*rest_X_Y_inputs)/(X*Y)

    return average_in_pin_util
    

def CB_area_model(total_inputs):

    CB_mux_area_um2_with_SRAM = 2.207

    MWTA_area_nm2 = 13122

    CB_mux_area_MWTA = CB_mux_area_um2_with_SRAM * 1000000 / MWTA_area_nm2

    total_CB_area = total_inputs * CB_mux_area_MWTA

    return total_CB_area


def logic_area_model(FLEs, TSs, BRAMs, DSPs):

    CLB_area = 25928
    TS_area = 174906
    DSP_area = 187122
    BRAM_area = 137668

    total_logic_area = (FLEs/10)*CLB_area + TSs*TS_area + BRAMs*BRAM_area + DSPs*DSP_area

    return total_logic_area

def SB_area_model(total_segments, wire_util):

    SB4_mux_area_with_SRAM_um2 = 1.527

    MWTA_area_nm2 = 13122

    SB4_mux_area_MWTA = SB4_mux_area_with_SRAM_um2 * 1000000 / MWTA_area_nm2

    # as calculated in OneNote page "FPGA Routing Area"
    SB16_mux_area_MWTA = 396.096214

    X4_wires = total_segments['X4'] * wire_util['X4']
    Y4_wires = total_segments['Y4'] * wire_util['Y4']
    
    X16_wires = total_segments['X16'] * wire_util['X16']
    Y16_wires = total_segments['Y16'] * wire_util['Y16']

    L4_wires = X4_wires + Y4_wires
    L16_wires = X16_wires + Y16_wires

    total_SB_area = SB4_mux_area_MWTA * L4_wires + SB16_mux_area_MWTA * L16_wires

    return total_SB_area






def extract_wiring_data_from_lines(lines):
    # Regular expressions to extract the required data
    direction_pattern = re.compile(r'\s*(X|Y)\s+(\d+)\s+(\d+)')
    utilization_pattern = re.compile(r'\s*(\d+)\s+([\d.]+)')

    # Dictionaries to store the extracted data
    total_numbers = {'X4': 0, 'Y4': 0, 'X16': 0, 'Y16': 0}
    utilizations = {'X4': 0.0, 'Y4': 0.0, 'X16': 0.0, 'Y16': 0.0}

    direction = None

    for line in lines:
        # Extract total numbers
        match = direction_pattern.match(line)
        if match:
            dir_label, length, number = match.groups()
            key = f"{dir_label}{length}"
            if key in total_numbers:
                total_numbers[key] = int(number)
            continue

        # Check for utilization section
        if "X - Directed Wiring Segment usage by length:" in line:
            direction = "X"
            continue
        elif "Y - Directed Wiring Segment usage by length:" in line:
            direction = "Y"
            continue

        # Extract utilizations
        if direction:
            match = utilization_pattern.match(line)
            if match:
                length, utilization = match.groups()
                key = f"{direction}{length}"
                if key in utilizations:
                    utilizations[key] = float(utilization)

    return total_numbers, utilizations



def extract_fle(s):
    # Regular expression pattern to extract integers
    pattern = r'\d+'
    match = re.search(pattern, s)
    if match:
        return int(match.group())
    else:
        raise ValueError("No integer found in the string")


def extract_total_wirelength(s):
    # Regular expression pattern to extract the total wirelength value
    pattern = r'Total wirelength: (\d+)'
    match = re.search(pattern, s)
    if match:
        total_wirelength = int(match.group(1))  # Extract and convert to integer
        return total_wirelength
    else:
        raise ValueError("Total wirelength not found in the string")
    

def extract_X_Y_values(s):
# Regular expression pattern to match X and Y values
    pattern = r'X_(\d+)Y_(\d+)'
    match = re.match(pattern, s)
    if match:
        X_value = int(match.group(1))  # Extract X value (first group)
        Y_value = int(match.group(2))  # Extract Y value (second group)
        return X_value, Y_value
    else:
        raise ValueError("String format does not match expected pattern")

def get_immediate_subdirectories(a_dir):
    return [name for name in os.listdir(a_dir)
            if os.path.isdir(os.path.join(a_dir, name))]


def extract_fmax_value(input_string):
    # Regular expression to find the Fmax value
    fmax_pattern = r"Fmax:\s*([\d.]+)\s*MHz"
    
    # Search the pattern in the input string
    match = re.search(fmax_pattern, input_string)
    
    if match:
        # Extract the value and convert it to a float
        fmax_value = float(match.group(1))
        return fmax_value
    else:
        return None


def extract_integer_from_string(s):
    # Regular expression to find the integer value
    match = re.search(r'\d+', s)
    if match:
        return int(match.group(0))
    return None

def sort_strings_by_integer(strings):
    # Sort the strings using the extracted integer values
    sorted_strings = sorted(strings, key=extract_integer_from_string)
    return sorted_strings


def extract_usage_and_in_pin_utilization(lines):
    # Regular expression pattern to extract relevant data
    pattern = re.compile(r'(\S+)\s+(\d+)\s+([\d.]+)\s+([\d.]+)')
    
    data = []
    for line in lines:
        match = pattern.match(line.strip())
        if match:
            block_type = match.group(1)
            num_blocks = int(match.group(2))
            avg_input_pins = float(match.group(3))
            
            data.append([block_type, num_blocks, avg_input_pins])

    # Create a Pandas DataFrame
    df = pd.DataFrame(data, columns=['Block Type', 'Usage', 'In_pin_utilization'])
    
    return df


VTR_ROOT="/home/et23644@austin.utexas.edu/Desktop/VTR_dir/vtr-verilog-to-routing_april2024"


temp_dir_path = VTR_ROOT + "/vtr_work/out_dir/" + parent_dir

# get all x_y sub dirs
x_y_dir_list = get_immediate_subdirectories(temp_dir_path)

# sort the x_y_dir
x_y_dir_list = sort_strings_by_integer(x_y_dir_list)

# dictionary for dataframe
dict_dataframe = {'Cfg':[],
                'seeds':[],
                'Fmax':[],
                'CLBs':[],
                'TSs':[],
                'BRAMs':[],
                'DSPs':[],
                'CB_area':[],
                'SB_area':[],
                'Logic_area':[],
                'Total_area':[],
                'Wirelength':[]}

# Create DataFrame
df = pd.DataFrame(dict_dataframe)


for x_y_dir in x_y_dir_list:

    seed_dir_path = temp_dir_path + "/" + x_y_dir

    # dir list for seeds
    seed_dir_list = get_immediate_subdirectories(seed_dir_path)

    
    fmax_list = []

    # for all seeds
    for seed_dir in seed_dir_list:

        sub_dir_vpr_out = seed_dir_path + "/" + str(seed_dir) + "/vpr.out"

        with open(sub_dir_vpr_out, "r") as fp:

            #read all lines
            lines = fp.readlines()
            for line in lines:
                
                # find the line of Fmax
                if (line.find("""Final critical path delay (least slack)""")!= -1):

                    fmax_value = extract_fmax_value(line)

                    fmax_list.append(fmax_value)



    fmax_value = max(fmax_list)

    # find index of fmax value
    index_fmax = fmax_list.index(fmax_value)

    # this is the seed of the fmax
    # use this for every metrics you need to extract (e.g., wirelengh, resource util., etc)
    fmax_seed_dir = seed_dir_list[index_fmax]

    fmax_dir_vpr_out = seed_dir_path + "/" + str(fmax_seed_dir) + "/vpr.out"

    # get X, Y values 
    X_val, Y_val = extract_X_Y_values(str(x_y_dir))

    with open(fmax_dir_vpr_out, "r") as fp:

        #read all lines
        lines = fp.readlines()

        for i, line in enumerate(lines):

            # find the resource usage and input pin utilization
            if (line.find("""Block Type   # Blocks   Avg. # of input clocks and pins used   Avg. # of output pins used""")!= -1):

                df_usage_pin_util = extract_usage_and_in_pin_utilization(lines[i:i+8])

                for index, row in df_usage_pin_util.iterrows():

                    if (row['Block Type'] == 'clb'):
                        CLBs = row['Usage']
                        CLB_util = row['In_pin_utilization']

                    if (row['Block Type'] == 'sparse_dense_ts_top'):
                        TSs = row['Usage']
                        TS_util = TS_input_pin_utilization_model(X_val, Y_val)

                    if (row['Block Type'] == 'dsp_top'):
                        DSPs = row['Usage']
                        DSP_util = row['In_pin_utilization']

                    if (row['Block Type'] == 'memory'):
                        BRAMs = row['Usage']
                        BRAM_util = row['In_pin_utilization']

                # calculate the # of total inputs of logic blocks
                total_inputs = CLBs*CLB_util + TSs*TS_util + BRAMs*BRAM_util + DSPs*DSP_util

                # get the total CB_area of the design
                CB_area = CB_area_model(total_inputs)


            # find the used FLEs
            if (line.find("""Pb types usage...""")!= -1):

                j = i + 1
                while (lines[j].find("""fle""")== -1):
                    j = j + 1

                FLEs = extract_fle(lines[j])

                logic_area = logic_area_model(FLEs, TSs, BRAMs, DSPs)

                # better format for readability
                logic_area = f"{logic_area:.6e}"


            # find total wirelength
            if (line.find("""Total wirelength""")!= -1):

                wirelength = extract_total_wirelength(line)


            # find total wirelength
            if (line.find("""Total Number of Wiring Segments by Direction""")!= -1):

                total_segments, wire_util = extract_wiring_data_from_lines(lines[i:i+16])

                SB_area = SB_area_model(total_segments, wire_util)


        # total used area of the design
        total_design_area = float(logic_area) + float(SB_area) + float(CB_area)

    # save data to dataframe
    df.loc[len(df.index)] = [x_y_dir, len(fmax_list), fmax_value, CLBs, TSs, BRAMs, DSPs, CB_area, SB_area, logic_area, total_design_area, wirelength]



print(df)
      