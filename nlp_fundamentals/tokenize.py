#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jun  3 10:03:16 2018

@author: rafa
"""
from nltk.tokenize import word_tokenize
from nltk.tokenize import sent_tokenize

with open('grail.txt', encoding='utf-8') as f:
    monty_python = f.read()


scene_one = monty_python[0:2513]
sentences = nltk.sent_tokenize(scene_one)

# tokenize the fourth sentence
tokenized_sent = nltk.word_tokenize(sentences[3])

unique_tokens = set(word_tokenize(scene_one))