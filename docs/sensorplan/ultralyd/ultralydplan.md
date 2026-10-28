# Plan for ultralydsensorene

## Målet

Vi skal bruke ultralydsensorer til å måle avstanden til hindringer.

Først brukes en sensor foran og får avstanden opp i terminalen
mens bilen står stille. Etterpå skal vi bruke målingen til å stoppe
bilen foran en hindring.

Sensorene på sidene kommer etter at frontsensoren fungerer.

## Utstyret vi bruker først

- Micro:bit V2.
- Motorkortet på bilen.
- Én HC-SR04 for 5 V.
- To motstander på 4,7 kΩ.
- Koblingsbrett og ledninger.
- Powerbank, oppgitt til 5 V / 2 A, til motorkortet.

## Utstyret som kommer 

- Micro:bit V2.
- Motorkortet på bilen.
- Én HC-SR04 for 3.3 V.

## Koblingene

Trig går til P1.
Echo går gjennom spenningsdeleren til P2.
VCC går til VIN ved S1 på motorkortet.
Sensoren og spenningsdeleren har felles GND med kortet.

Vi har koblet opp dette, men spenningene er ikke målt ennå.
Med to like motstander og 5 V fra Echo er beregnet spenning
ved P2 omtrent 2,5 V.

## Hvordan vi deler koden

Sensorpakken heter Ultralyd.

ultralyd.ads beskriver kommandoene resten av programmet kan bruke.
ultralyd.adb inneholder selve oppsettet og avlesningen.

Initialize klargjør Trig som utgang og Echo som inngang.
send_puls sender en kort startpuls til sensoren.
sjekk_ultralyd venter på at Echo blir høyt, med en frist på 10 ms.
les_foran skal måle lengden på Echo-signalet og gi avstanden i cm.

Verdien 0 skal bety at vi ikke fikk en gyldig måling.

## Status nå

| Del | Status |
|---|---|
| Oppkobling av frontsensor | Koblet opp etter gjennomgangen. Spenningene er ikke målt. |
| Initialize | Skrevet. |
| send_puls | Skrevet. |
| sjekk_ultralyd | Foreslått, men ikke lagt inn i den lagrede koden ennå. |
| les_foran | Beskrevet i .ads. Innholdet mangler. |
| Sensorpakke brukt fra main | Ikke lagt inn. |
| Kompilering av sensorpakken | Ikke bekreftet. |
| Avstandsmåling på bilen | Ikke gjennomført. |

## Rekkefølgen videre

1. Lage venting på Echo med en tidsgrense.
2. Måle hvor lenge Echo er høyt, også med en tidsgrense.
3. Regne tiden om til avstand.
4. Håndtere manglende eller ugyldige målinger.
5. Lage et testprogram som bruker Ultralyd og viser avstanden.
6. Kompilere og kontrollere at sensorpakken faktisk blir bygget.
7. Teste mot kjente avstander mens bilen står stille.
8. Prøve målefeil og manglende svar.
9. Koble målingene til hindringsstopp.
10. Legge til venstre og høyre sensor.

## Feil vi må håndtere



## Testing

Første test gjøres mens bilen står stille.
Vi sammenligner avstanden i terminalen med en målt avstand.

Før testen velger vi prøveavstander, antall forsøk og hvor stort
avvik vi godtar. Resultatene føres i testloggen.

Før automatisk gulvkjøring må oppstart, avbrudd og faktisk stopp
også være kontrollert.

## Senere versjon

Når frontsensoren fungerer, legger vi til sensorene på sidene.
Vi skal måle med én sensor om gangen og undersøke om sensorene
forstyrrer hverandre.

Stoppavstand, måleperiode og tillatt alder på målingene må bestemmes
før målingene brukes til automatisk kjøring.