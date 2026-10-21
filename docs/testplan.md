# Testplan

Her planlegger vi testene for prosjektet.
Livstegn og terminalutskrift er registrert som bestått i [første del av T01](testlogg/2026-10-20-livstegn.md).
Vi har også prøvd en enkel felles motortest og fått alle fire hjulene til å rotere.
Bil-pakken er skrevet og kompilert. Byggingen er registrert i [byggeloggen](testlogg/2026-10-21-bil-bygging.md).
Oppstart, faktisk stopp og bevegelsene med den nye pakken gjenstår å teste fysisk.
Sensorarbeidet er fortsatt planlagt. Hele T01 er ikke ferdig kontrollert.
Testene er knyttet til [krav K1–K14](krav.md). T00 er kontrollen før vi begynner, og resultatene skal inn i [testloggen](testlogg/README.md).

## Før vi tester

Vi noterer kodeversjon, koblinger, strømforsyning og innstillinger.
Da vet vi hvilket program og oppsett resultatet gjelder.

Ved nye motortester skal hjulene først være fri. Vi skal begynne med lavt pådrag og kunne koble fra motorstrømmen.
Den første sensortesten skal gjøres mens bilen står stille.
En utskrift om at stopp er sendt er ikke en bekreftelse på at hjulene har stoppet.

## Tidsgrenser og måleverdier

Verdiene må bestemmes og begrunnes før testen kan vurderes som bestått.
Lærerens eventuelle tallkrav går foran forslagene våre.

| Verdi | Hva vi må finne ut | Status |
|---|---|---|
| Motorpådrag og målt fart | Hvilket pådrag vi bruker og hvor fort bilen faktisk går. | Ikke fastsatt |
| Stoppavstand | Når vi skal stoppe, faktisk stopplengde og nødvendig klaring. | Ikke fastsatt |
| Målefeil | Hvor stort avvik vi godtar ved kjente avstander. | Ikke fastsatt |
| Sensorperiode | Hvor ofte hver sensor skal måles. | Ikke fastsatt |
| Målealder | Hvor gammel en måling kan være før den ikke kan brukes. | Ikke fastsatt |
| Tidsgrense for Echo | Hvor lenge vi kan vente på at signalet begynner og slutter. | Ikke fastsatt |
| Oppgaveperioder og deadlines | Når hver oppgave skal kjøre og når den må være ferdig. | Ikke fastsatt |
| Tid til stopp | Tid fra hendelse til stoppkommando, og separat tid til fysisk stillstand. | Ikke fastsatt |
| Kommandoalder, senere | Hvor lenge en manuell kommando kan brukes uten en ny. | Ikke fastsatt |

Vi skriver også antall forsøk, underlag, hindringer og målemetode.
En grense skal ikke flyttes bare fordi en test feiler.

## Testoversikt

| Test | Krav | Planlagt gjennomføring | Forventet resultat |
|---|---|---|---|
| T00 - utstyr og koblinger | Forutsetning | Kontroller pinner, forsyning, felles GND og Echo-tilpasning. | Koblingen er dokumentert og kontrollert for delene som skal prøves. |
| T01 - motorer og bevegelser | K1 | Bygg og kjør startprogrammet. Prøv deretter én motor, hvert hjul og grunnbevegelsene. | Riktig hjul og retning reagerer. Stopp prøves fysisk. Gulvkjøring vurderes separat. |
| T02 - hindringer | K2 | Start med kjente avstander mens bilen står stille. Prøv senere hindringsstopp, og til slutt valg av fri retning. | Målingene holder valgt toleranse. Bilen stopper før kontakt og velger bare en undersøkt bevegelse. |
| T03 - flere biler | K3 | Avtal område, fart, antall forsøk og varighet. Start med to biler og øk gradvis. | Ingen kollisjon i de avtalte forsøkene. Forstyrrelser mellom ultralydsensorer registreres. |
| T04 - samtidige oppgaver | K4 | Kjør sensorer, styring og eventuell kommunikasjon samtidig. La også en del slutte å svare. | Delte data behandles riktig, og en ventende del låser ikke styring og stopp. |
| T05 - tidskrav | K5 | Mål perioder, kjøretider og respons under normal drift og feil. Gå også gjennom venteløkkene i koden. | De valgte grensene overholdes i forsøkene. Avvik og usikkerhet blir dokumentert. |
| T06 - alle programmerer | K6 | Gå gjennom kodebidrag og arbeidslogg. La hver person forklare sin del. | Alle har deltatt i programmeringen og forstår eget bidrag. |
| T07 - rapport | K7 | Sammenlign rapporten med lærerens krav og frist. Registrer levering og tilbakemelding. | Rapporten blir godkjent av læreren. Egen kontroll er ikke godkjenning. |
| T08 - manuell kjøring | K8 | Prøv hver kommando fra det manuelle brukergrensesnittet gjennom hele forbindelsen. | Kommandoene gir riktig bevegelse og stopp. |
| T09 - knappeslipp | K9 | Hold inne og slipp kjøreknappene. Prøv også avbrutt berøring og at nettleseren mister fokus. | Bilen stopper innen valgt grense. En tapt slippmelding håndteres av K10. |
| T10 - tapte kommandoer | K10 | Avbryt forbindelsene og prøv gamle, dupliserte eller ugyldige meldinger. | Bilen stopper innen valgt grense. Forbindelsen alene starter ikke bilen igjen. |
| T11 - oppstart og reset | K11 | Prøv ulike strømrekkefølger og start med knapp holdt inne. Prøv reset under kjøring med hjulene fri. | Ingen uventet start. Ny kjøring krever bevisst start. Et beholdt motorpådrag må håndteres før testen kan bestås. |
| T12 - lokal stopp | K12 | Utløs brukerstopp, hindring eller kontrollert feil under kjøring, først med hjulene fri. | Stopp får prioritet. Faktisk stillstand kontrolleres også når nettverket ikke svarer. |
| T13 - målefeil | K13 | Prøv manglende Echo, signal som blir stående høyt, ugyldige verdier og gamle målinger. | Målingen avsluttes innen valgt tid. Nødvendige ugyldige data sperrer kjøring, og andre oppgaver fortsetter. |
| T14 - kamera, valgfritt | K14 | Prøv valgt objekt, hindring, tapt objekt og gamle eller manglende bilder. | Følgingen beholder lokal hindringsstopp og stanser ved tapt grunnlag. |

## Rekkefølge

Vi begynner med T00 og startprogrammet i T01. Deretter prøver vi motorer, bevisst start og stopp.
Frontsensoren prøves i ro før sensorverdier brukes til kjøring.
T11–T13 må følges opp før automatisk gulvkjøring. T04 og T05 følger arbeidet når flere oppgaver kobles sammen.
T08–T10 kommer når manuell styring er laget, og T14 bare hvis kamera tas med.

Ved fysiske omkoblinger kobler vi fra strømmen først.
Vi beholder mislykkede resultater og lager en ny loggoppføring når vi tester på nytt.
En ufullstendig test får status «delvis gjennomført» eller «ikke gjennomført», ikke «bestått».
