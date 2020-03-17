#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''LocalTest
   Test Python code functionality without server connection
'''

#imports
from unit import *
import action

__author__ = "Gabriel Frey"

#Functions
def unit_turn(Unit, computer):
    '''complete one unit turn
       Unit - Unit object
       computer - whether or not unit is computer controlled
    '''
    continue_interaction = True

    Character = Unit.get_character()
    
    #interaction options
    print("{}'s Turn".format(Unit.name))
    print("1: Do Character Action")
    print("2: Propose Truce")

    try:
        interaction_choice = int(input("Choose option number: "))
    except:
        print("Invalid Input")
        continue_interaction = False
    else:
        if interaction_choice == 1:
            #character action
            Character.print_actions()
            try:
                #get action choice
                action_choice = str(input("Choose action: "))
            except:
                print("Invalid Input")
                continue_interaction = False
            else:
                #check if action is in character
                if Character.check_action(action_choice):
                    #do action
                    do_actions(unit[0].get_do_list(), unit[1].get_do_list(), unit[0].get_character.get_do_list(), unit[1].get_character.get_do_list(), action1, action2)
                else:
                    print("Action is not available for this character")
        elif interaction_choice == 2:
            #propose truce
            asdf = 3
        else:
            print("Not one of the options")
    
    return continue_interaction
            
#setup actions
action.load_actions()

#setup units
units = []
units.append(Unit())
units.append(Unit())

#add characters
units[0].add_character("Zomboy")
units[1].add_character()

#setup interaction
continue_interaction = True

#begin interaction
print("##############################")
print("Begin Interaction")
print("##############################")
while(continue_interaction):
    continue_interaction = unit_turn(units[0], False)
