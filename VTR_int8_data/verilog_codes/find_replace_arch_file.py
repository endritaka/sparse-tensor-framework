
# this function modifies the arch file FPGA grid size
# width = X*12 + 10
# height = Y*5 + 10
def modify_FPGA_size(arch_file, X, Y):

    with open(arch_file, "r") as fp:

        #read all lines
        lines = fp.readlines()
        for line in lines:
            
            # find the line
            if (line.find("""<fixed_layout name="fixed_layout_custom""")!= -1):
                
                # replace it with new width and height values
                #  <fixed_layout name="fixed_layout_custom" width="130" height="60">
                lines[lines.index(line)] =  """    <fixed_layout name="fixed_layout_custom" width=" """ + str(X*12+10) + """ " height=" """ + str(Y*5+10) + """ ">\n"""

    with open(arch_file, "w") as fp:
        fp.writelines(lines) 



# modify_FPGA_size(arch_path, 5, 5)