#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Unit
   Group of characters
"""

#imports
from character import *
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

    def add_character(self):
        self.characters.append(Character())
    
    def get_character(self):
        return self.characters[self.sel_character]
    
    def get_do_list(self):
        #[team, realtionship ID, 
        [self.team, 0, self.relationship, self.notoriety, get_character_relation_list()]