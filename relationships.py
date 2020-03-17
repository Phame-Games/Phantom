#Relationships.py
#Isaiah Frey
#Apocolypse game

def initialize_relationship_table(num_characters):
	relationship_master = [[] for i in range(num_characters-1)]
	for i in range(len(relationship_master)):
		relationship_master[i] = [60 for j in range(num_characters-1-i)]

def find_relationship(p1_index, p2_index):
	if p1_index < p2_index:
		interaction_relationship = relationship_master[p1_index][p2_index-p1_index-1]
	else:
		interaction_relationship = relationship_master[p2_index][p1_index-p2_index-1]
	return interaction_relationship
	#player1[2][0] = interaction_relationship
	#player2[2][0] = interaction_relationship