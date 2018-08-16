#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun  4 09:20:17 2018

@author: rafa
"""

from collections import Counter
from nltk.tokenize import word_tokenize

with open('article.txt', encoding='utf-8') as f:
    article = f.read()


tokens = word_tokenize(article)

lower_tokens = [t.lower() for t in tokens ]

bow_simple = Counter(lower_tokens)

print(bow_simple.most_common(10))


from nltk.stem import WordNetLemmatizer
from nltk.corpus import stopwords


alpha_only = [t for t in lower_tokens if t.isalpha()]

english_stops = stopwords.words('english')
no_stops = [t for t in alpha_only if t not in english_stops]


wordnet_lemmatizer = WordNetLemmatizer()


lemmatized = [wordnet_lemmatizer.lemmatize(t) for t in no_stops]

from collections import Counter

bow = Counter(lemmatized)

print(bow.most_common(10))
