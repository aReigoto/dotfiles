import re
from pathlib import Path

O2_syntax_path = Path( '../syntax/O2.vim' )
O2_spell_path = Path( 'O2.dic' )

keyWords = list()

with open(O2_syntax_path , 'r', encoding='utf8', ) as f:
    for line in f:
        for word in line.split():
            if matches := re.match(r'^([A-Z]+)$', word):
                # print(matches.groups(), word)
                keyWords.append(matches.groups()[0])


keyWords.sort()

header = """# Key words in O2
# :help spell-file-format
"""

with open(O2_spell_path, 'w', encoding='utf8') as f:
    f.write(header)
    f.writelines("%s\n" % l for l in keyWords)
