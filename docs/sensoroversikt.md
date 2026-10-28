# Sensorer og utstyr

Her skriver vi hva vi har, hva vi vil bruke det til og hva vi må undersøke.
Oversikten bygger på [Goodnotes-boken](<Robotbil Mecanum.pdf>) og notatene våre.
Motorstyringen i Bil er skrevet og kompilert. Vi har også prøvd en enkel felles motortest.
Bevegelsene med den nye Bil-pakken er ikke fysisk testet ennå.
Vi har begynt på koden for frontsensoren i Ultralyd. Sensoravlesningen er ikke ferdig,
og bygging og fysisk sensortest er ikke bekreftet. Se [ultralydplanen](sensorplan/ultralyd/ultralydplan.md).

## Det vi har og planlegger å bruke

| Del | Status | Hva vi skal undersøke |
|---|---|---|
| Metallchassis, fire Mecanum-hjul og fire DC-motorer | Tilgjengelig. | Mål, motorenes spennings- og strømkrav, hjulplassering og retning. |
| Micro:bit V2 | Tilgjengelig. Programmert i Ada. | Strømforsyning, pinner og programmet vi skal lage. |
| Motorstyringskort merket Micro:bit Driver Expansion Board V2.0 | Tilgjengelig og brukt i den første felles motortesten. | Kortmodell, strømbehov, strømveier og stopp ved kommunikasjonsfeil. |
| HC-SR04, 3 stk. | Tilgjengelig. Én 5 V-sensor er koblet opp som frontsensor. Sidesensorene kommer senere. | Forsyning, signalnivåer, pinner og måleegenskaper. |
| To motstander på 4,7 kΩ | Brukt til spenningsdeling på frontsensorens Echo. Spenningen er ikke målt. | Motstandsverdier og passende signalnivå. Hver 5 V-sensor trenger sin egen tilpasning. |
| HC-SR04, oppgitt 3,3–5 V-versjon | Bestilt. Vi har ikke registrert at de har kommet ennå. | Nøyaktig variant, strømforsyning og Echo-nivå. |
| ESP32 med USB-C | Oppgitt tilgjengelig. | Kortmodell, strøm og forbindelsen til Micro:bit. |
| Raspberry Pi 5, oppgitt 8 GB RAM | Oppgitt tilgjengelig med minnekort og operativsystem. | Egen strømforsyning og nettverk. Den skal stå utenfor bilen. |
| Powerbank | Oppgitt 5 V / 2 A og 11 200 mAh. | Merking, faktisk belastning og hvilke deler den skal forsyne. |
| Batteriholder med fire plasser | Oppgitt tilgjengelig. | Celletype og samlet spenning. |
| Temperatur- og fuktighetssensorer | Oppgitt i planleggingsboken. | Modell og antall må registreres. |
| Kamera / ESP32-CAM | Planlagt som mulig tillegg. | Anskaffelse og modell er ikke bekreftet. |

Micro:bits innebygde akselerometer, kompass og temperaturmåling kan brukes i senere forsøk.
Kompasset må blant annet prøves med kortet montert på metallbilen.
Se [Micro:bits sensoroversikt](https://microbit.org/get-started/features/sensors/).

Vi har ikke bekreftet at motorene har enkodere, altså sensorer som måler hjulrotasjon.
Første versjon planlegges derfor uten måling av faktisk hjulfart.

## Første sensortest - planlagt

Den første fysiske sensortesten skal gjøres med én HC-SR04 og bilen i ro.
Vi skal få avstanden opp i terminalen før vi bruker målingen til å styre bilen.
Etter dette skal vi prøve stopp foran en hindring og deretter sensorene på sidene.

Vi bruker først den gamle 5 V-sensoren. Vanlig HC-SR04 kan sende 5 V på Echo, så signalet må tilpasses før det går til Micro:bit.
Se [Adafruits forklaring av Trig, Echo og spenningsdeling](https://learn.adafruit.com/ultrasonic-sonar-distance-sensors/pinouts).
Oppkoblingen med to motstander står i [planen for koblingene](kobling/README.md). Spenningene er ikke målt ennå.

De bestilte sensorene må kontrolleres når de kommer. Vi må vite hvilken spenning de trenger og hva de sender på Echo.
Hvis variantene bruker samme Trig/Echo-grensesnitt, kan vi undersøke om samme avlesningskode passer til begge.

## Det som mangler før vi velger flere deler

- Motorenes nominelle spenning og strømbehov, også når de starter eller blokkeres.
- Endelig motorforsyning og kontroll av spenningen på VIN.
- Modellnavn og kontaktbehov for ESP32 og de andre sensorene.
- Mål på chassis, hjul, festepunkter og ledningsplass.
- Antall deler som mangler, pris og frakt før nye kjøp.

Designbildene i PDF-en er forslag. De erstatter ikke mål av de faktiske delene.
