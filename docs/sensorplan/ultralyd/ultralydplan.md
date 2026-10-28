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

- HC-SR04, oppgitt 3,3–5 V. Bestilt, men vi har ikke bekreftet at den har kommet ennå.

## Koblingene

- Trig går til P1.
- Echo går gjennom spenningsdeleren til P2.
- VCC går til VIN ved S1 på motorkortet.
- Sensoren og spenningsdeleren har felles GND med kortet.

Vi har koblet opp dette, men spenningene er ikke målt ennå.
Med to like motstander og 5 V fra Echo er beregnet spenning
ved P2 omtrent 2,5 V.

## hvordan ultralyd sensor fungere

sensoren bruker lyd til å måle avstand.
vi sender et kort høyt signal på trig for å starte målingen.

lyden treffer veggen og kommer tilbake. dette er et ekko.
micro:biten får et elektrisk tidssignal på echo.
ved en vanlig måling viser tiden echo er høy hvor lang tid lyden brukte frem og tilbake.
nårn den kommer tilbake for vi lav på echo.

## tid_hoy/ultralydsensor forklart

funksjonen skal måle hvor lenge echo er høyt. tiden henger sammen med turen
**sensor -> vegg -> sensor**.

kort tid betyr kort avstand, og lang tid betyr større avstand.

`tid_hoy` skal kalles rett etter at `sjekk_ultralyd` har oppdaget høyt echo.
`start_tid` husker når funksjonen startet, og `slutt_tid` er fristen 30 ms senere.
hvis echo blir lavt før fristen, returnerer funksjonen tiden som har gått.
hvis fristen nås, returnerer den `time_span_zero`, som skal behandles som ugyldig måling.

vi leser signalet i en løkke, så målingen er omtrentlig.
fristen på 30 ms må også kontrolleres når vi tester.

## overfor forklart

funksjonjene gjær tid til cm.

**avstand i cm = tid i mikrosekunder / 58**

formelen står i [databladet til HC-SR04](https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf).

`to_duration` uttrykker tiden i sekunder. vi ganger med 1 000 000 for å få
mikrosekunder. `natural` avrunder til nærmeste hele mikrosekund.
heltallsdivisjonen på 58 gir hele centimeter og kaster resten.

vi har skrevet `overfor`. parameteren heter `tid`, og den lokale konstanten
heter `tid_mikro`. funksjonen brukes ikke fra `les_foran` ennå.
bygging og fysisk sensortest er ikke bekreftet.

## Hvordan vi deler koden

Sensorpakken heter `Ultralyd`.

- `ultralyd.ads` beskriver kommandoene resten av programmet kan bruke.
- `ultralyd.adb` inneholder selve oppsettet og avlesningen.

- `Initialize` klargjør Trig som utgang og Echo som inngang.
- `send_puls` sender en kort startpuls til sensoren.
- `sjekk_ultralyd` venter på at Echo blir høyt, med en frist på 10 ms.
- `tid_hoy` måler tiden frem til Echo blir lavt, med en frist på 30 ms.
- `overfor` regner den målte tiden om til hele cm.
- `les_foran` skal måle lengden på Echo-signalet og gi avstanden i cm.

Verdien 0 skal bety at vi ikke fikk en gyldig måling.

## Status nå

| Del | Status |
|---|---|
| Oppkobling av frontsensor | Koblet opp etter gjennomgangen. Spenningene er ikke målt. |
| Initialize | Skrevet. |
| send_puls | Skrevet. |
| sjekk_ultralyd | Skrevet med 10 ms frist. |
| tid_hoy | Skrevet med 30 ms frist. |
| overfor | Skrevet. Ikke bekreftet kompilert eller testet. |
| les_foran | Beskrevet i .ads. Innholdet mangler. |
| Sensorpakke brukt fra main | Ikke lagt inn. |
| Kompilering av sensorpakken | Ikke bekreftet. |
| Avstandsmåling på bilen | Ikke bekreftet. |

10 ms og 30 ms er foreløpige ventefrister i koden. De er ikke bekreftet med
tidsmålinger. Bygging og fysisk sensortest er ikke bekreftet for noen av funksjonene.

## Rekkefølgen videre

1. Lage venting på Echo med en tidsgrense. Skrevet, må testes.
2. Måle hvor lenge Echo er høyt, også med en tidsgrense. Skrevet, må testes.
3. Regne tiden om til avstand. Skrevet, må testes.
4. Lage `les_foran` og håndtere manglende eller ugyldige målinger. **<-**
5. Lage et testprogram som bruker Ultralyd og viser avstanden.
6. Kompilere og kontrollere at sensorpakken faktisk blir bygget.
7. Teste mot kjente avstander mens bilen står stille.
8. Prøve målefeil og manglende svar.
9. Koble målingene til hindringsstopp.
10. Legge til venstre og høyre sensor.

## Feil vi må håndtere

- Echo blir ikke høyt. `sjekk_ultralyd` skal da gi `false` når fristen er passert.
- Echo blir værende høyt. `tid_hoy` skal da gi `time_span_zero` når fristen er nådd.
- Echo er allerede høyt før en ny måling. Dette må håndteres i `les_foran`.
- En ugyldig måling eller verdien 0 skal ikke tolkes som fri vei.

Dette er oppførsel vi skal kontrollere, ikke resultater fra tester.

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
