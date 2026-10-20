# Dokumentasjon

Her samler vi planen for bilen, forslag til koblinger og maler for tester og arbeidslogg.
Planleggingsboken vår i Goodnotes er utgangspunktet.

## Her finner du ting

| Fil | Hva den brukes til |
|---|---|
| [Robotbil Mecanum.pdf](<Robotbil Mecanum.pdf>) | Planleggingsboken med skisser og notater. |
| [Prosjektplan](prosjektplan.md) | Målet, avgrensningen og rekkefølgen på arbeidet. |
| [Krav](krav.md) | Lærerens krav og våre egne delmål. |
| [Sensorer og utstyr](sensoroversikt.md) | Hva vi har og hva vi må undersøke. |
| [Plan for koblingene](kobling/README.md) | Forslag til forbindelser som må kontrolleres før oppkobling. |
| [Testplan](testplan.md) | Hva vi skal teste og hvordan. |
| [Testlogg](testlogg/README.md) | Forsøk, resultater og mal for nye tester. |
| [Arbeidslogg](arbeidslogg/README.md) | Arbeidsøkter og mal for nye oppføringer. |
| [Bilder og skisser](bilder/README.md) | Hvor skissene ligger og hvordan vi skal dokumentere oppkobling. |

## Hvor vi er nå

Lærerens startoppsett og driverbibliotek er på plass.

`main.adb` inneholder livstegntesten. «Kjorer.» kom opp i terminalen.
Testen er registrert som bestått for livstegn og terminalutskrift i [testloggen](testlogg/2026-10-20-livstegn.md).
Tidsnøyaktigheten er ikke dokumentert med måling.

Motorstyring, kjøring og sensoravlesning er ikke startet.

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
