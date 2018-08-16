#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun  4 22:30:18 2018

@author: rafa
"""

# read data files in
import glob
files = glob.glob("Wikipedia articles/*.txt")

# Todo: helper to reuse



arts = [get_text_from_file(p) for p in files ]

from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords

english_stopwords = stopwords.words('english')

tokenized_articles = [word_tokenize(art) for art in arts ]

articles = [[token.lower() for token in article 
                             if token.isalpha() and 
                                token not in english_stopwords] 
                           for article in tokenized_articles]



from nltk.stem import WordNetLemmatizer
from nltk.corpus import stopwords

# Import Dictionary
from gensim.corpora.dictionary import Dictionary

# Create a Dictionary from the articles: dictionary
dictionary = Dictionary(articles)

# Select the id for "computer": computer_id
#computer_id = dictionary.token2id.get("computer")

# Use computer_id with the dictionary to print the word
#print(dictionary.get(computer_id))

corpus = [dictionary.doc2bow(article) for article in articles]

# Create a MmCorpus: corpus
#corpus = [dictionary.doc2bow(article) for article in articles]

# Print the first 10 word ids with their frequency counts from the fifth document
#print(corpus[4][:10])

doc = corpus[4]

# Import tf-idf model

from nltk.tokenize import sent_tokenize

sentences = sent_tokenize(article)
