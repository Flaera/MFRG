from bge import logic


def Update(cont):
    own = cont.owner
    with open(logic.expandPath("//data_files/gold.txt"), 'r') as gold_file:
        own["Text"] = gold_file.read()