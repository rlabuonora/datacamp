#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jun  6 09:23:57 2018

@author: rafa
"""
# Todo: helper to reuse
def get_text_from_file(path):
    with open(path, encoding='utf-8') as f:
        article = f.read()
    return(article)
    

article = get_text_from_file("./article2.txt")


from nltk.tokenize import word_tokenize
from nltk.tokenize import sent_tokenize

sentences = sent_tokenize(article)


token_sentences = [word_tokenize(sent) for sent in sentences]
pos_senteces = [nltk.pos_tag(sent) for sent in token_sentences]

chunked_senteces = nltk.ne_chunk.sent(pos)