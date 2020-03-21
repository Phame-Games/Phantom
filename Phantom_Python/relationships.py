#Relationships.py
#Isaiah Frey
#Apocolypse game

#add one intitial entry, general world relation
relationship_master = [[]]

#Functions
def add_relation(inst):
    '''add entity to the master relationship table
       inst - default relation value
       return the relation id, column index
    '''
    #column's relation with row
    cols = len(relationship_master)
    
    new_col = []
    #add new entity's relation with each existing entity
    for i in range(cols):
        new_col.append(inst)
    #add new column for new entity
    relationship_master.append(new_col)
    print(relationship_master)
    #relationship id
    return cols

def initialize_relationship_table(num_characters):
    relationship_master = [[] for i in range(num_characters-1)]
    for i in range(len(relationship_master)):
        relationship_master[i] = [60 for j in range(num_characters-1-i)]

def find_relationship(p1_index, p2_index):
    '''
    print(relationship_master)
    print(p1_index)
    print(p2_index)
    '''
    if p1_index < p2_index:
        interaction_relationship = relationship_master[p2_index][p1_index]
    else:
        interaction_relationship = relationship_master[p1_index][p2_index]
    return interaction_relationship
    #player1[2][0] = interaction_relationship
    #player2[2][0] = interaction_relationship

def set_relationship(p1_index, p2_index, relation):
    '''
    print(relationship_master)
    print(p1_index)
    print(p2_index)
    '''
    if p1_index < p2_index:
        relationship_master[p2_index][p1_index] = relation
    else:
        relationship_master[p1_index][p2_index] = relation