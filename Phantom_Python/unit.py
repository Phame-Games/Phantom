#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Unit
   Group of characters
"""

#imports
from character import create_character
from action import *
from relationships import add_relation, find_relationship, set_relationship

__author__ = "Gabriel Frey"

class Unit:
    def __init__(self, name):
        self.characters = []
        #selected character
        self.sel_character = 0
        
        self.name = name
        self.computer = False
        
        #TODO - add external
        hp = 100
        attack_multiplier = 1.0
        defense_multiplier = 5
        character_type = 0
        
        self.relationship = 0
        self.notoriety = 0
        
        #relationship_id
        self.relationship_id = add_relation(70)

    def add_character(self, character_name):
        character = create_character(character_name, self)
        if character != -1:
            self.characters.append(character)
        else:
            print("Adding character {} failed.".format(character_name))
    
    def get_character(self):
        return self.characters[self.sel_character]
    
    def get_character_relation_list(self):
        #return a list of this units realtion with each of its characters
        out = []
        for Character in self.characters:
            out.append(find_relationship(self.relationship_id, Character.relationship_id))
            
        print("{}'s Character Relation List: ".format(self.name), out)#debug
        return out
    
    def set_character_relations(self, relations):
        print("Setting relationships for {}'s characters:".format(self.name))
        print("Characters: ", self.characters)
        print("New relation values: ", relations)
        
        for i in range(len(self.characters)):
            set_relationship(self.relationship_id, self.characters[i].relationship_id, relations[i])
    
    def print_all_characters(self):
        print("Selected Character: " + str(self.characters[self.sel_character]))
        print("Character List:")
        for i in range(len(self.characters)):
            print("{}: {}".format(i, str(self.characters[i])))
    
    def switch_character(self, index):
        self.sel_character = index