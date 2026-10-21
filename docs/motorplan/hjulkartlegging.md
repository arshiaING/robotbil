# Hjulkartlegging

Her skriver vi hvilken motorutgang som styrer hvert hjul.
Høyre og venstre er sett i bilens kjøreretning.

## Koblingene

Parameter i biblioteket | Hjul som faktisk reagerte | Innstilling for fremover |
|---|---|---|---|
| `rf` | Venstre bak | Fremover | 
| `rb` | Venstre foran | Fremover | 
| `lf` | Høyre bak | Bakover | 
| `lb` | Høyre foran | Bakover | 

## Første motortest

 brukte et enkelt program som gir pådrag til alle fire motorenene i 10 s.
Motorpådraget var 2044.




          FORAN – lengst unna Micro:bit

     Venstre foran              Høyre foran
          rb                         lb

     Venstre bak                Høyre bak
          rf                         lf

                BAK – Micro:bit


## Hva tallparene betyr 

Hvert tallpar styrer motorpådraget i to motsatte retninger.
Hvilken retning som blir fremover på bilen, avhenger av koblingen.

pwm er pådraget vi regner ut fra kraft:

pwm = (kraft * 4095) / 100

kraft går fra 0 til 100. pwm går fra 0 til 4095.
Dette er motorpådrag, ikke målt hjulfart.

Tallparet (0, 0) brukes til å sende stopp.