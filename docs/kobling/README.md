# Plan for koblingene

Her planlegger vi hvordan delene skal kobles sammen.
Motorarbeidet er startet. Vi har prøvd en enkel felles motortest og fått alle fire hjulene til å rotere.
Bil-pakken er skrevet og kompilert. Bevegelsene med denne pakken er ikke fysisk testet ennå.
Frontsensoren er koblet opp etter gjennomgangen, og vi har begynt på koden i Ultralyd.
Spenningene er ikke målt. Bygging og fysisk sensortest er ikke bekreftet.

## Oppkobling av frontsensor

Vi bruker den gamle HC-SR04 for 5 V med P1 til Trig og P2 til Echo.
Tabellen viser oppkoblingen vi har gjort. Pinner, strømforsyning og signalnivåer må fortsatt kontrolleres før sensortesten.

| Sensorpinne | Forbindelse | Hva må kontrolleres? |
|---|---|---|
| VCC | VIN på motorkortets S-rad, ved S1, dersom kortet får 5 V. | Faktisk forsyningsspenning og riktig VIN-pinne. S1-signalpinnen er ikke strømforsyning. |
| GND | Felles GND for sensor, Micro:bit, motorkort og spenningsdeler. | At alle delene har samme jordforbindelse. |
| Trig | Grønn signalpinne ved P1. | At P1 er ledig og riktig pinne er valgt. |
| Echo | Én motstand på 4,7 kΩ fra Echo til et felles punkt. Punktet går til P2 og gjennom en annen motstand på 4,7 kΩ til GND. | Motstandsverdier, sammenkobling og signalspenning før signalet kobles til Micro:bit. |

Spenningsdeleren vi har koblet opp:

```text
Echo --- 4,7 kΩ ---+--- P2
                  |
                4,7 kΩ
                  |
                 GND
```

Med 5 V inn og to like motstander blir beregnet spenning ved P2 omtrent 2,5 V.
Spenningen er ikke målt ennå og må kontrolleres før sensortesten.
Vanlig HC-SR04 kan gi 5 V på Echo; [Adafruit forklarer hvorfor signalet må tilpasses en 3 V-inngang](https://learn.adafruit.com/ultrasonic-sonar-distance-sensors/pinouts).


Vi skal bruke [DFRobots referanseside med koblingsskjema for V2.0](https://wiki.dfrobot.com/dfr0548/docs/18216) når vi kontrollerer pinnene.

## Motorer og øvrige forbindelser

| Forbindelse | Plan | Hva må undersøkes? |
|---|---|---|
| Micro:bit → motorstyringskort | Ekstern I2C er brukt i motorstyringen. | Pinner, adresse, kontakttest, feilstatus og tidsgrenser. |
| Motorstyringskort → fire motorer | Alle fire motorene er prøvd i en enkel felles test. | Motorenes spennings- og strømkrav, hvilket hjul hver kanal styrer, retning og stopp. |
| Venstre og høyre HC-SR04 | Legges til etter frontsensoren. | Pinner, strøm og hver sensors Echo-tilpasning. |
| ESP32 ↔ Micro:bit | Bruke UART til manuell styring senere. | Kortmodell, TX/RX-pinner, signalnivåer og meldingsformat. |
| Motorforsyning → kortet | Velge forsyning som passer motorene og kortet. | Spenning, belastning og av/på-løsning. |
| Forsyning → Micro:bit og ESP32 | Planlegge strømveiene samlet. | Strømveier og felles GND, også ved USB-tilkobling. |

Kartleggingen vi bruker i koden står i [hjulkartleggingen](../motorplan/hjulkartlegging.md).
Vi skal kontrollere hvilken motorutgang som styrer hvert hjul, hvilken vei det roterer og sammenhengen med M1 til M4 på kortet.
Ledningsfarge alene er ikke nok til å identifisere en forbindelse; vi må følge pinnen og begge ender av ledningen.

## Kontroll før nye forsøk

Vi kobler fra strømmen før vi endrer ledninger. Pinner, felles GND og forsyning må kontrolleres før strømmen slås på.
Første sensoravlesning skal gjøres med motorene stoppet. Ledninger og motstandsbein skal ikke komme borti chassis eller hjul.

Vi oppdaterer tabellen når koblingene endres og legger inn bilder ved behov.
Kontrollene skal føres i [testloggen](../testlogg/README.md), med henvisning til T00 i [testplanen](../testplan.md).
