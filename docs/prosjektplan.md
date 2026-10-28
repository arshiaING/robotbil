# Prosjektplan for robotbilen

Vi skal lage og programmere en robotbil med Mecanum-hjul. Vi bruker Ada på Micro:bit V2.
Bilen skal bruke sensorer til å oppdage hindringer og etter hvert kunne unngå dem selv.

Planen bygger på [Goodnotes-boken](<Robotbil Mecanum.pdf>) og notatene våre.
Kravene står i [kravlisten](krav.md).

## Målet og første versjon

Først skal vi lage og teste grunnleggende motorstyring. Deretter skal vi begynne med én avstandssensor foran.
Målet for den første automatiske versjonen er at bilen kan kjøre rolig fremover og stoppe før en hindring.

Vi skal først teste sensoren mens bilen står stille. Deretter skal vi bruke målingen til å stoppe bilen foran en hindring.
Etter dette skal vi prøve sensorene på sidene og valg av fri retning.

Manuell kjøring fra mobil tar vi senere. Kamera og objektfølging er ekstra funksjoner hvis vi får tid.
Dette er våre valg for rekkefølgen på arbeidet. AI er ikke et krav fra læreren.

## Hvor vi er nå

Lærerens startoppsett og driverbibliotek er på plass.
Livstegntesten er gjennomført, og «Kjorer.» kom opp i terminalen.
Resultatet står i [første del av T01](testlogg/2026-10-20-livstegn.md).

Vi har prøvd en enkel felles motortest og fått alle fire hjulene til å rotere.
Deretter samlet vi motorstyringen i Bil.
V1, V2 og V3 er skrevet og kompilert sammen med hovedprogrammet.
Se [byggeloggen](testlogg/2026-10-21-bil-bygging.md).

`main.adb` kaller nå bare `Bil.Initialize`, som klargjør kortet og sender stopp.
Bevegelsene med den nye pakken er ikke fysisk testet ennå.
Vi har begynt på frontsensoren i Ultralyd. Oppsett, startpuls, venting på Echo og måling av hvor lenge Echo er høyt er skrevet.
Omregning til cm er skrevet i `overfor`. `les_foran` mangler innhold, og sensorpakken brukes ikke fra `main.adb`.
Bygging og fysisk sensortest er ikke bekreftet. Se [ultralydplanen](sensorplan/ultralyd/ultralydplan.md).

For sensoren er neste steg å lage `les_foran`, som skal bruke delene sammen.
For motorene gjenstår kontroll av oppstart, faktisk stopp og hjulretningene på bilen.
Deretter tester vi én bevegelse om gangen.
Motorarbeidet er beskrevet i [motorplanen](motorplan/motorplan.md).
Resultater og målinger skal føres i testloggen.

## Planlagt system

| Del | Hva den skal gjøre |
|---|---|
| Micro:bit V2 | Lese sensorer, ta lokale beslutninger og sende motorpådrag. |
| Motorstyringskort | Styre de fire DC-motorene. |
| HC-SR04 foran og på sidene | Måle avstand til hindringer. |
| ESP32, senere | Sende kommandoer mellom nettverket og Micro:bit. |
| Raspberry Pi 5 utenfor bilen, senere | Kjøre brukergrensesnitt og eventuell bildebehandling. |
| Mobiltelefon, senere | Vise knapper for manuell kjøring. |
| Kamera, valgfritt | Gi bilder til eventuell objektfølging. |

Den første automatiske versjonen er planlagt med denne veien:

**Sensorer → Micro:bit → motorstyringskort → motorer**

Senere vil vi prøve denne kommandoveien:

**Mobil → Raspberry Pi → Wi-Fi → ESP32 → UART → Micro:bit**

UART er en forbindelse for å sende data mellom kortene. Pinner og meldingsformat er ikke valgt ennå.
Stopp ved hindringer skal håndteres lokalt på Micro:bit, uten å vente på nettverket.

