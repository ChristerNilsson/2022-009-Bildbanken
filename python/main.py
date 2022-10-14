# Om bilder.js saknas eller EVERYTHING == True produceras små bilder i den katalogen och dimension uppdateras
# Därefter sammanställs bilder.js som omfattar ALLA kataloger, i variabeln total.

import json
import time
import operator
from os import scandir
from os.path import exists
from PIL import Image

total = [] # Samlar på sig hela strukturen

EVERYTHING = True

WIDTH = 432

data = {}

def pop(path):
	arr = path.split('\\')
	arr.pop()
	return "\\".join(arr)

def makeSmall(js,entry,level):
	big = Image.open(entry.path)
	small = big.resize((WIDTH, round(WIDTH*big.height/big.width)))
	small.save(pop(entry.path) + '\\small\\' + entry.name)
	js.append([entry.name,small.width,small.height])

def readrecurs(curr, parent, level=""):
	global total
	js = []

	if exists(parent + "\\small\\bilder.js"):
		keys = list(curr[-2].keys())
		key = keys[-1]
		with open(parent + '\\small\\bilder.js', 'r', encoding="utf-8") as f:
			curr[-2][key] = json.loads(f.read())
	else:
		names = [f for f in scandir(parent)]
		for name in names:
			if name.name != 'small':
				if name.is_dir():
					nextcurr = {}
					curr[-1][name.name] = nextcurr
					readrecurs(curr+[nextcurr],name.path,level+"  ")
				else:
					if EVERYTHING or not jsExists:
						makeSmall(js,name,level+"  ")
		if len(js) > 0:
			print('Making bilder.js for',parent)
			with open(parent+'\\small\\bilder.js', 'w', encoding="utf-8") as f:
				json.dump(js,f)

def readFiles(curr,root,datum,tournament):
	year = datum[0:4]
	tour = tournament.replace('_',' ')
	nextcurr = {}
	curr[-1][datum + ' ' + tournament] = nextcurr
	readrecurs(curr + [nextcurr] , root + "\\" + tour)

start = time.time()

total = {}
total["2022"] = {}
root = "C:\\github\\2022-011-Bildbanken-svelte\\public\\"
readFiles([total["2022"]], root + "2022", '2022-09-17', "Kristallens JGP")
readFiles([total["2022"]], root + "2022", '2022-10-01', "Minior-Lag-DM")

with open(root + "nyabilder.json", 'w', encoding="utf-8") as f:
	json.dump(total, f, ensure_ascii=False)

print(total)

print(time.time() - start)
