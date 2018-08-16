#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Now you'll get a chance to write some regular expressions to match digits, 
strings and non-alphanumeric characters. 
Take a look at my_string first by printing it in the IPython Shell, 
to determine how you might best match the different steps.

Note: It's important to prefix your regex patterns with r 
to ensure that your patterns are interpreted in the way you want them to. 
Else, you may encounter problems to do with escape sequences in strings. 
For example, "\n" in Python is used to indicate a new line, but if you use the 
r prefix, it will be interpreted as the raw string "\n" - that is, the character 
"\" followed by the character "n" - and not as a new line.
"""

my_string = ("Let's write RegEx!  Won't that be fun?"
             "I sure think so."
              "Can you find 4 sentences?"
              "Or perhaps, all 19 words?")

sentence_endings = r"[.?!]"

print(re.split(sentence_endings, my_string))

# Find all capitalized words in my_string and print the result

capitalized_word = r"[A-Z]\w+"
print(re.findall(capitalized_word, my_string))

# Split my_string on spaces and print the result

spaces = r"\s+"
print(re.split(spaces, my_string))

digits = r"\d+"
print(re.findall(digits, my_string))