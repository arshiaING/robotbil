# Testlogg

Her skriver vi hva vi prøver, hva vi forventer og hva som faktisk skjer.
Den første livstegntesten er registrert. Testing av motorstyring, kjøring og sensorer er ikke startet.

## Forsøk

- [2026-10-20 - T01 livstegntest](2026-10-20-livstegn.md)

Under ligger malen vi bruker til nye forsøk.

## Hvordan vi bruker loggen

Bruk testnumrene fra [testplanen](../testplan.md), for eksempel T01 eller T13.
Lag en datert fil for forsøket og bruk malen under.
Hvis vi tester på nytt etter en endring, lager vi en ny oppføring og viser til den forrige.

Vi skiller mellom kontroll på datamaskinen og fysisk test på bilen.
Et vellykket bygg bekrefter ikke at motorene eller sensorene virker.

## Mal for et forsøk

```markdown
# [Test-ID og kort navn]

- Dato: [dato for forsøket]
- Hvem testet: [navn]
- Krav: [K-nummer eller forutsetning]
- Kodeversjon: [commit-ID eller navn på kodeversjonen]
- Testtype: [kontroll av filer, kompilering eller fysisk test]
- Utstyr og koblinger: [det vi brukte]
- Strøm og innstillinger: [spenning, pådrag og relevante verdier]
- Valgte grenser: [tidsgrense, avvik, avstand og antall forsøk]
- Fremgangsmåte: [hva vi gjorde]
- Forventet resultat: [bestemt før forsøket]
- Faktisk resultat: [observasjoner og målinger]
- Status: [bestått, ikke bestått, delvis gjennomført eller ikke gjennomført]
- Feil og neste steg: [det vi må undersøke eller rette]
- Bilder og målinger: [lenker hvis vi har det]
```

Skriv «ikke målt» når en verdi mangler. Ikke fyll inn antakelser som målte resultater.
En kort henvisning til forsøket legges i [arbeidsloggen](../arbeidslogg/README.md).