## Rekkefølgen på arbeidet

| Del | Planlagt arbeid | Hva vi må kontrollere |
|---|---|---|
| 1 | Legge inn dokumentasjon og lærerens startoppsett. | Filene er på plass og versjonen er kjent. |
| 2 | Bygge og overføre startprogrammet. | Byggingen lykkes og startmeldingen kommer fra Micro:bit. |
| 3 | Lage motorstyring med oppstart, stopp og bevegelseskommandoer. | Riktig hjul og retning, bevisst start og faktisk stopp. |
| 4 | Lese frontsensoren med bilen i ro. | Avstander og målefeil vises riktig, og manglende svar avslutter målingen. |
| 5 | Lage lokal hindringsstopp. | Bilen stopper før kontakt ved de avtalte testforholdene. |
| 6 | Legge til sidesensorene og valg av retning. | Målingene og dekningen passer til bevegelsen. |
| 7 | Undersøke samtidige oppgaver og tidskrav. | Oppgavene og stoppen fungerer også når andre oppgaver venter eller feiler. |
| 8 | Teste sammen med andre biler. | Kjøringen oppfyller lærerens avtalte prøveopplegg. |
| 9 | Lage manuell mobilstyring. | Kommandoer, knappeslipp og bortfall av forbindelse håndteres. |
| 10 | Vurdere kamera hvis det er tid. | Tillegget beholder lokal hindringsstopp. |

Tidskrav og samtidige oppgaver må vurderes allerede når sensor- og styringskoden lages. Vi venter ikke til del 7 med å tenke på dette.
Dato for innlevering og detaljerte rapportkrav må avklares med læreren.

## Hvordan vi vil dele koden

Vi vil dele koden etter hva den skal gjøre. Motorstyringen skal ha oppstart og stopp fra starten.
Deretter skal vi lage sensoravlesning, håndtering av målefeil og valg av retning. Manuell styring kommer senere.
Vi lager én del om gangen og bestemmer innholdet før vi skriver koden.

Etter hvert skal flere Ada-oppgaver kjøre samtidig. Vi må beskytte data som deles mellom dem, og ha én del som sender motorpådrag slik at oppgavene ikke gir motstridende beskjeder.

## Det vi må være oppmerksomme på

- Vi har planlagt tre avstandssensorer, men ingen bak. Automatisk rygging venter til bakoverdekning er løst og testet.
- Sidebevegelse og rotasjon krever at vi undersøker plassen rundt hele bilen, også hjørner og hjul.
- En gammel eller mislykket måling skal ikke tolkes som fri vei.
- Ultralyd fra de andre sensorene og andre biler kan forstyrre målingene. Dette må prøves.
- Motorenes strømbehov, målt fart og stopplengde er ikke ferdig avklart.
- Motorbiblioteket kontrollerer ikke alle I2C-feil, og deler av driveren kan vente uten en fungerende tidsgrense. Dette må følges opp. Vi må også kontrollere at motorene faktisk stopper når vi sender stopp.
- Sensorbibliotekets venteløkker må også kontrolleres før vi bruker dem. Vi trenger en måling som avsluttes selv om Echo uteblir.

De første motortestene gjøres med hjulene fri og mulighet til å koble fra motorstrømmen.
Start, avbrudd og faktisk stopp må være undersøkt før automatisk gulvkjøring.

## Samarbeid og rapport

Læreren anbefaler grupper på tre. Grupper på to krever et særskilt unntak. Alle skal programmere.
Vi fordeler små kodeoppgaver og fører det vi faktisk gjør i [arbeidsloggen](arbeidslogg/README.md).
Tester og målinger føres i [testloggen](testlogg/README.md).

Rapporten skal forklare oppgaven, løsningen, arbeidet og resultatene. De endelige innholdskravene må vi få fra læreren.
Rapporten må være godkjent før eksamen.
