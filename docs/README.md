# Dokumentasjon

Her samler vi planen for bilen, forslag til koblinger og maler for tester og arbeidslogg.
Planleggingsboken vår i Goodnotes er utgangspunktet.

## Her finner du ting

| Fil | Hva den brukes til |
|---|---|
| [Robotbil Mecanum.pdf](<Robotbil Mecanum.pdf>) | Planleggingsboken med skisser og notater. |
| [Prosjektplan](prosjektplan.md) | Målet, avgrensningen og rekkefølgen på arbeidet. |
| [Motorplan](motorplan/motorplan.md) | Motorstyringen, status og neste steg. |
| [Hjulkartlegging](motorplan/hjulkartlegging.md) | Hjulnavnene og retningene vi bruker i koden. |
| [Krav](krav.md) | Lærerens krav og våre egne delmål. |
| [Sensorer og utstyr](sensoroversikt.md) | Hva vi har og hva vi må undersøke. |
| [Plan for koblingene](kobling/README.md) | Forslag til forbindelser som må kontrolleres før oppkobling. |
| [Testplan](testplan.md) | Hva vi skal teste og hvordan. |
| [Testlogg](testlogg/README.md) | Forsøk, resultater og mal for nye tester. |
| [Arbeidslogg](arbeidslogg/README.md) | Arbeidsøkter og mal for nye oppføringer. |
| [Bilder og skisser](bilder/README.md) | Hvor skissene ligger og hvordan vi skal dokumentere oppkobling. |

## Hvor vi er nå

Lærerens startoppsett og driverbibliotek er på plass.
Livstegntesten er registrert i [testloggen](testlogg/2026-10-20-livstegn.md).

Vi har også prøvd en enkel felles motortest. Etter videre testing fikk vi alle fire hjulene til å rotere.
Forsøket er beskrevet i [motorplanen](motorplan/motorplan.md).

Motorstyringen er nå samlet i Bil. V1, V2 og V3 er skrevet og kompilert.
Byggingen er registrert i [byggeloggen](testlogg/2026-10-21-bil-bygging.md).

`main.adb` kaller foreløpig bare `Bil.Initialize`, som klargjør motorkortet og sender stopp.
Deretter venter hovedprogrammet.

Bevegelsene med den nye Bil-pakken er ikke fysisk testet ennå.
Sensorarbeidet er fortsatt planlagt.
Neste steg er å kontrollere oppstart og faktisk stopp, og så teste én bevegelse om gangen.

## Lærerens filer

[Lærerens README](../README-larer.md) og [installasjonsveiledningen](../setup/local.md) følger med prosjektet.
Startoppsettet kommer fra [ITRS26, versjon e1e9efc](https://github.com/aiunderstand/ITRS26/tree/e1e9efc8afd79206f152ccc7d667dc466bf74921).

`index.html`, `app.mjs`, `.nojekyll` og `vendor/` i denne mappen tilhører lærerens nettleserverktøy for Micro:bit. De er beholdt som i lærermalen.

## Bygging i VS Code

- `Build` kompilerer programmet.
- `Build & Flash` kompilerer og overfører programmet til Micro:bit. Dette er standardoppgaven i lærermalen.
- `Choose project...` bygger det valgte eksemplet. Teksten i lærermalen nevner også overføring, men denne oppgaven kjører bare bygging.

Når vi bare skal kompilere, velger vi `Build` fra `Terminal > Run Task...`.

## Bygging på GitHub

GitHub-oppsettet er satt opp til å bygge programmet på Linux ved push eller pull request til `main`.
De utvidede testjobbene i lærermalen kjører bare i repoet som er angitt i jobbene.
Vi må se resultatet fra en faktisk kjøring før vi fører programmet som kompilert.
