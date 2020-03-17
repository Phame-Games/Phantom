#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Character
   
"""

#imports
import action as act
from pyexcel_ods import get_data
import copy

__author__ = "Gabriel Frey"

character_type = {"Undead": 0, "Radioactive": 1}
character_dict = {}

#Functions
def load_characters():
    data = get_data("data.ods")
    
    #get amount of characters listed in file
    character_amount = len(data["characters"])
    #start in row 1 to skip headers
    for i in range(1, character_amount, 3):
        add_character(data["characters"], i)
    
    #print results
    print("load_characters results:")
    print("character_dict:")
    print(character_dict)

def add_character(data, index):
    print("Load character: " + str(data[index:index + 3]))
    #attempt to create character
    name = data[index][0]
    
    try:
        char_type = character_type[data[index][1]]
        #character entry
        Base_Character = Character(name, char_type, float(data[index][2]), float(data[index][3]), float(data[index][4]), data[index + 1][1:], data[index + 2][1:])
        #character.set_available_actions()
    except KeyError:
        print("Error: Character {} creation failed. {} is not a valid type.".format(name, data[index][1]))
    else:
        #add name reference
        character_dict[name] = Base_Character
	
def create_character(name):
    #check if character is loaded
    try:
        index = character_dict[name]
    except:
        print("Erro: Character {} not in Character Dictionary".format(name))
        return -1
    else:
        return copy.deepcopy(character_dict[name])
    
class Character:
    def __init__(self, name, char_type, attack, defense, speed, available_actions, starting_actions):
        self.name = name
        self.char_type = char_type
        self.attack = attack
        self.defense = defense
        self.speed = speed
        self.available_actions = available_actions
        
        #four sets for the four action classes
        self.actions = [set(), set(), set(), set()]
        #add actions
        for action in starting_actions:
            self.add_action(action) 
        
        #TODO - add external
        hp = 100
        attack_multiplier = 1.0
        defense_multiplier = 5
        character_type = 0
        
        self.character_type = character_type
        #[hp, hp_temp, dmg taken this turn]
        self.hp = [hp, 0, 0]
        #[attack_multiplier, attack_temp]
        self.attack = [attack_multiplier, 0]
        #[defense_multiplier, defenser_temp]
        self.defense = [defense_multiplier, 0]
        #[ongoing damage, number of turns]
        self.persistent_damage = [0, 0]
        #[befrieneded, intimidated, fled, stunned]
        self.results = [False, False, False, False]
        
    def __str__(self):
        return(self.name)
    
    def add_action(self, action_name):
        """Adds action object to character
           action_name - string | name of action
        """
        
        index = act.action_dict.get(action_name, -1)
        if index != -1:
            class_index = act.action_list[index].get_class()
            self.actions[class_index].add(action_name)
            print("Added action {} index: {}".format(action_name, index))
        else:
            print("Error: Action could not be added: {}".format(action_name))
    
    def check_action(self, action_name):
        index = act.action_dict.get(action_name, -1)
        if index != -1:
            class_index = act.action_list[index].get_class()
            if action_name in self.actions[class_index]:
                return(True)
            else:
                return(False)
        else:
            print("Action {} is not loaded!".format(action_name))
    
    def print_actions(self):
        print("{} Actions:".format(str(self)))
        #print header
        class_names = list(act.action_class.keys())
        print("{:10} | {:10} | {:10} | {:10}".format(class_names[0], class_names[1], class_names[2], class_names[3]))
        #print actions
        more_actions = True
        row = 0
        while more_actions:
            #reset check
            more_actions = False
            
            row_string = ""
            #check each action class
            for i in range(0, 4):
                if len(self.actions[i]) > row:
                    #TODO - Converting a set into a list every iteration
                    row_string += "{:13}".format(list(self.actions[i])[row])
                    #check another row
                    if row != len(self.actions[i]) - 1:
                        more_actions = True
                else:
                    row_string += "{:13}".format("")
            #counter
            row += 1
            print(row_string)

    def get_do_list(self):
        #[number on team, relationship ID
        [0, 0, self.character_type, self.hp, self.attack, self.defense, self.persistent_damage, self.results[0], self.results[1], self.results[2], self.results[3]]
                