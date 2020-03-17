#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Unit
   Group of characters
"""

#imports
from character import create_character
from action import *

__author__ = "Gabriel Frey"

class Unit:
    def __init__(self):
        self.characters = []
        #selected character
        self.sel_character = 0
        
        self.name = "Unit"
        
        #TODO - add external
        hp = 100
        attack_multiplier = 1.0
        defense_multiplier = 5
        character_type = 0
        
        #multiple characters
        self.team = False
        #[constant, temp]
        self.relationship = [0, 0]
        self.notoriety = [0, 0]

    def add_character(self, character_name):
        character = create_character(character_name)
        if character != -1:
            self.characters.append(character)
        else:
            print("Adding character {} failed.".format(character_name))
    
    def get_character(self):
        return self.characters[self.sel_character]
    
    def get_do_list(self):
        #[team, realtionship ID,
        #self.relation_ship[0] = rels.find_relationship()
        [self.team, 0, self.relationship, self.notoriety, get_character_relation_list()]