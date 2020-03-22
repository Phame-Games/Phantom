#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Action
   
"""

#imports
from pyexcel_ods import get_data

__author__ = "Gabriel Frey"

#list of actions
action_dict = {}
action_list = []

#Defining actions
action_class = {"attack": 0, "defend": 1, "charm": 2, "intimidate": 3}

#Functions
#load external list of all actions
def load_actions():
    data = get_data("data.ods")
    #print(data)
    #get amount of actions listed in file
    action_amount = len(data["actions"])
    #start in row 1 to skip headers, -1 since it ends with a blank row
    for i in range(1, action_amount):
        #check for empty row
        if len(data["actions"][i]) > 0:
            add_action(data["actions"][i])
    
    #print results
    print("load_actions results:")
    print("action_dict:")
    print(action_dict)
    print("action_list:")
    index = 0
    for action in action_list:
        print("{}: {}".format(index, str(action)))
        index += 1

#add action to dictionary and list
def add_action(action_data):
    print("Load action: " + str(action_data))
    #attempt to create action
    try:
        action = Action(action_data)
    except TypeError:
        print("Error: Action {} creation failed.".format(action_data[0]))
    else:
        #get what index in the list this action will be for the dictionary
        action_index = len(action_list)
        #add name reference
        action_dict[action_data[0]] = action_index
        #add action
        action_list.append(action)

def get_action(action_index):
    action = []
    try:
        action = action_list[action_index].action
    except IndexError:
        print("Action index {} is not inside the action list!".format(action_index))
        action = action_list[action_dict["none"]].action
    return action

#specific action
class Action:
    def __init__(self, ad):
        '''
           ad - action data
        '''
        self.name = ad[0]
        #action class; attack, defense, charm, intimidate   
        try:
            self.class_index = action_class[ad[1]]
        except KeyError:
            print("Error: Action {} creation failed. Action Class not valid: '{}'. Please use a valid option: ".format(self.name, action_data[1]))
            print(action_class.keys())
            #raise a type error, return an int instead of None
            return -1
        self.level = ad[3]
        
        self.action = [[[ad[4], ad[5], ad[6], ad[7]], [ad[8], ad[9], ad[10], ad[11]]], [[ad[12], ad[13], ad[14], ad[15]], [ad[16], ad[17], ad[18], ad[19]]], [[ad[20], ad[21], ad[22], ad[23]], [ad[24], ad[25], ad[26], ad[27]]], [[ad[28], ad[29], ad[30], ad[31]], [ad[32], ad[33], ad[34], ad[35]]], [[ad[36], ad[37], ad[28], ad[39]], [ad[40], ad[41], ad[42], ad[43]]], ad[44], ad[45], ad[46], [[ad[47], ad[48]], [ad[49], ad[50]]], [ad[51], ad[52]]]
        #creation succesful
        #print(self.action)
    
    def __str__(self):
        class_name = list(action_class.keys())[list(action_class.values()).index(self.class_index)]
        string = "{} - {}".format(self.name, class_name)
        return string
    
    def get_class(self):
        """Return class index
        """
        return self.class_index