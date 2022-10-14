#import data from './bilder.json' assert { type: 'JSON' }
#console.log(data);

searchInput = null
data = null
found = 0

spaceShip = (a,b) ->
	if a < b then -1
	else if a == b then 0
	else 1 

search = (s) ->
	start = new Date()
	alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	res = []
	words = s.split ' '
	stat = {}
	total = 0
	for tournament of data
		total += data[tournament].length
		for filename in data[tournament]
			count = 0
			s = ''
			for i in range words.length
				word = words[i]
				if word == "" then continue
				#word = word.replaceAll '_',' '
				console.log tournament,tournament.includes(word),word
				if tournament.includes(word) or filename.includes(word) then s += alfabet[i]
			if s.length > 0
				res.push [-s.length,s,tournament,filename]
				stat[s] = (stat[s] || 0) + 1
	res.sort (a,b) -> if a[0] == b[0] then spaceShip a[1], b[1] else spaceShip a[0], b[0]
	console.log new Date() - start

	keys = _.keys stat
	keys.sort (a,b) => if a.length == b.length then spaceShip a,b else -spaceShip a.length,b.length
	st = []
	antal = 0
	for key in keys
		st.push "#{key}:#{stat[key]}"
		antal += stat[key]
	[st.join(' '),"#{antal} av #{total} bilder",res]

clearNodes = (keep) ->
	while true
		n = document.body.childNodes.length
		node = document.body.childNodes[n-1]
		if node == keep.elt then return
		document.body.removeChild node

keyTyped = -> 
	if key=='Enter'
		clearNodes searchInput

		selection = search searchInput.value()

		div = createDiv ''
		div.width = 400
		div0 = createDiv selection[0]
		div0.style 'font-size', '16px'
		div0.parent div
		div1 = createDiv selection[1]
		div1.style 'font-size', '16px'
		div1.parent div

		if false
			for [count,letters,tournament,filename] in selection[2]
				addPicture tournament,filename,letters
		else 
			res = {}
			for [count,letters,tournament,filename] in selection[2]
				res[tournament] ||= []
				#res[tournament].push letters + ' ' + filename
				res[tournament].push filename
			addText res

preload = -> data = loadJSON './bilder.json'

setup = ->
	noCanvas()
	searchInput = createInput 'Numa'
	searchInput.fontSize = 40
	searchInput.width = 400

pretty = (desc,filename) ->
	desc = desc.replace '\\', ' '
	filename = filename.replace '.jpg', ''
	filename = filename.replace /\d\d\d\d-\d\d-\d\d-X-\d/,''
	filename = filename.replace /\d\d\d\d-\d\d-\d\d-\d/,''
	filename = filename.replace /\d\d\d\d-\d\d-\d\d/,''
	filename = filename.replace /Vy-/g,''
	filename = filename.replaceAll /_/ig,' '
	arr = desc.split ' '
	filename = filename.replace arr[1],''
	filename = filename.replace /klass ../i,''
	filename = filename.replace /klass ./i,''
	filename = filename.replace '-X',''
	filename = filename.replace 'KSK-JGP',''
	filename.trim()

addPicture = (tournament,filename,letters) ->
	desc = tournament
	year = tournament[0..3]
	tournament = tournament.replace /\d\d\d\d-\d\d-\d\d./,''
	tournament = tournament.replaceAll '_',' '
	console.log tournament
	url = ".\\" + year + "\\" + tournament + "_files\\small\\" + filename

	#desc = filename
	filename = pretty desc,filename

	div = createDiv ''
	div.width = 400

	img = createImg url,'bild',"", (img) -> img.elt.width = 300 
	#img.mouseClicked -> console.log 'clicked!',@
	img.parent div

	div3 = createDiv '&nbsp;' + filename
	div3.style 'font-size', '16px'
	div3.parent div

	div2 = createDiv '&nbsp;' + desc
	div2.style 'font-size', '16px'
	div2.parent div

	div4 = createDiv '&nbsp;' + letters + " © Lars OA Hedlund"
	div4.style 'font-size', '16px'
	div4.parent div

	div5 = createDiv '&nbsp;'
	div5.style 'font-size', '16px'
	div5.parent div

addText = (hash) ->

	div = createDiv ''
	div.style 'font-size', '18px'

	for tournament of hash
		console.log tournament
		desc = tournament
		year = desc[0..3]
		files = hash[tournament]
		tournament = tournament.replace /\d\d\d\d-\d\d-\d\d./,''
		tournament = tournament.replaceAll '_',' '
		div1 = createDiv desc
		div1.parent div
		for file in files
			origFile = file
			file = pretty desc,file
			url = ".\\" + year + "\\" + tournament + "_files\\small\\" + origFile

			a = createA url,file
			a.style 'font-size', '14px'
			a.parent div
