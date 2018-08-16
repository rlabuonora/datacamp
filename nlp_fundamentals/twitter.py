#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jun  3 21:49:24 2018

@author: rafa
"""
from nltk.tokenize import TweetTokenizer
from nltk.tokenize import regexp_tokenize
from nltk.tokenize import word_tokenize


tweets = ['This is the best #nlp exercise ive found online! #python',
          '#NLP is super fun! <3 #learning',
          'Thanks @datacamp :) #nlp #python']

# Match hashtags
pattern1 = r"#\w+"
regexp_tokenize(tweets[0], pattern1)

# Match hashtags & mentions
pattern2 = r"[#@]\w+"
print(regexp_tokenize(tweets[-1], pattern2))


tknzr = TweetTokenizer()
all_tokens = [tknzr.tokenize(t) for t in tweets]
print(all_tokens)

# Tokenize non-ascii text
german_text = 'Wann gehen wir zum Pizza? 🍕 Und fährst du mit Über?'


# print all words
word_tokenize(german_text)

# tokenize only capital words
capital_words = r"[A-ZÜ]\w+"
print(regexp_tokenize(german_text, capital_words))

# Tokenize emoji
emoji = "['\U0001F300-\U0001F5FF'|'\U0001F600-\U0001F64F'|'\U0001F680-\U0001F6FF'|'\u2600-\u26FF\u2700-\u27BF']"
print(regexp_tokenize(german_text, emoji))