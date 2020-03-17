#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Character
   
"""

#imports
import action as act

__author__ = "Gabriel Frey"

class Character:
    def __init__(self):
        #four sets for the four action classes
        self.actions = [set(), set(), set(), set()]
        #TODO - Add actions
        self.add_action("slap")
        self.add_action("guard")
        self.add_action("dsdf")
        self.add_action("sd")
        
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
            print("Action could not be added: {}".format(action_name))
    
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
        print("Character Actions:")
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
                