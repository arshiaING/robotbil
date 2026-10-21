# T01 - bygging av Bil-pakken

- Dato: 2026-10-21
- Hvem testet: Arshia
- Krav: K1, som en del av T01
- Kodeversjon: Arbeidskopien på grenen motorstyring
- Testtype: Bygging på PC (kompilering)

## Hva vi gjorde

Vi har samlet motorstyringen i Bil.
Vi la motorfilene i `Code/src/motor` og tok med mappen i `Code/itrs.gpr`.
Deretter endret vi `main.adb` til å kalle `Bil.Initialize`.

Vi kjørte denne kommandoen:

```bash
python3 tools/mb.py build --use template
```

## Hva vi forventet

Hovedprogrammet og Bil-pakken skulle bygges uten feil.

## Hva som skjedde

Både `main.adb` og `bil.adb` ble kompilert.
Byggingen gikk bra og ga denne meldingen:

```text
✓ Build finished successfully in 1.51 seconds.
```

Det ble laget tre firmwarefiler: `build/main.elf`, `build/main.hex` og `build/main.bin`.

## Status

Bestått for bygging. V1, V2 og V3 er skrevet og kompilert.

Hovedprogrammet kaller foreløpig bare `Initialize`.
Vi har ikke fysisk testet bevegelsene med den nye Bil-pakken ennå.
Hele T01 og K1 er derfor ikke ferdig kontrollert.

## Neste steg

Først skal vi kontrollere oppstart og at hjulene faktisk stopper.
Deretter tester vi én bevegelse om gangen, med stopp mellom testene.

Se [testplanen](../testplan.md).
