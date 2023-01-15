#!/usr/bin/env python3
# %%
from xml.etree import ElementTree as ET
from socket import gethostbyname_ex, gethostname
from subprocess import run, PIPE, call 
from pathlib import Path
from dataclasses import dataclass, fields
from argparse import ArgumentParser
from sys import exit as sysExit
from sys import version_info

if version_info.major < 3 or version_info.minor < 5:
	print("Python 3.6 or greater is requierd!")
	sysExit(1)

# %%
location_tags = Path.home() / Path('.dotfiles/localFiles/mac_addres_tags.py')

# %%
parser = ArgumentParser()
parser.add_argument("-e", "--eddit",
                    action="store_true", default=False,
                    help="Lauch vim to eddit tags file")

# %%
@dataclass
class Host:
	mac: str = ''
	ip: str = ''
	name: str = ''
	vendor: str = ''
	tag: str = ''

# %%
def importTags(path):
	import importlib.machinery
	import importlib.util

	# Import mymodule
	loader = importlib.machinery.SourceFileLoader(str(path.name), str(path.resolve()) )
	spec = importlib.util.spec_from_loader(str(path.name), loader )
	mymodule = importlib.util.module_from_spec( spec )
	loader.exec_module( mymodule )
	return mymodule.macs

# %%
def scanNetwork():
	# Get local IP
	# localIP = gethostbyname(gethostname())
	localIP = gethostbyname_ex(gethostname())[-1][0]
	
	# Substitute the last digit from localIP with 0/24
	local_network = '.'.join(localIP.split('.')[:-1]) + '.0/24'

	print('Runing the following command:')
	print(f'sudo nmap -sP {local_network} -oX -')
	result = run(['sudo', 'nmap', '-sP', local_network, '-oX', '-'], stdout=PIPE)
	xml = result.stdout.decode('utf-8')
	return xml

# %%
def buildMachines(xml, tags):
	"""
	Parsing xml from namp
	"""
	tree = ET.ElementTree(ET.fromstring(xml))
	root = tree.getroot()
	hosts = list()
	for host in root.findall('./host'):
		ip = ''
		mac = False
		vendor = ''
		name = ''
		for addres in host.findall('./address'):
			if addres.attrib['addrtype'] == 'ipv4':
				ip = addres.attrib['addr']
				# print(ip, end='\t')
			elif addres.attrib['addrtype'] == 'mac':
				mac = addres.attrib['addr']
				# print(mac, end='\t')
				if 'vendor' in addres.attrib:
					vendor = addres.attrib['vendor']
					# print(vendor, end='\t')
		for hostname in host.findall('./hostnames/hostname'):
			name = hostname.attrib['name']
			# print(name, end='\t')
		if mac:
			hosts.append(Host(mac, ip, name, vendor, tags.get(mac, '\033[91mNew\033[00m')))
	return hosts

# %%
def getMaxLens(hosts):
	maxLens = {k.name:0 for k in fields(hosts[0])}
	for host in hosts:
		for field in fields(host):
			maxLens[field.name] = max(maxLens[field.name], len(getattr(host, field.name)))
	return maxLens
	
# %%
def buildFormats(maxLens, sapces=1):
	formats = dict()
	center = '^'
	left = '<'
	right = '>'
	for f, l in maxLens.items():
		left = ''
		formats[f] = left + str(l+1)
	return formats
	
# %%
def printit(hosts, formats):
	# Print header
	tlen = sum(map(int, formats.values()))
	for field in formats.keys():
		print(f"{field:{formats[field]}}", end='')
	print()
	for field in formats:
		print(f"{'-'*(int(formats[field])-1)} ", end='')
	print()

	# Print hosts and fileds 
	for host in hosts:
		for field in formats:
			print(f"{getattr(host, field):{formats[field]}}", end='')
		print()

# %%
def getNewHosts(hosts, tags):
	hostsNew = dict()
	for host in hosts:
		if host.mac not in tags.keys():
			hostsNew[host.mac] = '\033[91mUnknown\033[00m'
	return hostsNew

# %%
def appendNewHosts(file_path, hostsNew):
	if hostsNew:
		with open(file_path, 'a') as f:
			for key, val in hostsNew.items():
				f.write(f'macs["{key}"]="{val}"\n')

# %%
def initTags(file_path):
	if file_path.is_file():
		return

	# Create folder
	file_path.parent.mkdir(parents=True, exist_ok=True)

	# create file
	with open(file_path, 'a') as f:
		f.write(f'macs = dict()\n')
# %%
if __name__ == "__main__":
	args = parser.parse_args()
	if args.eddit:
		# Option to launch vim 
		call(['vim', location_tags])
		sysExit(0)
	initTags(location_tags)
	tags = importTags(location_tags)
	xml = scanNetwork()
	hosts = buildMachines(xml, tags)
	assert hosts, "No hosts found!"
	maxLens = getMaxLens(hosts)
	formats = buildFormats(maxLens)
	printit(hosts, formats)
	newTags = getNewHosts(hosts, tags)
	appendNewHosts(location_tags, newTags)
	

