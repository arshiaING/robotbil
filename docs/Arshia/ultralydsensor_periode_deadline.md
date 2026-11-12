# tid bruk sensor 



## hva vi trenger 

bare frontsensoren = 26 ms + 50 ms = 76 ms
begge sidesensorene = 52 ms + 50 ms = 102 ms
alle tre sensorene = 78 ms + 50 ms = 128 ms


jeg bruker ish tiden fra læreren sin kode microbit-ultrasonic.adb som sier at det tar 3 ms for start og 23 millisekunder for å få det til å slutte 
= 26 ms dette er avstanden på 4 m kortere avstander vil gi raskere periode 

trenger også en 50 ms pause så ikke vi for samme signal igjen 


## periode 

jeg bruker samme periode for alt så det blir enklere men å ha forkjsleige perioder kan gjære det raskere og bedre 

første test: 180 ms 




## Deadline 

kan også ha forskjelige deadline men tror kan bare ha 1 til alle sensor 

første test: 130


### når den kjører frem 

frontsensor = hard 

sidesensor = brukes ikke 


## når den ser side sensorenen for første gang stoppet

sidesensor = soft er ikke så farlig 

## når den snur

frontsensor = soft forsinkelser gir dårligere ytelse men systemet fungere 

sidesensor = firm de sjekkes for at vi ikke skal kræsje i noe mens vi snur men noen få deadlinbrudd er ikke farlig 

## kjørere side lengs 

frontsensor = brukes ikke 

sidesesnor = hard så den ikke kræsjer i noe eller at det ikke går for lenge så det må kjøre tilbake 


## rygging

frontsensor = brukes ikke 

sidesensor = soft er ikke så farlig fordi det skadder ikke vi vil bare få dårligere ytelse 

## knap a eller b 

frontsensor = soft fordi bilen ennå ikke har startet å bevege seg er ikke dette farlig 

sidesensor = brukes ikke 

## når er perioden ferdig 

runden er ferdig når sensoren styringen ber om noe det blir lest og vi har svaret 

så vi burde ha en set og en get 


styring systemet er ferdig når den har lest ferdig brukt regler til å finne hva den skal gjøre og gitt den ut



## resultater 

kan være alt feil melding har sin negen greie 


## ny ide 

vi kan bruke forskjelige perioder basert på hva den gjør om den sjekker 1 sensor kan vi ha egen periode når den sjekker 2 egen periode og videre 

vi kan også sette at den bruker avstanden av sensoren til å sjekke hvor mange ganger det skal sjekke sensorenen jo nørmere jo mer 


min del vi kan bruke forskjelige perioder basert på hva den gjør om den sjekker 1 sensor kan vi ha egen periode når den sjekker 2 egen periode og videre 

nasim sin del vi kan også sette at den bruker avstanden av sensoren til å sjekke hvor mange ganger det skal sjekke sensorenen jo nørmere jo mer 


## c 

foran:

sider:

alle tre

tester først sensoren foran så sider også alle tre med 50 ms 


## v1

ting jeg ikke hadde tid til eller ikke fikk til 

- det jeg planla fær var at den skulle bruke siste gyldig måling og redusere farten basert på det jeg fikk ikke det til først iden min var at vi skulle ha eha en vartabel som lagret siste gryldig verdi og fra front sensor i lagret og oppdatere det hver gang vi fikk en nyere gyldig verdi så den bare sjekket err det gyldig og vis true byttet det ut fordi jeg ikke har det må vi bar eha helt stopp når den for ikke gyldig verdi

- jeg skulle også ha flere ikke gyldig verdi for å starte å senke ned farten problemet jeg kom på når jeg skulle lage planene for å kode det var at det var vanskeliug og ha logikken ved at den må bytte verdi la oss si den for 2 ugyldig også 1 gyldig da blir tallet 0 igjen fra 2 og om det er noe problem det det skaper mange ikke gyldig men 1 få gyldig i mellom så kommer bilen til å ikke klarer å reagere eler det tar lengre ting for den starter å merke ting og testingen ble vansjelig 

- nasim skal jobbe med dynamsik periode 

