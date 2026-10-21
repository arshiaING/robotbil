# Motorplan

## Målet

Vi skal lage motorstyring som kan brukes til både
manuell og automatisk kjøring.

Bilen skal kunne kjøre fremover, bakover, sidelengs,
rotere til høyre og venstre og stoppe.

## Hva vi har laget

Motorstyringen er samlet i pakken Bil.

- bil.ads beskriver kommandoene vi kan bruke.
- bil.adb inneholder hvordan kommandoene styrer motorene.
- main.adb bestemmer hvilke kommandoer som skal kjøres.

| Del | Kommandoer | Status |
|---|---|---|
| V1 | Initialize, stopp, fremover og bakover | Skrevet og kompilert |
| V2 | snu_hoyre og snu_venstre | Skrevet og kompilert |
| V3 | sidelengs_hoyre og sidelengs_venstre | Skrevet og kompilert |

Hovedprogrammet kaller foreløpig bare Bil.Initialize.
Denne klargjør motorkortet og sender stopp.
Deretter blir hovedprogrammet stående i en venteløkke.

## Motorpådrag

Kommandoene bruker kraft fra 0 til 100.
Verdien regnes om til motorpådrag fra 0 til 4095.

Motorpådraget er ikke en måling av bilens faktiske fart.

## Hva vi har testet

Vi har gjennomført en enkel motortest med pådrag 2044.
Testprogrammet var satt til 10 sekunders kjøring før stopp.

Først fungerte ikke de to bakhjulene. Etter videre testing
fikk vi alle fire hjulene til å rotere.
Årsaken til problemet ble ikke fastslått.

Dette forsøket ble gjort før motorstyringen ble samlet i Bil.

Bil-pakken er kompilert sammen med hovedprogrammet.
Bevegelsene med den nye pakken er ikke fysisk testet ennå.

## Neste steg

Vi skal først kontrollere oppstart og faktisk stopp.
Deretter tester vi én bevegelse om gangen, med stopp mellom.

Vi begynner med hjulene fri og motorstrømmen lett tilgjengelig
for frakobling. Før gulvkjøring skal vi ha bevisst start
og mulighet til å avbryte kjøringen.

Hjulretningene kontrolleres mot
[hjulkartleggingen](hjulkartlegging.md).

## Det vi må følge opp

Motorbiblioteket håndterer ikke alle kommunikasjonsfeil.
En stoppkommando alene bekrefter derfor ikke fysisk stillstand.

Fart, stopplengde og responstid er ikke målt.
Resultatene skal føres i testloggen når forsøkene gjennomføres.

## Hvordan vi skal teste



Kommer!