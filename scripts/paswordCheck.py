#!/usr/bin/env python3

# %%
from crypt import crypt
from re import match
from argparse import ArgumentParser
import sys

# %%
parser = ArgumentParser()

parser.add_argument("-p", "--passwords",
                    help="passwords in plain text\n",
                    type=str,
                    default=list(),
                    nargs='+'
                    )

parser.add_argument("-c", "--password_hashed",
                    help="password hashed including salt e.g.\n\t$6$CwsdfgHksJSNdnks$oNzQNgjUZZTYUkyGmKAaJJ/YWrmxD/8r/rUWtEUh0vV\n",
                    type=str,
                    default=str(),
                    )

parser.add_argument("-s", "--salt",
                    help="salt used to hash password e.g.\n\t$6$CwsdfgHksJSNdnks$\n",
                    type=str,
                    default=str(),
                    )

parser.add_argument("-r", "--raw",
                    help="raw output from:\n\tsudo cat /etc/shadow | grep $USER\n",
                    type=str,
                    default=str(),
                    )

# %%
args = parser.parse_args()

# Checking the number of args
if len(sys.argv) < 2:
    parser.print_help()
    sys.exit("\nAt least 1 arg are needed!")

passwords = args.passwords
password_hashed = args.password_hashed
salt = args.salt
raw = args.raw

if raw:
    m = match(r'(.*?):(\$.*\$.*\$)(.*?):.*', raw)
    if m is not None:
        user = m.group(1)
        salt = m.group(2)
        password_hashed = m.group(3)
    else:
        print('Don\'t forget to pass raw as with \'\' the $ is the problem!')

# NOTE
# $1    MD5 hash
# $6    sha-512

for pwd in passwords:
    pwd_hashed_check = crypt(pwd, salt=salt)
    if f'{salt}{password_hashed}' == pwd_hashed_check:
        print('Password found:')
        print(pwd)
        break
else:
    print('No macth found.')