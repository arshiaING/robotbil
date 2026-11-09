# Arbeidslogg - 2026-10-21

- Hvem jobbet: Arshia
- Hva vi gjorde: Samlet motorstyringen i pakken Bil og koblet den til hovedprogrammet.
- Programmering: Jobbet med kommandoene i `bil.ads` og `bil.adb`: oppstart, stopp, fremover, bakover, rotasjon og sidelengs kjøring. Endret `main.adb` til å bruke `Bil.Initialize` og la `src/motor` til i `Code/itrs.gpr`.
- Status: Skrevet og kompilert. Bevegelsene med den nye Bil-pakken er ikke fysisk testet ennå.
- Hva vi testet: [T01 - bygging av Bil-pakken] Både `main.adb` og `bil.adb` ble kompilert, og byggingen gikk bra.
- Problemer: Retningssignalene for sidelengs kjøring ble rettet under gjennomgangen av koden. Retningene må fortsatt kontrolleres på bilen.
- Dokumentasjon: Testloggen for byggingen og statusen i oversiktene er oppdatert.
- Neste steg: Kontrollere oppstart og faktisk stopp. Deretter teste én bevegelse om gangen med hjulene fri.
