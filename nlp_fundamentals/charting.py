#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun  4 08:52:49 2018

@author: rafa
"""

from matplotlib import pyplot as plt

with open('grail.txt', encoding='utf-8') as f:
    holy_grail = f.read()
    
    
lines = holy_grail.split('\n')

# Cambiar (KING ARTHUR: o SOLDIER #1) por ''
pattern = "[A-Z]{2,}(\s)?(#\d)?([A-Z]{2,})?:"
lines = [re.sub(pattern, '', l) for l in lines]

tokenized_lines = [regexp_tokenize(s, r"\w+") for s in lines]

line_num_words = [ len(t_line) for t_line in tokenized_lines]


plt.hist(line_num_words)
plt.show()