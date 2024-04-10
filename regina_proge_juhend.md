# Funktsiooni loomine
Esiteks vaja luua funktsioon. on öeldud, et vaja luua funktsioon mis võtab argumendiks ühe või mitu asja (argument1, argument2 jne)
```python
def funktsiooni_nimi(argument1):
```
- näiteks
```python
def arvuta_kehamassi_indeks(kaal, pikkus_cm):
``` 
Siis vaja luua funktsiooni sisu. vaja luua muutuja või mitu muutujat ja argumente kasutades arvutada või muuta seda nii, et saab soovitud tulemuse
```python
 funktsiooni_muutuja1 = argument2 * 52 / argument1**2 # näiteks
```
- näiteks
```python
	kehamassi_indeks = (pikkus_cm-100)**2 / kaal
```
 
- võib olla vaja ümardada
```python
	kehamassi_indeks = round(kehamassi_indeks, 2) # kahe komakohani (2). kui tahta täisarvuks ümardada siis lihtsalt kehamassi_indeks = round(kehamassi_indeks)
``` 
Siis vaja tagastada mingi väärtus ehk mis funktsioon välja annab või mida leiab
```python
	return muutuja1
```
- näiteks
```python
	return kehamassi_indeks
``` 
**!!! kunagi ei tohi hilejm kasutada ühtegi muutujat, mis funktsiooni sees kasutasid, ehk siin funktsiooni_muutuja1 ja kehamassi_indeks ei tohi kunagi mujal kasutada**

--- 

# Kasutajalt küsimine
Edasi ilmselt vaja küsida faili nime
```python
failinimi = input("Sisesta faili nimi: ")
``` 
Ja ilmselt vaja küsida mingit muud arvu, näiteks madala kehamassi indeksi piiri
```python
madal_bmi = float(input("Sisesta, mis piirist on kehamassi indeks liiga madal (ujukomaarv): ")) # kui tahta täisarv siis int(input()) mitte float(input())
``` 
- võib olla veel midagi vaja küsida
```python
inimese_pikkus = int(input("Sisesta oma pikkus sentimeetrites: "))
```

 ---

# Failist lugemine
Vaja failist lugeda mingid andmed, näiteks kaalumised
```python
with open(failinimi) as fail:
	kaalumised = fail.readlines() # kaalumised on uus muutuja, see on järjend, milles iga element on üks rida failist
```

---

# Lugejate (counter) ja järjendite loomine
Vaja kokku lugeda kui mitu kaalumist tehti, iga kord uue kaalumisega seda vaja suurendada
```python
kaalumiste_lugeja = 0 # sest alguses veel pole ühtegi kaalumist tehtud, iga kaalumisega suureneb ühe võrra
``` 
- võib olla vaja lugeda kui mitu oli näiteks liiga madal
```python
madalate_kaalumiste_lugeja = 0 # algul jälle 0 liiga madalat
``` 
Võib olla hiljem vaja väljastada keskmine kehamassi indeks mõõtmiste käigus vms
```python
mõõtmiste_järjend = [] # uus muutuja, tühi järjend, kuhu lisada järjest mõõtmisi
``` 
- võib olla vaja lisada järjendisse ainult siis kui vastab tingimusele
```python
madalate_mõõtmiste_järjend = []
``` 

---

