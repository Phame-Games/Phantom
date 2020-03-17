#Interactions
#Isaiah Frey
#Uses new, many variable, single algorithm method of handling attacks.

#Input:
#Player's variables
#Characters' in interactions variables
#The chosen action's variables for each character

#Libraries
from random import randint

def do_actions(player1, player2, character1, charater2, action1, action2):
	debug = True

	#-------------------------Tables-----------------------------------------#
	###### Relationships must be determined prior to the interaction
	#Input the number of characters (players counting as 1) for the relationship table
	#num_characters = 2
	#Massive table of all relationships based on ID numbers i.e. [[0 and 1, 0 and 2, 0 and 3], [1 and 2, 1 and 3], [2 and 3]]
	#relationship_master = [[] for i in range(num_characters-1)]
	#for i in range(len(relationship_master)):
	#	relationship_master[i] = [60 for j in range(num_characters-1-i)]

	#Table of all the damage multipliers for all types
	type_table = [[1, .5, 2, 1, 1, 1, .5, 2, .5, 2, 1], 
				[1, 1, 1, 1, 1, 1, 2, .5, 2, 1, 1],
				[1, .5, 1, 2, 1, 1, 1, .5, 1, 2, 1],
				[2, 1, .5, 1, 2, 2, 1, .5, 1, 1, 2],
				[1, 2, 1, 1, 1, .5, 2, 1, 2, 1, .5],
				[1, 1, 1, .5, 2, 1, .5, 2, 1, 2, .5],
				[1, .5, 2, .5, .5, 2, 1, 2, .5, 1, .5],
				[1, 2, 2, 1, 1, .5, .5, 1, 1, 1, 2],
				[2, .5, 1, .5, .5, 2, 1, 1, 1, 2, 2],
				[.5, 2, 2, 1, .5, .5, 1, .5, 1, 1, 1],
				[1, 1, 1, .5, 1, 1, 2, 1, .5, 1, 1]]
	#------------------------------------------------------------------------#

	#Input each player's (or character's if not on a team) player variables
	#First input the variables for the attacker [Is this a team?, id, [interaction_relationship, relationship temp], [notoriety, notoriety_temp], [team relationship]]
	#player1 = [True, 0, [0, 0], [0, 0], [65, 75]]
	#player2 = [False, 1, [0, 0], [0, 0], []]

	######## Relationship must be determined before the interaction begins, this method could be used
	#Find the interaction_relationship from the table

	#Types
	#[0]Radioactive
	#[1]Undead
	#[2]Light
	#[3]Dark
	#[4]Fire
	#[5]Flood
	#[6]Plague
	#[7]Chaos
	#[8]Alien
	#[9]Robot
	#[10]Frozen
	#Next input the characters' variables that are competing [number on team, id, type, [hp, hp_temp, dmg taken this turn], [attack multiplier, attack_temp], [defense, defense temp], [ongoing dmg, # of turns], befriended(bool), intimidated, fled(bool), stunned(bool)]
	#character1 = [0, 10, 0, [100, 0, 0], [1.0, 0], [5, 0], [0, 0], False, False, False, False]
	#character2 = [0, 11, 1, [100, 0, 0], [1.05, 0], [2, 0], [0, 0], False, False, False, False]

	#Finally set the chosen actions' variables [hp, attack, defense, relationship, player notoriety, speed, accuracy, variance, damage threshhold, stun]
	#[0]hp
	#[1]attack
	#[2]defense
	#[3]relationship
	#[4]notoriety
	#[5]speed
	#[6]accuracy (0-100)
	#[7]damage_threshhold
	#[8]stun
	#[9]flee
	#Actions stats used based on [[successful move/dmg threshold met], [move failed/dmg threshold not met]]
	#Subsets [Opponent Interaction, Self Interaction, ]
	#Base Action
	#action = [[[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], 0, 0, 0, [[0, 0], [0, 0]], [0, 0]]

	#Set action for player 1 and 2
	#Slap action
	#action1 = [[[-10, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], 60, 90, 0, [[0, 0], [0, 0]], [0, 0]]
	#action1 = [[[-30, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, -10]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], 70, 60, 0, [[0, 0], [0, 0]], [0, 0]]
	#Guard action
	#action2 = [[[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 35, 0, 4], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], [[0, 0, 0, 0], [0, 0, 0, 0]], 100, 95, 0, [[0, 0], [0, 0]], [0, 0]]

	#Returns the effect after considering both player's moves
	def calculate_action(action1, action2, character1, character2, player1, player2):
		#Character/Player 1 is doing the action (action1), Character/Player 2 is the opponent
		#First take ongoing damage and check if the character is still alive
		character1[3][0] -= character1[6][0]
		character1[6][1] -= 1
		if character1[6][1] <= 0:
			character1[6][0] = 0
			character1[6][1] = 0
		if character1[3][0] <= 0:
			return character1, character2, player1, player2

		#If alive, decide if the action hit
		if randint(0,100) > action1[6]:
			#If the action misses set the failed variable
			failed = True
			if debug: print("The attack missed!")
		#If the action is successful
		else:
			#Then check to see if the action has a damage threshold and if it was hit
			if action1[7] == 0:
				failed = False
			elif action1[7] > character1[3][2]:
				if debug: print("Damage threshold not met!")
				failed = True
			else:
				failed = False

		#------------------Relationship--------------------------#
		#Decide which set of stats to use depending on success, failed, or damage threshhold being met
		if not failed:
			relationship = action1[3][0]
		else:
			relationship = action1[3][1]

		#If the player is charming, attempt to befriend the opponent
		if (relationship[2] + player1[2][1]) > 0:
			#If the opponent is not part of a team, they are easier to befriend
			if player2[0] == False:
				if (player1[2][0] + (relationship[2] + player1[2][1])) < 70 or randint(0,12000) >= (player1[2][0] + relationship[2])**2:
					failed = True
				else:
					if debug: print("Opponent befriended!")
					character2[7] = True
			#If part of a team, they are harder to befriend
			else:
				if (player1[2][0] + (relationship[2] + player1[2][1])) < 70 or randint(0,12000) >= (player1[2][0] + relationship[2] - (player2[4][character2[0]]/2))**2:
					failed = True
				else:
					if debug: print("Opponent befriended!")
					character2[7] = True
		else:
			player1[2][1] = 0

		#Player Relationship with opponent, interaction
		player1[2][0] += relationship[0]
		#Reset one turn relationship for player
		if player1[2][1] > 0:
			player1[2][1] = 0

		#Opponent relationship with player, one turn and interaction
		player2[2][1] += relationship[3]
		player2[2][0] += relationship[1]
		#------------------END Relationship----------------------#

		#---------------------Notoriety--------------------------#
		#Decide which set of stats to use depending on success, failed, or damage threshhold being met
		if not failed:
			notoriety = action1[4][0]
		else:
			notoriety = action1[4][1]
		#If the player is intimidating, attempt to scare the opponent away
		if (notoriety[2] + player1[3][1]) > 0:
			#If the opponent is not part of a team they are easier to intimidate
			if player2[0] == False:
				if randint(0,80) > (player1[3][0] + (notoriety[2] + player1[3][1])) - (player2[3][0] + player2[3][1]) + ((character2[3][0] + charater2[3][1]) - (character1[3][0] + character1[3][1]))/2:
					failed = True
				else:
					if debug: print("Damage threshold not met!")
					character2[8] = True
			#If the opponent is part of a team, they are more difficult to intimidate
			else:
				if randint(0,80) > (player1[3][0] + (notoriety[2] + player1[3][1])) - (player2[3][0] + player2[3][1]) + ((character2[3][0] + charater2[3][1]) - (character1[3][0] + character1[3][1]))/2:
					failed = True
				else:
					if debug: print("Damage threshold not met!")
					character2[8] = True
		else:
			player1[3][1] = 0

		#Player notoriety interaction
		player1[3][0] += notoriety[0]
		#Reset one turn notoriety for player
		if player1[3][1] > 0:
			player1[3][1] = 0

		#Opponent relationship with player, one turn and interaction
		player2[3][1] += notoriety[3]
		player2[3][0] += notoriety[1]	
		#------------------END Notoriety----------------------#

		#--------------------HP---------------------------#
		#Decide which set of stats to use depending on success, failed, or damage threshhold being met
		if not failed:
			hp = action1[0][0]
		else:
			hp = action1[0][1]
		#Lookup the damage multiplier for types from the table
		type_multiplier = type_table[character1[2]][character2[2]]

		#Opponent damage/healing for interaction and one turn
		#If the player is doing damage to the oppponent, factor in the opponent's defense
		for i in [0,2]:
			if hp[i] < 0:
				#Multiply the attack by the multipliers (type and attack)
				hp[i] *= type_multiplier
				hp[i] *= (character1[4][0] + character1[4][1])
				hp[i] = round(hp[i])
				#Calculate damage from character1 to character2. The damage is reduced by the opponents defense. There is also a chance the attack will be blocked if the opponent is defending.	
				if character2[5][1] > 0:
					if randint(0,100) - hp[i] > (character2[5][0] + character2[5][1]):
						hp[i] += character2[5][0]
						if hp[i] > 0:
							hp[i] = 0
					else:
						if debug: print("Attack was blocked!")
						hp[i] = 0
			if i == 0:
				#After damage/healing is calculated, change the other player's hp and set damage dealt
				character2[3][0] += (hp[i] + character2[5][0])
				if debug:
					if hp[i] != 0:
						print(f"{-1*hp[i]} damage dealt.")
				character2[3][2] += hp[i]
			if i == 2:
				character2[3][1] += hp[i]
			#Check if dead
			if (character2[3][0] + character2[3][1]) <= 0:
				return character1, character2, player1, player2

		#Self damage/healing interaction and one turn
		for i in [1,3]:
			if hp[i] < 0:
				hp[i] *= (character1[4][0] + character1[4][1])
				hp[i] = round(hp[i])
			if i == 1:
				#After damage/healing is calculated, change the other player's hp
				character1[3][0] += hp[i]
			if i == 3:
				character1[3][1] = hp[i]
			#Check if dead
			if (character1[3][0] + character1[3][1]) <= 0:
				return character1, character2, player1, player2
		#--------------------END HP---------------------------#

		#--------------------Attack---------------------------#
		#Decide which set of stats to use depending on success, failed, or damage threshhold being met
		if not failed:
			attack = action1[1][0]
		else:
			attack = action1[1][1]
		character1[4][0] += attack[0]
		character1[4][1] = attack[1]
		character2[4][0] += attack[2]
		character2[4][1] += attack[3]
		#------------------END Attack---------------------------#

		#--------------------Defense----------------------------#
		#Decide which set of stats to use depending on success, failed, or damage threshhold being met
		if not failed:
			defense = action1[2][0]
		else:
			defense = action1[2][1]
		character1[5][0] += defense[0]
		character1[5][1] += defense[1]
		character2[5][0] += defense[2]
		if character2[5][1] < 0:
			character2[5][1] = 0
		character2[5][1] += defense[3]
		#------------------END Defense---------------------------#

		#---------------------Stun----------------------------#
		#Decide which set of stats to use depending on success, failed, or damage threshhold being met
		if not failed:
			stun = action1[8][0]
		else:
			stun = action1[8][1]
		if randint(0, 100) < stun[0]:
			character2[10] = True
			if debug: print("Character stunned!")
		if randint(0,100) < stun[1]:
			character1[10] = True
			if debug: print("Character stunned!")
		#------------------END Stun---------------------------#

		#--------------------Flee-----------------------------#
		#Decide which set of stats to use depending on success, failed, or damage threshhold being met
		if not failed:
			flee = action1[9][0]
		else:
			flee = action1[9][1]
		#If the opponent is not part of a team, it is easier to flee
		if player2[0] == False:
			if randint(0, 100) < flee:
				character1[9] = True
		else:
			if randint(0, 100) < flee/2:
				character1[9] = True
		#------------------END Flee---------------------------#

		#Return all modified character and player variables
		return character1, character2, player1, player2

	#---------------------------------------MAIN-------------------------------------#
	#Now the variables are set, the interaction begins by calculating variables for the fastest move
	if action1[5] > action2[5]:
		if debug: print()
		if debug: print("Player 1 attacks first!")
		character1, character2, player1, player2 = calculate_action(action1, action2, character1, character2, player1, player2)
		if debug: print()
		if debug: print("Player 2 attacks next!")
		character2, character1, player2, player1 = calculate_action(action2, action1, character2, character1, player2, player1)

	elif action2[5] > action1[5]:
		if debug: print()
		if debug: print("Player 2 attacks first!")
		character2, character1, player2, player1 = calculate_action(action2, action1, character2, character1, player2, player1)
		if debug: print()
		if debug: print("Player 1 attacks next!")
		character1, character2, player1, player2 = calculate_action(action1, action2, character1, character2, player1, player2)

	else:
		if randint(0,1):
			if debug: print()
			if debug: print("Player 1 attacks first!")
			character1, character2, player1, player2 = calculate_action(action1, action2, character1, character2, player1, player2)
			if debug: print()
			if debug: print("Player 2 attacks next!")
			character2, character1, player2, player1 = calculate_action(action2, action1, character2, character1, player2, player1)
		else:
			if debug: print()
			if debug: print("Player 2 attacks first!")
			character2, character1, player2, player1 = calculate_action(action2, action1, character2, character1, player2, player1)
			if debug: print()
			if debug: print("Player 1 attacks next!")
			character1, character2, player1, player2 = alculate_action(action1, action2, character1, character2, player1, player2)

	#At the end of the round, set any positive, temporary defense variables for the players to 0
	if character1[5][1] > 0:
		character1[5][1] = 0
	if character2[5][1] > 0:
		character2[5][1] = 0

	#RETURN CHARACTER AND PLAYER VARIABLES TO MAIN PROGRAM HERE AND WAIT FOR ANOTHER ACTION INPUT
	if debug:
		print()
		print("RESULTS")
		print(f"Character 1 stats: {character1}")
		print(f"Character 2 stats: {character2}")
		print(f"Player 1 stats: {player1}")
		print(f"Player 2 stats: {player2}")

	return player1, player2, character1, character2, action1, action2
