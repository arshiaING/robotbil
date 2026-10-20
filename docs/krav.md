# Krav og prioritering

Her skiller vi mellom det læreren krever og de delmålene vi har valgt selv.
Kravene bygger på oppgaveteksten, kursoppsettet og [planleggingsboken](<Robotbil Mecanum.pdf>).
Kravene har numrene K1–K14, slik at vi kan vise til dem i testplanen og testloggen.

- **🔴 Rød:** nødvendig for oppgaven eller grunnleggende stopp og feilbehandling.
- **🟡 Gul:** eget delmål som kommer etter den første lokale versjonen.
- **🟢 Grønn:** ekstra funksjon hvis vi får tid.

Fargen viser prioritet. Den sier ikke at et krav er oppfylt.

## Krav fra oppgaven og kurset

| ID | Prioritet | Krav | Hvordan vi kontrollerer det |
|---|---|---|---|
| K1 | 🔴 Rød | Vi skal programmere bilen i Ada på Micro:bit V2. Bilen skal ha Mecanum-hjul og kunne kjøre fremover, bakover, sidelengs og rotere. | T01: kontroller oppsett, hvert hjul og bevegelsene. |
| K2 | 🔴 Rød | Bilen skal bruke sensorer til å oppdage hindringer og ta egne beslutninger som unngår kollisjon. | T02: prøv hindringer i flere plasseringer. |
| K3 | 🔴 Rød | Bilen skal kunne kjøre sammen med de andre bilene uten kollisjoner i lærerens prøveopplegg. | T03: test gradvis med flere biler. |
| K4 | 🔴 Rød | Systemet skal kunne kjøre flere oppgaver samtidig, for eksempel sensorlesing og styring. | T04: kontroller oppgavene og delte data under samtidig kjøring. |
| K5 | 🔴 Rød | Systemet skal ta hensyn til tidskrav og deadlines. | T05: bestem og dokumenter grenser, og undersøk kjøretid og responstid. |
| K6 | 🔴 Rød | Alle i gruppen skal delta i programmeringen. | T06: gjennomgå kodebidrag og arbeidslogg, og forklar arbeidet. |
| K7 | 🔴 Rød | Prosjektrapporten skal leveres og godkjennes før eksamen. | T07: følg lærerens rapportkrav og kontroller godkjenningen. |

Gruppen skal normalt ha tre personer. To personer krever særskilt tillatelse.
Vi skal også prøve å bruke relevante funksjoner på Micro:bit.
Lærerens leveringsfrist, detaljerte rapportkrav og eventuelle bestemte tidsgrenser er ikke registrert ennå.

## Våre egne krav og delmål

| ID | Prioritet | Krav | Hvordan vi kontrollerer det |
|---|---|---|---|
| K8 | 🟡 Gul | Brukeren skal senere kunne velge retning, rotasjon og stopp fra et manuelt brukergrensesnitt. | T08: prøv hver kommando gjennom hele forbindelsen. |
| K9 | 🔴 Rød | I manuell modus skal bilen stoppe når kjøreknappen slippes, innen en fastsatt responstid. | T09: mål fra knappeslipp til stopp. |
| K10 | 🔴 Rød | Gamle, ugyldige eller manglende kjørekommandoer skal ikke holde bilen i gang. | T10: avbryt forbindelsen og prøv gamle eller ugyldige meldinger. |
| K11 | 🔴 Rød | Bilen skal stå stille ved oppstart og reset. Kjøring krever en ny, bevisst start. | T11: prøv oppstart, reset og en knapp som holdes inne. |
| K12 | 🔴 Rød | Micro:bit skal håndtere lokal stopp ved hindring eller feil, uten å vente på mobil, Raspberry Pi, ESP32 eller kamera. | T12: prøv stopp også når de andre delene sender kjøring eller ikke svarer. |
| K13 | 🔴 Rød | Ugyldige, manglende eller for gamle avstandsmålinger skal sperre bevegelse som trenger disse målingene. | T13: prøv målefeil og gamle data. |
| K14 | 🟢 Grønn | Hvis vi lager kamerafølging, skal lokal hindringsstopp fortsatt gjelde. Tapt objekt eller gamle bilder skal gi stopp. | T14: prøv følging, hindring og bortfall av bilder. |

K9 og K10 tas når vi lager manuell styring. Kamera og AI er ikke krav fra læreren.

## Når er et krav oppfylt?

Vi må først velge konkrete grenser for testen, som avstand, responstid og tillatt avvik.
Deretter gjennomfører vi testen og skriver resultatet i [testloggen](testlogg/README.md).
Livstegn og terminalutskrift er registrert som bestått i [første del av T01](testlogg/2026-10-20-livstegn.md). Motorene og bevegelsene gjenstår, så hele K1 er ikke oppfylt ennå.

Se [testplanen](testplan.md) for fremgangsmåter og verdiene som fortsatt må bestemmes.
