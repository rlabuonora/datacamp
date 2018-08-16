#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jun 23 20:36:45 2018

@author: rafa
"""
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split
import pandas as pd

df = pd.read_csv("fake_or_real_news.csv")
y = df.label
# Split
X_train, X_test, y_train, y_test =  train_test_split(df["text"], y, test_size = 0.33, random_state  =53)


# CountVectorizer for text classification

count_vectorizer = CountVectorizer(stop_words = "english")

count_train = count_vectorizer.fit_transform(X_train)
count_test = count_vectorizer.transform(X_test)

# TfidfVectorizer for text classification




