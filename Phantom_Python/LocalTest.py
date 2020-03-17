#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''LocalTest
   Test Python code functionality without server connection
'''

#imports
from unit import *
from character import load_characters
import action

__author__ = "Gabriel Frey"

#Functions
def choose_unit_action(Unit):
    #options
    print("{}'s Turn".format(Unit.name))
    print("1: Flee")
    print("2: Propose Truce")
    print("3: Switch Characters")
    print("4: Do an Action")

    try:
        interaction_choice = int(input("Choose option number: "))
        if not(0 < interaction_choice < 5):
            raise ValueError("Not one of the options")
    except TypeError:
        print("Invalid Input")
    except ValueError:
        print("Not one of the options")
    else:
        return interaction_choice

    return(-1)

def flee(Unit):
    print(Unit.name + " flee'd")
    return True

def truce(Unit):
    return True

def switch_character(Unit):
    print("{} Switch Characters".format(Unit.name))
    Unit.print_all_characters()

    try:
        choice = int(input("Choose character number: "))
        if not(0 <= choice < len(Unit.characters)):
            raise ValueError("Not one of the options")
    except TypeError:
        print("Invalid Input")
    except ValueError:
        print("Not one of the options")
    else:
        Unit.switch_character(choice)
    
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
load_characters()

#setup units
units = []
units.append(Unit())
units.append(Unit())

#add characters
units[0].add_character("Zomboy")
units[1].add_character("Zomboy")
units[1].add_character("Radioactive Meerkat")
units[1].add_character("Radioactive Meerkat")

#setup interaction
continue_interaction = True

#begin interaction
print("##############################")
print("Begin Interaction")
print("##############################")
while(continue_interaction):
    #Unit action
    unit_actions = []
    #get action choices
    for Unit in units:
        unit_actions.append(choose_unit_action(Unit))

    #carry out choices
    unit_action_types = set(unit_actions)
    #Flee
    if 1 in unit_action_types:
        for index in range(len(unit_actions)):
            if unit_actions[index] == 1:
                if flee(units[index]):
                    continue_interaction = False
                    break
    #Propose Truce
    elif continue_interaction and 2 in unit_action_types:
        for index in range(len(unit_actions)):
            if unit_actions[index] == 2:
                if truce(units[index]):
                    continue_interaction = False
                    break
    #Switch Characters
    elif continue_interaction and 3 in unit_action_types:
        for index in range(len(unit_actions)):
            if unit_actions[index] == 3:
                switch_character(units[index])
    #Do an Action
    elif 4 in unit_action_types:
        for index in range(len(unit_actions)):
            flee(units[index])
    
    #continue_interaction = unit_turn(units[0], False)
