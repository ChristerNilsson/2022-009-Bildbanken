searchInput = null
data = null

spaceShip = (a,b) ->
	if a < b then -1
	else if a == b then 0
	else 1

search = (s) ->
	start = new Date()
	alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	res = []
	words = s.split ' '
	for tournament of data
		for filename in data[tournament]
			count = 0
			s = ''
			for i in range words.length
				word = words[i]
				if word == "" then continue
				if tournament.includes(word) or filename.includes(word) then s += alfabet[i]
			if s.length > 0 then res.push [-s.length,s,tournament,filename]
	res.sort (a,b) -> if a[0] == b[0] then spaceShip a[1], b[1] else spaceShip a[0], b[0]
	console.log new Date() - start
	res

clearNodes = ->
	n = document.body.childNodes.length
	for i in range n-1,5,-1
		document.body.removeChild document.body.childNodes[i]

keyTyped = -> 
	if key=='Enter'
		clearNodes()
		selection = search searchInput.value()
		for [count,letters,tournament,filename] in selection
			addResult tournament,filename,letters

preload = -> data = loadJSON './bilder.json'

setup = ->
	noCanvas()
	searchInput = createInput 'Numa'
	searchInput.fontSize = 40
	searchInput.width = 400

addResult = (tournament,filename,letters) ->
	desc = tournament
	year = tournament[0..3]
	tournament = tournament.replace /\d\d\d\d-\d\d-\d\d./,''
	url = ".\\" + year + "\\" + tournament + "_files\\small\\" + filename

	#desc = filename
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
	filename = filename.trim()

	div = createDiv ''
	div.width = 400

	img = createImg url,'bild',"", (img) -> img.elt.width = 300 
	#img.mouseClicked -> console.log 'clicked!',@
	img.parent div

	div2 = createDiv '&nbsp;' + desc
	div2.style 'font-size', '16px'
	div2.parent div

	div3 = createDiv '&nbsp;' + filename + ' (' + letters + ')'
	div3.style 'font-size', '16px'
	div3.parent div

	div4 = createDiv '&nbsp;' + "© Lars OA Hedlund"
	div4.style 'font-size', '16px'
	div4.parent div

	div5 = createDiv '&nbsp;'
	div5.style 'font-size', '16px'
	div5.parent div
