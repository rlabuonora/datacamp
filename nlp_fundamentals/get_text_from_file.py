def get_text_from_file(path):
    with open(path, encoding='utf-8') as f:
        article = f.read()
    return(article)
