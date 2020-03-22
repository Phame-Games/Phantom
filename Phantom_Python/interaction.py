#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""interaction
   
"""

#Imports
import relationships as rels
import action as act
import Interactions

import copy

#graphics
import tkinter

__author__ = "Gabriel Frey"

#Functions
def choose_unit_action(Unit):
    #options
    print("{}'s Turn".format(Unit.get_name()))
    print("1: Flee")
    print("2: Propose Truce")
    print("3: Switch Characters")
    print("4: Do an Action")
    print("5: Print Debug")

    try:
        interaction_choice = int(input("Choose option number: "))
        if not(0 < interaction_choice < 6):
            raise ValueError("Not one of the options")
    except TypeError:
        print("Invalid Input")
    except ValueError:
        print("Not one of the options")
    else:
        if interaction_choice == 5:
            #print out all info
            Unit.print_debug()
            return choose_unit_action(Unit)
        return interaction_choice

    return(-1)

def flee(Unit):
    print(Unit.get_name() + " flee'd")
    return True

def truce(Unit):
    return True

def switch_character(Unit):
    print("{} Switch Characters".format(Unit.get_name()))
    Unit.print_all_characters()

    try:
        choice = int(input("Choose character number: "))
        if not(0 <= choice < len(Unit.get_characters())):
            raise ValueError("Not one of the options")
    except TypeError:
        print("Invalid Input")
    except ValueError:
        print("Not one of the options")
    else:
        Unit.switch_character(choice)
    
def choose_action(Unit):
    '''have unit choose an action
       Unit - Unit object
    '''
    Character = Unit.get_character()
    
    #interaction options
    print("{} Choose an Action".format(Unit.get_name()))

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
            Unit.set_action(action_choice)
        else:
            print("Action is not available for this character")

def do_actions(Unit1, Unit2):
    results = Interactions.do_actions(Unit1.get_do_list(Unit2), Unit2.get_do_list(Unit1), Unit1.get_character().get_do_list(), Unit2.get_character().get_do_list(), copy.deepcopy(act.get_action(Unit1.get_action())), copy.deepcopy(act.get_action(Unit2.get_action())))

    #interpret results
    #[player1, player2, character1, character2]
    Unit1.set_do_results(Unit2, results[0])
    Unit2.set_do_results(Unit1, results[1])
    Unit1.get_character().set_do_results(results[2])
    Unit2.get_character().set_do_results(results[3])

def update_debug(units):
    #update all debug windows
    for Unit in units:
        Unit.Debug.update()

def interaction(Unit1, Unit2):
    '''main interaction function
    '''

    #setup interaction
    continue_interaction = True
    units = []   
    
    #create temporary unit wrappers for this interaction
    units.append(wUnit(Unit1))
    units.append(wUnit(Unit2))
    
    #begin interaction
    print("##############################")
    print("Begin Interaction")
    print("##############################")
    
    while(continue_interaction):
        update_debug(units)

        #reset all temporary variables
        for Unit in units:
            Unit.reset()
        
        input("Continue?")
        update_debug(units)

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
        if continue_interaction and 2 in unit_action_types:
            for index in range(len(unit_actions)):
                if unit_actions[index] == 2:
                    if truce(units[index]):
                        continue_interaction = False
                        break
        #Switch Characters
        if continue_interaction and 3 in unit_action_types:
            for index in range(len(unit_actions)):
                if unit_actions[index] == 3:
                    switch_character(units[index])
        #Do an Action
        update_debug(units)
        if 4 in unit_action_types:
            #choose actions
            for index in range(len(unit_actions)):
                if unit_actions[index] in {4, 2}:
                    print(unit_actions[index])
                    choose_action(units[index]) 

            update_debug(units)
            input("Continue?")

            #do action
            do_actions(units[0], units[1])
            
            #check if interaction ended
            for Unit in units:
                if True in set(Unit.get_character().results):
                    continue_interaction = False
                    break

#Classes
class wUnit:
    def __init__(self, Unit):
        '''temporary (interaction only) wrapper class
           holds all interaction only variables and methods
           creates interaction only wrapper characters
        '''
        #unit this class is temporarily wrapping
        self.Unit = Unit
        
        #interaction only varaibles
        self.relationship = 0
        self.notoriety = 0
        self.action = 0#none action
        
        #interaction only character wrappers
        self.characters = []
        for Character in Unit.characters:
            self.characters.append(wCharacter(Character))

        #create debug window to follow
        self.Debug = dUnit(self)
    
    def reset(self):
        self.action = 0#none action
    
    def set_action(self, action):
        self.action = act.action_dict[action]
    
    def get_action(self):
        return self.action
    
    def get_do_list(self, other):
        #unit is a team if there are multiple characters
        team = len(self.Unit.characters) > 1
        #[team, relationship ID,
        #self.relation_ship[0] = rels.find_relationship()
        #print(self.Unit.relationship_id)
        #print(other.Unit.relationship_id)
        relation = rels.find_relationship(self.Unit.relationship_id, other.Unit.relationship_id)
        #print(relation)
        return [team, relation, [self.Unit.relationship, self.relationship], [self.Unit.notoriety, self.notoriety], self.Unit.get_character_relation_list()]
    
    def set_do_results(self, other, results):
        #update relation
        rels.set_relationship(self.Unit.relationship_id, other.Unit.relationship_id, results[1])
        self.Unit.relationship = results[2][0]
        self.relationship = results[2][1]
        self.Unit.notoriety = results[3][0]
        self.notoriety = results[3][1]
        self.Unit.set_character_relations(results[4])
    
    #Debug
    def print_debug(self):
        print("{}'s Debug Info".format(self.get_name()))
        print("Team: ", len(self.Unit.characters) > 1)
        print("Relationship ID: ", self.Unit.relationship_id)
        print("Relationships: ", [self.Unit.relationship, self.relationship])
        print("Notorieties: ", [self.Unit.notoriety, self.notoriety])
        print("Character Relations: ", self.Unit.get_character_relation_list())
        print("{}'s Character Info".format(self.get_name()))
        for Character in self.characters:
            Character.print_debug()
        
    #Wrapper functions
    def get_name(self):
        return self.Unit.name
    
    def get_character(self):
        return self.characters[self.Unit.sel_character]
    
    def get_characters(self):
        return self.Unit.characters
    
    def switch_character(self, index):
        return self.Unit.switch_character(index)
    
    def print_all_characters(self):
        return self.Unit.print_all_characters()


class wCharacter:
    def __init__(self, Character):
        '''temporary (interaction only) wrapper class
           holds all interaction only variables and methods
        '''
        self.Character = Character
        #[hp, hp_temp, dmg taken this turn]
        self.hp_temp = 0
        self.turn_dmg = 0
        #[attack_multiplier, attack_temp]
        self.attack = 0
        #[defense_multiplier, defense_temp]
        self.defense = 0
        #[ongoing damage, number of turns]
        self.persistent_damage = [0, 0]
        #[befrieneded, intimidated, fled, stunned]
        self.results = [False, False, False, False]
    
    #Interaction functions
    def get_do_list(self):
        #[number on team, relationship ID
        team_index = self.Character.get_team_index()
        relation = rels.find_relationship(self.Character.relationship_id, self.Character.Unit.relationship_id)
        hp = [self.Character.hp, self.hp_temp, self.turn_dmg]
        attack = [self.Character.attack, self.attack]
        defense = [self.Character.defense, self.defense]
        return [team_index, relation, self.Character.get_type(), hp, attack, defense, self.persistent_damage, self.results[0], self.results[1], self.results[2], self.results[3]]
    
    def set_do_results(self, results):
        #update relation
        rels.set_relationship(self.Character.relationship_id, self.Character.Unit.relationship_id, results[1])
        #hp
        self.Character.hp = results[3][0]
        self.hp_temp = results[3][1]
        self.turn_dmg = results[3][2]
        #attack
        self.Character.attack = results[4][0]
        self.attack = results[4][1]
        #defense
        self.Character.defense = results[5][0]
        self.defense = results[5][1]
        
        self.persistent_damage = results[6]
        self.results = [results[7], results[8], results[9], results[10]]
    
    #Debug
    def print_debug(self):
        print("{}'s Debug Info".format(self.Character.name))
        print("Team Index: ", self.Character.get_team_index())
        print("HP: ", [self.Character.hp, self.hp_temp, self.turn_dmg])
        print("Attack: ", [self.Character.attack, self.attack])
        print("Defense: ", [self.Character.defense, self.defense])
        print("Persistent damage: ", self.persistent_damage)
    
    #Wrapper functions
    def check_action(self, action_name):
        return(self.Character.check_action(action_name))
    
    def print_actions(self):
        return(self.Character.print_actions())

class dUnit:
    def __init__(self, wUnit):
        self.wUnit = wUnit
        self.win = tkinter.Tk()
        self.Unit = self.wUnit.Unit
        self.win.title(self.wUnit.get_name())
        self.lbl_name = tkinter.Label(self.win, text = "{}'s Debug Info".format(self.wUnit.get_name()))
        self.lbl_team = tkinter.Label(self.win, text = "Team: {}".format(len(self.Unit.characters) > 1))
        self.lbl_relID = tkinter.Label(self.win, text = "Relationship ID: {}".format(self.Unit.relationship_id))
        self.lbl_rels = tkinter.Label(self.win, text = "Notorieties: {}".format([self.Unit.notoriety, self.wUnit.notoriety]))
        self.lbl_noto = tkinter.Label(self.win, text = "Character Relations: {}".format(self.Unit.get_character_relation_list()))
        self.lbl_chars = tkinter.Label(self.win, text = "{}'s Character Info".format(self.wUnit.get_name()))
        self.unit_labels = []
        self.unit_labels.append(tkinter.Label(self.win, text = f"Action: {act.get_action(self.wUnit.get_action())}"))

        self.lbl_name.grid(column = 0)
        self.lbl_team.grid(row = 1)
        self.lbl_relID.grid(row = 2)
        self.lbl_rels.grid(row = 3)
        self.lbl_noto.grid(row = 4)
        for i in range(len(self.unit_labels)):
            self.unit_labels[i].grid(row = 5 + i)
        self.lbl_chars.grid(row = 5 + len(self.unit_labels))

        self.character_labels = []
        ii = len(self.unit_labels)
        for Character in self.wUnit.characters:
            labels = []
            labels.append(tkinter.Label(self.win, text = "{}'s Debug Info".format(Character.Character.name)))
            labels.append(tkinter.Label(self.win, text = "Team Index: {}".format(Character.Character.get_team_index())))
            labels.append(tkinter.Label(self.win, text = "HP: {}".format([Character.Character.hp, Character.hp_temp, Character.turn_dmg])))
            labels.append(tkinter.Label(self.win, text = "Attack: {}".format([Character.Character.attack, Character.attack])))
            labels.append(tkinter.Label(self.win, text = "Defense: {}".format([Character.Character.defense, Character.defense])))
            labels.append(tkinter.Label(self.win, text = "Persistent damage: {}".format(Character.persistent_damage)))

            #make all visible
            for i in range(len(labels)):
                labels[i].grid(row = 6 + ii)
                ii += 1
            self.character_labels.append(labels)
        #self.win.mainloop()

        self.win.minsize(256, 256)

    def update(self):
        self.lbl_name.configure(text = "{}'s Debug Info".format(self.wUnit.get_name()))
        self.lbl_team.configure(text = "Team: {}".format(len(self.Unit.characters) > 1))
        self.lbl_relID.configure(text = "Relationship ID: {}".format(self.Unit.relationship_id))
        self.lbl_rels.configure(text = "Notorieties: {}".format([self.Unit.notoriety, self.wUnit.notoriety]))
        self.lbl_noto.configure(text = "Character Relations: {}".format(self.Unit.get_character_relation_list()))
        self.lbl_chars.configure(text = "{}'s Character Info".format(self.wUnit.get_name()))

        self.unit_labels[0].configure(text = f"Action: {act.get_action(self.wUnit.get_action())}")

        i = 0
        for labels in self.character_labels:
            wCharacter = self.wUnit.characters[i]
            i += 1
            labels[0].configure(text = "{}'s Debug Info".format(wCharacter.Character.name))
            labels[1].configure(text = "Team Index: {}".format(wCharacter.Character.get_team_index()))
            labels[2].configure(text = "HP: {}".format([wCharacter.Character.hp, wCharacter.hp_temp, wCharacter.turn_dmg]))
            labels[3].configure(text = "Attack: {}".format([wCharacter.Character.attack, wCharacter.attack]))
            labels[4].configure(text = "Defense: {}".format([wCharacter.Character.defense, wCharacter.defense]))
            labels[5].configure(text = "Persistent damage: {}".format(wCharacter.persistent_damage))

        '''
        print("{}'s Debug Info".format(self.get_name()))
        print("Team: ", len(self.Unit.characters) > 1)
        print("Relationship ID: ", self.Unit.relationship_id)
        print("Relationships: ", [self.Unit.relationship, self.relationship])
        print("Notorieties: ", [self.Unit.notoriety, self.notoriety])
        print("Character Relations: ", self.Unit.get_character_relation_list())
        print("{}'s Character Info".format(self.get_name()))
        for Character in self.characters:
            Character.print_debug()
        '''