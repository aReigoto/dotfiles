#!/usr/bin/env python3

import json
from sys import argv
from urllib import request    
from pkg_resources import parse_version    

def versions(pkg_name):
    url = f'https://pypi.python.org/pypi/{pkg_name}/json'
    releases = json.loads(request.urlopen(url).read())['releases']
    return sorted(releases, key=parse_version, reverse=False)

if __name__ == '__main__':
    print(*versions(argv[1]), sep='\n')

