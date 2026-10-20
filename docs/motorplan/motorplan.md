# Motorplan

## Målet

Vi skal lage motorstyring som vi senere kan bruke til både
manuell og automatisk kjøring.

Bilen skal kunne kjøre fremover, bakover, sidelengs,
rotere til høyre og venstre og stoppe.

## Hvor vi er nå

Vi har laget et enkelt testprogram i main.adb.
Programmet gir motorpådrag 2044 og er satt til å kjøre
i 10 sekunder før det sender stopp.

Under testingen fungerte først ikke de to bakhjulene.
Etter videre testing fikk vi alle fire hjulene til å rotere.

Programmet starter automatisk. Bevisst start og mulighet
til å avbryte kjøringen skal legges til senere.

## Rekkefølgen videre
w
| Del | Hva vi skal gjøre |
|---|---|
| 1 | Kartlegge hvilken motorutgang som styrer hvert hjul. |
| 2 | Samle motorstyringen i Bil og lage Initialize og stopp. |
| 3 | Legge til bevisst start og mulighet til å avbryte testen. |
| 4 | Lage og teste fremover og bakover. |
| 5 | Lage og teste rotasjon til høyre og venstre. |
| 6 | Lage og teste sidelengs kjøring. |
| 7 | Bruke motorstyringen sammen med frontsensoren. |

Hjulkoblingene føres i [hjulkartleggingen](hjulkartlegging.md).

## Hvordan vi vil dele koden

Vi planlegger å lage disse filene:

- bil.ads: viser hvilke kommandoer motorstyringen tilbyr.
- bil.adb: inneholder hvordan kommandoene styrer motorene.
- main.adb: bestemmer hvilke kommandoer som kjøres og når.

Ventingen mellom bevegelsene legges i main.adb.
Bil skal håndtere oppsettet og motorpådragene


## Hvordan vi skal teste



Kommer!