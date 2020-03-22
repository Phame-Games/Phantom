#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''LocalTest
   Test Python code functionality without server connection
'''

#Imports
#game outside of interaction
from action import load_actions
from character import load_characters

from unit import Unit
import interaction as inter

__author__ = "Gabriel Frey"

#Functions
def main():
    print("##############################")
    print("Setup Game Outside of Interaction")
    print("##############################")
    #load from external files
    load_actions()
    load_characters()

    #setup units
    units = []

    #create static unit for the entire game
    units.append(Unit("Isaiah"))
    units.append(Unit("Gabe"))

    #add characters
    units[0].add_character("Zomboy")

    units[1].add_character("Zomboy")
    units[1].add_character("Radioactive Meerkat")
    units[1].add_character("Radioactive Meerkat")

    print("##############################")
    print("Setup Interaction")
    print("##############################")

    inter.interaction(units[0], units[1])

print()
if __name__ == "__main__":
    main()
