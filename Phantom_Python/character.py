#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Character
   
"""

#imports
import action as act
from pyexcel_ods import get_data
from relationships import add_relation

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
        #check for empty row
        if len(data["characters"][i]) > 0:
            add_character(data["characters"], i)
    
    #print results
    print("load_characters results:")
    print("character_dict:")
    print(character_dict)

def add_character(data, index):
    print(f"Load character: {str(data[index:index + 3])}")
    #attempt to create character
    name = data[index][0]
    
    try:
        char_type = character_type[data[index][1]]
        #character entry
        Base = Base_Character(name, char_type, float(data[index][2]), float(data[index][3]), float(data[index][4]), float(data[index][5]), data[index + 1][1:], data[index + 2][1:])
        #character.set_available_actions()
    except KeyError:
        print(f"Error: Character {name} creation failed. {data[index][1]} is not a valid type.")
    else:
        #add name reference
        character_dict[name] = Base
	
def create_character(name, Unit):
    #check if character is loaded
    try:
        index = character_dict[name]
    except:
        print(f"Error: Character {name} not in Character Dictionary")
        return -1
    else:
        #copy.deepcopy(character_dict[name])
        c = character_dict[name]
        return Character(c.name, c.char_type, c.hp, c.attack, c.defense, c.speed, c.available_actions, c.starting_actions, Unit)

#Classes
class Base_Character:
    def __init__(self, name, char_type, hp, attack, defense, speed, available_actions, starting_actions):
        self.name = name
        self.char_type = char_type
        self.attack = attack
        self.defense = defense
        self.speed = speed
        self.available_actions = available_actions
        self.starting_actions = starting_actions
        
        #four sets for the four action classes
        self.actions = [set(), set(), set(), set()]
        #add actions
        for action in starting_actions:
            self.add_action(action)
        
        self.character_type = character_type
        #[hp, hp_temp, dmg taken this turn]
        self.hp = hp
    
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

class Character(Base_Character):
    def __init__(self, name, char_type, hp, attack, defense, speed, available_actions, starting_actions, Unit):
        #invoking the __init__ of the parent class  
        Base_Character.__init__(self, name, char_type, hp, attack, defense, speed, available_actions, starting_actions)
        
        self.Unit = Unit
        
        #relationship_id
        self.relationship_id = add_relation(60)
    
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
    
    def get_type(self):
        return self.char_type
    
    def get_team_index(self):
        for i in range(len(self.Unit.characters)):
            if self.Unit.characters[i] == self:
                return i
