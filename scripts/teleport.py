#!/usr/bin/env python3

# %%
from os import environ
from json import load as jload
from json import dump as jdump
from pathlib import Path
from re import match, IGNORECASE
from sys import exit
from subprocess import run, PIPE, call 
# %%
# environ["TLP_DIR"] = "."
base_dir = Path.home() / '.local' / 'state' / 'teleport'
TLP_FILE = base_dir / 'teleport-paths.json'
PORTAL_PATH = base_dir / 'portal'
EDITOR = environ.get('EDITOR', default='nvim') #that easy!
# %%
help = """Teleport [portal_alias | portal_n] [(-c | --create) [portal_alias] [-e | --edit] [-h | --help] 
where:
    -c | --create   :  create a portal in pwd
    -d | --destroy  :  destroy a portal
    -e | --edit     :  edit the portals list
    -h | --help     :  show this help text
    -p | --print    :  print the portals list
    -q | --quit     :  abort the teleportation
"""

# %%
def white_portal(path='.'):
    with open(PORTAL_PATH, "w") as f:
        f.write(path)

def save(TLP_FILE, portals):
    #print(portals)
    print('... Saving ...')
    if not TLP_FILE.parent.exists():
        TLP_FILE.parent.mkdir(parents=True)

    with open(TLP_FILE, "w") as write_file:
        jdump(portals, write_file, indent=4)

def load(TLP_FILE):
    if not TLP_FILE.exists():
        return dict()

    with open(TLP_FILE, "r") as read_file:
        portals = jload(read_file)
    return portals

# %%
def printEnumDict(dictionary):
    km = len(max(dictionary.keys(), key=len))
    im = len(str(len(dictionary)))
    align_n = f'>{im}'
    align_k = f'<{km}'

    if dictionary:
        print("\nUse the provided options or teleport now by potal number or portal alias")

    for i, kv in enumerate(dictionary.items()):
        k, v = kv
        print(f'\t{i:{align_n}}: {k:{align_k}} => {v}')

# %%
def yes_or_no(question=''):
    # ()?  optional group
    # (?:) non-capturing group

    print(f'{question}\nYes or no?')
    string = input('> ')
    r = r'((y(?:es)?)|(n(?:o)?))'
    if ( m:=match(r, string, IGNORECASE) ):
        # print(m.groups())
        # first = next(item for item in m.groups()[1:] if item is not None)
        if m.groups()[1]:
            return True
        else:
            return False 
    else:
        print('Invalid awnser!')
        return yes_or_no(question)

# %%
def get_alias():
    print('Please provide a valid alias for the portal')
    alias = input('> ')
    return alias

def get_alias_or_n():
    print('Please provide a valid alias for the portal')
    alias = input('> ')
    return alias


# %%
def go(portals, alias=None, n=None):
    if isinstance(alias, str) and alias in portals:
        # environ["TLP_DIR"] = str(portals[alias])
        white_portal(path=str(portals[alias]))
        return True
    elif isinstance(n, int) and n in list(range(len(portals))):
        alias = list(portals.keys())[n]
        # environ["TLP_DIR"] = str(portals[alias])
        white_portal(path=str(portals[alias]))
        return True
    else:
        return False

def create_portal(portals, alias=None, path=None):
    if not path:
        path = str(Path.cwd())

    if alias and alias not in portals:
        portals[alias] = path
        return portals
    else:
        return False

def deleat_portal(portals, alias=None, n=None):
    if isinstance(alias, str) and alias in portals:
        portals.pop(alias)
        return portals
    elif isinstance(n, int) and n in list(range(len(portals))):
        alias = list(portals.keys())[n]
        portals.pop(alias)
        return portals
    else:
        return False

def help_meassage():
    print(help)

def edit_portarls():
    call([EDITOR, TLP_FILE])

def menu_create(portals, alias=None):
    portals_tmp = create_portal(portals, alias)
    if portals_tmp:
        portals = portals_tmp
    #if (portals:= create_portal(portals, alias)):
        save(TLP_FILE, portals)
        return
    else:
        alias = get_alias()
        menu_create(portals, alias=alias)

def menu_destroy(portals, guess=None):
    try:
        n = int(guess)
        alias = None
    except ValueError:
        alias = guess
        n = None

    portals_tmp = deleat_portal(portals, alias=alias, n=n)
    if portals_tmp:
        portals = portals_tmp
        save(TLP_FILE, portals)
        return
    else:
        guess = get_alias_or_n()
        menu_destroy(portals, guess=guess)

# %%
def menu(portals):
    anwser = input('> ')
    if ( m:=match(r'^(-c|--create)(?:$|\s+)(.*)?', anwser, IGNORECASE) ):
        groups = m.groups()
        if len(groups) > 0:
            menu_create(portals, alias=groups[1])
        else:
            menu_create(alias=None)

    elif  ( m:=match(r'^(-d|--destroy)(?:$|\s+)(.*)?', anwser, IGNORECASE) ):
        groups = m.groups()
        if len(groups) > 0:
            menu_destroy(portals, guess=groups[1])
        else:
            menu_destroy(portals, guess=None)

    elif  ( m:=match(r'^(-e|--edit)', anwser, IGNORECASE) ):
        edit_portarls()
        return menu(portals)

    elif  ( m:=match(r'^(-h|--help)$', anwser, IGNORECASE) ):
        help_meassage()
        return menu(portals)

    elif  ( m:=match(r'^(-p|--print)$', anwser, IGNORECASE) ):
        printEnumDict(portals)
        return menu(portals)

    elif  ( m:=match(r'^(-q|--quit)$', anwser, IGNORECASE) ):
        exit(0)

    elif  ( m:=match(r'^(\d+)$', anwser, IGNORECASE) ):
        # print(m.groups())
        if go(portals, n=int(m[0])):
            exit(0)
        else:
            print('No portal with that number, please try again!')
            return menu(portals)

    elif  ( m:=match(r'^(\S+)$', anwser, IGNORECASE) ):
        if go(portals, alias=m[0]):
            exit(1)
        else:
            print('No portal with that alias, please try again!')
            return menu(portals)

    else:
        print('Invalid anser, please try again!')
        return menu(portals)


# %%
if __name__ == '__main__':
    # white_portal()
    portals = load(TLP_FILE)
    
    help_meassage()
    if portals: 
        printEnumDict(portals)
    menu(portals)