# For tsükkel andmete töötlemiseks
For tsükkliga vaja kõigist mõõtmistest üle käia
```python
for kaal in kaalumised: # kaal on uus muutuja mis iga kord saab uue väärtuse. see on alati sõne, sest failist lugedes saab sõne
``` 
Muutuja viia vastavale kujule, sest algul on sõne, kuna see on otse failist loetud
```python
	kaal = int(kaal) # vaja teha täisarvuks mitte sõneks et saaks argumendina kasutada
``` 
Vaja suurendada kaalumiste lugejat, sest on tsükli algus ja seega uus kaalumine (muutujal kaal on nüüd uus väärtus)
```python
	kaalumiste_lugeja = kaalumiste_lugeja + 1 # suurendame ühe võrra, sest on uus kaalumine
``` 
Vaja kasutada enda tehtud funktsiooni, et arvutada midagi, näiteks inimese kehamassi indeks vastava kaalumise hetkel
```python
	praegune_kehamassi_indeks = arvuta_kehamassi_indeks(kaal, inimese_pikkus) # uus muutuja, inimese pikkust küsiti enne, kaal on muutuja mis failist loetud
``` 
- võib olla vaja lisada arvutatud asi järjendisse
```python
	mõõtmiste_järjend.append(praegune_kehamassi_indeks) # järjend.append(asi) lisab asja 'asi' järjendisse 'järjend'
``` 
Vaja kontrollida, kas arvutatud asi vastab mingile tingimusele (siin näiteks kas on liiga madal, madalat piiri küsisime kasutajalt juba enne)
```python
	if praegune_kehamassi_indeks <= madal_bmi: # kui bmi on sama või veel väiksem kui madal_bmi, on järelikult tegemist liiga madala kehamassi_indeksiga
``` 
Vaja väljastada arvutatud tulemus ja kui tingimus kehtib, siis lisada midagi veel
```python
		print("Kehamassi indeks on " + praegune_kehamassi_indeks + ", see on madalam kui võiks olla.")
``` 
- võib olla vaja suurendada lugejat, mis loeb, kui mitu mõõtmist vastas tingimusele (näiteks oli liiga madal)
```python
		madalate_mõõtmiste_lugeja = madalate_mõõtmiste_lugeja + 1
``` 
- võib olla vaja mõõtmine lisada järjendisse, mis salvestab ainult tingimusele vastavad mõõtmised
```python
		madalate_mõõtmiste_järjend.append(praegune_kehamassi_indeks) # lisab praeguse bmi järjendisse, sest see oli normist madalam
``` 
Kui ei vasta tingimusele (näiteks ei ole liiga madal), siis võib olla lihtsalt vaja väljastada arvutatud tulemus
```python
	else:
		print("Kehamassti indeks on " + praegune_kehamassi_indeks + ".")
```

---

# While tsükkel andmete töötlemiseks
While tsükliga saab küsida kasutajalt sisestusi kuni teatud tingimuseni, näiteks kuni kasutaja sisestab negatiivse arvu.
```python
kaal = float(input("Sisesta oma kaal (kilogrammides), negatiivse arvu sisestamisel lõpetab: "))

while kaal >= 0: # kuni kaal on positiivne või 0
```
Vaja suurendada kaalumiste lugejat, sest while tsükli algus ja seega uus kaalumine
```python
    kaalumiste_lugeja = kaalumiste_lugeja + 1 # suurendame ühe võrra, sest on uus kaalumine
```
Vaja kasutada enda tehtud funktsiooni, et arvutada midagi, näiteks inimese kehamassi indeks vastava kaalumise hetkel
```python
    praegune_kehamassi_indeks = arvuta_kehamassi_indeks(kaal, inimese_pikkus) # uus muutuja, inimese pikkust küsiti enne
```
- võib olla vaja lisada arvutatud asi järjendisse
```python
    mõõtmiste_järjend.append(praegune_kehamassi_indeks) # järjend.append(asi) lisab asja 'asi' järjendisse 'järjend'
```
Vaja kontrollida, kas arvutatud asi vastab mingile tingimusele (siin näiteks kas on liiga madal, madalat piiri küsisime kasutajalt juba enne)
```python
    if praegune_kehamassi_indeks <= madal_bmi: # kui bmi on sama või veel väiksem kui madal_bmi, on järelikult tegemist liiga madala kehamassi_indeksiga
```
Vaja väljastada arvutatud tulemus ja kui tingimus kehtib, siis lisada midagi veel
```python
        print("Kehamassi indeks on " + str(praegune_kehamassi_indeks) + ", see on madalam kui võiks olla.")
```
- võib olla vaja suurendada lugejat, mis loeb, kui mitu mõõtmist vastas tingimusele (näiteks oli liiga madal)
```python
        madalate_mõõtmiste_lugeja = madalate_mõõtmiste_lugeja + 1
```
- võib olla vaja mõõtmine lisada järjendisse, mis salvestab ainult tingimusele vastavad mõõtmised
```python
        madalate_mõõtmiste_järjend.append(praegune_kehamassi_indeks) # lisab praeguse bmi järjendisse, sest see oli normist madalam
```
Kui ei vasta tingimusele (näiteks ei ole liiga madal), siis võib olla lihtsalt vaja väljastada arvutatud tulemus
```python
    else:
        print("Kehamassi indeks on " + str(praegune_kehamassi_indeks) + ".")
```
Lõpuks küsida uuesti kaalu, et while tsükkel saaks uuesti kontrollida tingimust ja vajadusel jätkata
```python
    kaal = float(input("Sisesta oma kaal (kilogrammides), negatiivse arvu sisestamisel lõpetab: "))
```

