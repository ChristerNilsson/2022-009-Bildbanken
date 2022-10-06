# 2022-009-Bildbanken

Har provat att enbart skapa en sökdatabas och undvika kopiera ner bilder.
Problemet är att Google döper om sina kataloger och filer med avsikt.
Detta innebär att man måste ha tillgång till hårddisken och kopiera ner originalfilerna.
Utifrån dessa skapas sedan thumbnails med fast bredd och den sökbara json-filen.

## JSON-filen (nuvarande)
Innehåller filnamnet och sökord.
Exempel:

```
{
"Kristallens JGP 2022-09-17 Klass D":  [
	"1.Hanish_Akshat_Chenchugari_klass_D_2022-09-17.jpg",
	"10.Harry_Greaves_klass_D_2022-09-17.jpg",
	"2.Sebastian_Shi_klass_D_2022-09-17.jpg"],
"Kristallens JGP 2022-09-17 Klass C": [...]
}
```

## JSON-filen i framtiden?
Gemensamma attribut lagras på turnering/klass nivå, för att spara plats och tid.
Lämpligen lägger man även in turneringens member-schack-id.

```
{
"Kristallens JGP 2022-09-17 Klass D (10370)":  [
	"1.Hanish_Akshat_Chenchugari",
	"10.Harry_Greaves",
	"2.Sebastian_Shi"],
"Kristallens JGP 2022-09-17 Klass C": [...]
}
```

## Sökning

* Sökningen visar bilderna med flest träffar först
* I andra hand prioriteras ord tidigt i söksträngen högre än senare ord
```
T ex visar sökningen "A B" först bilder med båda orden
A B (Bildbankens enda svar)
A
B

Sökningen "A B C" visar träffarna i denna ordning:
A B C (Bildbankens enda svar)
A B
A C
B C
A
B
C
```