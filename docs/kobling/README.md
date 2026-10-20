# Plan for koblingene

Her planlegger vi hvordan delene skal kobles sammen.
Arbeidet med motorstyring og sensorer er ikke startet. Forslagene må kontrolleres før vi kobler og tester.

## Forslag til frontsensor

Et foreløpig forslag er P1 til Trig og P2 til Echo på HC-SR04.
Vi må kontrollere pinnene, strømforsyningen og signalnivåene før vi bruker forslaget.

| Sensorpinne | Forslag til forbindelse | Hva må kontrolleres? |
|---|---|---|
| VCC | VIN på motorkortets S-rad, ved S1, dersom kortet får 5 V. | Faktisk forsyningsspenning og riktig VIN-pinne. S1-signalpinnen er ikke strømforsyning. |
| GND | Felles GND for sensor, Micro:bit, motorkort og spenningsdeler. | At alle delene har samme jordforbindelse. |
| Trig | Grønn signalpinne ved P1. | At P1 er ledig og riktig pinne er valgt. |
| Echo | Én motstand på 4,7 kΩ fra Echo til et felles punkt. Punktet går til P2 og gjennom en annen motstand på 4,7 kΩ til GND. | Motstandsverdier, sammenkobling og signalspenning før signalet kobles til Micro:bit. |

Forslag til spenningsdeler:

```text
Echo --- 4,7 kΩ ---+--- P2
                  |
                4,7 kΩ
                  |
                 GND
```

Med 5 V inn og to like motstander blir beregnet spenning ved P2 omtrent 2,5 V.
Spenningen må måles når oppsettet lages.
Vanlig HC-SR04 kan gi 5 V på Echo; [Adafruit forklarer hvorfor signalet må tilpasses en 3 V-inngang](https://learn.adafruit.com/ultrasonic-sonar-distance-sensors/pinouts).


Vi skal bruke [DFRobots referanseside med koblingsskjema for V2.0](https://wiki.dfrobot.com/dfr0548/docs/18216) når vi kontrollerer pinnene.

## Motorer og øvrige forbindelser

| Forbindelse | Plan | Hva må undersøkes? |
|---|---|---|
| Micro:bit → motorstyringskort | Bruke ekstern I2C. | Pinner, adresse, kontakttest, feilstatus og tidsgrenser. |
| Motorstyringskort → fire motorer | Koble én motor til hver kanal. | Motorenes spennings- og strømkrav, hvilket hjul hver kanal styrer, retning og stopp. |
| Venstre og høyre HC-SR04 | Legges til etter frontsensoren. | Pinner, strøm og hver sensors Echo-tilpasning. |
| ESP32 ↔ Micro:bit | Bruke UART til manuell styring senere. | Kortmodell, TX/RX-pinner, signalnivåer og meldingsformat. |
| Motorforsyning → kortet | Velge forsyning som passer motorene og kortet. | Spenning, belastning og av/på-løsning. |
| Forsyning → Micro:bit og ESP32 | Planlegge strømveiene samlet. | Strømveier og felles GND, også ved USB-tilkobling. |

Vi skal kartlegge hjulene når motorarbeidet starter. Da noterer vi hvilken kanal som styrer hvert hjul og hvilken vei det roterer.
Ledningsfarge alene er ikke nok til å identifisere en forbindelse; vi må følge pinnen og begge ender av ledningen.

## Planlagt kontroll før første forsøk

Vi kobler fra strømmen før vi endrer ledninger. Pinner, felles GND og forsyning må kontrolleres før strømmen slås på.
Første sensoravlesning skal gjøres med motorene stoppet. Ledninger og motstandsbein skal ikke komme borti chassis eller hjul.

Når vi kobler opp, oppdaterer vi tabellen med de faktiske forbindelsene og legger inn bilder ved behov.
Kontrollene skal føres i [testloggen](../testlogg/README.md), med henvisning til T00 i [testplanen](../testplan.md).