---

# Lõpus väljastamine
Lõpuks vaja väljastada näiteks kui mitu mõõtmist tehti ja kui mitu vastasid tingimusele (näiteks olid liiga madalad)
```python
print("Tehti " + str(kaalumiste_lugeja) + " kaalumist. Kehamassi indeks oli normist madalam " + str(madalate_kaalumiste_lugeja) " korral.")
``` 
- võib olla vaja väljastada midagi kasutades järjendisse salvestatud väärtuseid
```python
keskmine_bmi = avg(mõõtmiste_järjend) # arvutab järjendi elementide keskmise
``` 
- võib olla vaja seda ka ümardada
```python
keskmine_bmi = round(keskmine_bmi, 1) # keskmine bmi ümardatud ühe komakohani
 ```
- võib olla vaja leida ka midagi järjendist, kus tingimusele vastavad mõõtmised (näiteks kõige madalam bmi mis mõõdeti nendest, mis olid madalad)
```python
madalaim_bmi_madalatest = min(madalate_mõõtmiste_järjend)
```
- siis võib vaja olla neid väljastada
```python
print("Keskmine bmi oli " str(keskmine_bmi) + ", kõige madalam oli " + str(madalaim_bmi_madalatest)).
```

---

# Näidisprogrammi kood
```python
def arvuta_kehamassi_indeks(kaal, pikkus_cm):
	kehamassi_indeks = (pikkus_cm-100)**2 / kaal
	kehamassi_indeks = round(kehamassi_indeks, 2)
	return kehamassi_indeks

failinimi = input("Sisesta faili nimi: ")
madal_bmi = float(input("Sisesta, mis piirist on kehamassi indeks liiga madal (ujukomaarv): "))
inimese_pikkus = int(input("Sisesta oma pikkus sentimeetrites: "))

with open(failinimi) as fail:
	kaalumised = fail.readlines()

kaalumiste_lugeja = 0
madalate_kaalumiste_lugeja = 0
mõõtmiste_järjend = []
madalate_mõõtmiste_järjend = []

for kaal in kaalumised:
  kaal = int(kaal)
	kaalumiste_lugeja = kaalumiste_lugeja + 1
	praegune_kehamassi_indeks = arvuta_kehamassi_indeks(kaal, inimese_pikkus)
	mõõtmiste_järjend.append(praegune_kehamassi_indeks)
	if praegune_kehamassi_indeks <= madal_bmi:
		print("Kehamassi indeks on " + str(praegune_kehamassi_indeks) + ", see on madalam kui võiks olla.")
		madalate_mõõtmiste_lugeja = madalate_mõõtmiste_lugeja + 1
		madalate_mõõtmiste_järjend.append(praegune_kehamassi_indeks)
	else:
		print("Kehamassi indeks on " + str(praegune_kehamassi_indeks) + ".")

kaal = float(input("Sisesta oma kaal (kilogrammides), negatiivse arvu sisestamisel lõpetab: "))
while kaal >= 0:
    kaalumiste_lugeja = kaalumiste_lugeja + 1
    praegune_kehamassi_indeks = arvuta_kehamassi_indeks(kaal, inimese_pikkus)
    mõõtmiste_järjend.append(praegune_kehamassi_indeks)
    if praegune_kehamassi_indeks <= madal_bmi:
        print("Kehamassi indeks on " + str(praegune_kehamassi_indeks) + ", see on madalam kui võiks olla.")
        madalate_mõõtmiste_lugeja = madalate_mõõtmiste_lugeja + 1
        madalate_mõõtmiste_järjend.append(praegune_kehamassi_indeks)
    else:
        print("Kehamassi indeks on " + str(praegune_kehamassi_indeks) + ".")
    kaal = float(input("Sisesta oma kaal (kilogrammides), negatiivse arvu sisestamisel lõpetab: "))

print("Tehti " + str(kaalumiste_lugeja) + " kaalumist. Kehamassi indeks oli normist madalam " + str(madalate_kaalumiste_lugeja) + " korral.")

keskmine_bmi = sum(mõõtmiste_järjend) / len(mõõtmiste_järjend)
keskmine_bmi = round(keskmine_bmi, 1)
madalaim_bmi_madalatest = min(madalate_mõõtmiste_järjend)

print("Keskmine bmi oli " + str(keskmine_bmi) + ", kõige madalam oli " + str(madalaim_bmi_madalatest) + ".")
```
