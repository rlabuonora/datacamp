
from get_text_from_file import get_text_from_file

french_article = get_text_from_file("./french_article.txt")

import polyglot
from polyglot.text import Text

txt = Text(french_article)


for ent in txt.entities:
    print(ent, type(ent))
    
    
bergara = get_text_from_file("./bergara_bcu.txt")

txt = Text(bergara)

tagged = [(ent.tag, ' '.join(ent)) for ent in txt.entities]
print(tagged)
