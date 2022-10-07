import json
import time
import operator
from os import listdir
from os.path import isfile

data = {}

def readFiles(root,datum,tournament):
	year = datum[0:4]
	root += "\\" + year
	res = []
	tour = tournament.replace('_',' ')
	files = [f for f in listdir(root + "\\" + tour + '_files\\small')]
	for file in files:
		res.append(file)
	data[datum + ' ' + tournament] = res

start = time.time()
root = "C:\\github\\2022-009-Bildbanken"
readFiles(root, '2022-09-17', 'Kristallens_JGP\Klass_AB')
readFiles(root, '2022-09-17', 'Kristallens_JGP\Klass_C')
readFiles(root, '2022-09-17', 'Kristallens_JGP\Klass_D')
readFiles(root, '2022-09-17', 'Kristallens_JGP\Diverse')
readFiles(root, '2022-10-01', 'Minior-Lag-DM')

for key in data:
	print()
	print(len(data[key]), 'bilder i',key)
	for item in data[key]:
		print(' ',item)

with open("C:\\github\\2022-009-Bildbanken\\bilder.json", 'w', encoding="utf-8") as f: #
	json.dump(data, f, ensure_ascii=False)

print(time.time() - start)

# Sökningen visar bilderna med flest träffar först.
# I andra hand bilder med tidiga ord.

# T ex visar sökningen "A B" först bilder med båda orden
# A B (bildbankens enda svar)
# A
# B

# Sökningen "A B C" visar träffarna i denna ordning:
# A B C (bildbankens enda svar)
# A B
# A C
# B C
# A
# B
# C

def search (s):
	alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	print()
	print(s)
	res = []
	words = s.split(' ')
	for pair in data:
		count = 0
		s = ''
		for i in range(len(words)):
			word = words[i]
			if word in pair[0]: s += alfabet[i]
		if len(s)>0: res.append([-len(s),s,pair])
	res = sorted(res,key=operator.itemgetter(0, 1))
	for item in res:
		print(item)
	return res

# start = time.time()

# for i in range(1):
# 	search('Sara Cristina Ostafiev Alexander Brocke')
# 	search('Harry Numa Jan')
# 	search('Jan Harry Numa')
# 	search('Numa Karlsson')

# end = time.time()
# print(end - start)
