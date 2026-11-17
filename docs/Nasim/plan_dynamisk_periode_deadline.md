# Plan for dynamisk periode for ultralydsensorer

**Prosjekt:** Mecanum-robot – Intelligent Real-Time Systems  
**Ansvarsområde:** Dynamisk periode og tidsstyring av ultralydsensorer  
**Programmeringsspråk:** Ada  
**Maskinvare:** micro:bit V2

## 1. Mål

Målet med min del av prosjektet er å planlegge og implementere dynamiske perioder for ultralydsensorene på Mecanum-roboten.

Roboten har tre ultralydsensorer: én foran, én på venstre side og én på høyre side.

I stedet for å bruke samme periode hele tiden, vil jeg undersøke hvordan perioden kan endres ut fra avstanden til hindringer og robotens bevegelsestilstand.

Når roboten nærmer seg et hinder, skal de relevante sensorene leses oftere. Når roboten er langt fra hindringer, kan perioden være lengre.

Målet er å få rask nok reaksjon på hindringer og samtidig redusere unødvendige sensoravlesninger.

## 2. Utgangspunkt og tidsberegninger

Jeg tar utgangspunkt i dokumentasjonen og beregningene som allerede er laget for ultralydsensorene i gruppen.

| Sensoravlesning | Estimert tid |
|---|---|
| Frontsensor | 76 ms |
| Venstre og høyre sensor | 102 ms |
| Alle tre sensorene | 128 ms |

Beregningene bygger på en antatt måletid på 26 ms per sensor og en pause på 50 ms.

I den eksisterende dokumentasjonen er følgende verdier foreslått for første test:

- Periode: 180 ms
- Deadline: 130 ms
- Stoppavstand foran: 20 cm
- Startavstand foran: 40 cm

Disse verdiene er foreløpige og ikke bekreftet gjennom tidsmålinger.

Vi må også kontrollere hvordan pausen på 50 ms brukes i sensorbiblioteket. Dersom pausen gjelder hver enkelt sensoravlesning, kan den totale tiden bli lengre enn beregnet.

## 3. Dynamisk periode

Jeg planlegger å bruke ulike perioder avhengig av hvor nær roboten er et hinder.

Som et første forslag vil jeg undersøke disse verdiene for frontsensoren:

| Avstand foran | Foreslått periode | Handling |
|---|---|---|
| Over 40 cm | 180 ms | Fortsette fremover og lese frontsensoren |
| Over 20 cm til og med 40 cm | 100 ms | Lese frontsensoren oftere |
| 20 cm eller mindre | Ikke fastsatt | Stoppe og undersøke sidene |

Periodene 180 ms og 100 ms er foreløpige forslag til testing. De skal ikke betraktes som ferdige eller godkjente verdier.

En periode på 100 ms kan være aktuell dersom målingen faktisk tar omtrent 76 ms, men det gir begrenset tidsmargin.

Når roboten har stoppet foran et hinder, skal venstre og høyre sensor undersøke hvor det er ledig plass. Perioden for denne fasen må bestemmes etter måling av responstiden.

## 4. Periode basert på robotens bevegelse

Sensorene skal prioriteres forskjellig avhengig av robotens bevegelse.

**Kjøring fremover:** Frontsensoren skal prioriteres. Perioden skal kunne reduseres når roboten nærmer seg et hinder.

**Stopp foran hinder:** Roboten skal stoppe og lese begge sidesensorene før den velger en ny retning.

**Svinging:** Sensorene som er nødvendige for å oppdage hindringer i svingretningen, skal prioriteres.

**Sidelengs kjøring:** Sensoren på siden roboten beveger seg mot, skal være viktigst.

**Rygging:** Sensorene kan gi informasjon om omgivelsene, men roboten har ingen egen sensor bak. Derfor må rygging vurderes spesielt med tanke på kollisjonsfare.

## 5. Deadline og prioritering

Deadline er tiden en oppgave må være ferdig innenfor, mens perioden bestemmer hvor ofte oppgaven skal utføres.

I gruppens foreløpige dokumentasjon er sensorene klassifisert slik:

| Bevegelse | Sensor | Kritikalitet |
|---|---|---|
| Fremover | Front | Hard |
| Stoppet | Sidesensorer | Soft |
| Svinging | Front | Soft |
| Svinging | Sidesensorer | Firm |
| Sidelengs kjøring | Relevant sidesensor | Hard |
| Rygging | Sidesensorer | Soft |

Jeg vil bruke denne klassifiseringen som utgangspunkt, men den må vurderes sammen med kollisjonsrisikoen.

Deadline på 130 ms er foreslått i dokumentasjonen. Før den kan brukes som en endelig grense, må vi kontrollere faktisk responstid og hvor lang tid hele sensoroppgaven bruker.

Det er spesielt viktig at sensoravlesning og motorstyring kan reagere raskt nok når roboten oppdager et hinder.

## 6. Plan for implementering i Ada

Jeg vil undersøke hvordan dynamiske perioder kan implementeres ved hjelp av `Ada.Real_Time`.

I et tidligere Mecanum-prosjekt, RavensRover, ble `Clock` og `delay until` brukt til periodisk kjøring av sensoroppgaven.

Jeg vil bruke dette som inspirasjon, men tilpasse løsningen til vår egen robot og de eksisterende funksjonene i prosjektet.

Implementeringen planlegges slik:

1. Definere perioder for ulike avstander og bevegelsestilstander.
2. Lese avstand fra frontsensoren ved hjelp av eksisterende sensorfunksjoner.
3. Bestemme neste periode ut fra sensorverdien og robotens tilstand.
4. Beregne tidspunktet for neste sensoravlesning med `Ada.Real_Time`.
5. Bruke `delay until` for å styre tidspunktet for neste måling.
6. Gjøre sensorresultatene tilgjengelige for styringssystemet.
7. Registrere responstid og eventuelle deadline-brudd.

Jeg vil også undersøke om sensoravlesningene bør organiseres i en egen Ada-task med definert prioritet, eller om dynamisk periode bør integreres direkte i den eksisterende sensorlogikken.

Dette må avklares med gruppens nåværende kode før implementeringen.

## 7. Samarbeid med styringssystemet

Min del skal samarbeide med den eksisterende motorstyringen og sensorlogikken.

Sensoroppgaven skal levere oppdaterte avstandsverdier til styringssystemet.

Når frontsensoren oppdager et hinder på 20 cm eller mindre, skal styringssystemet få beskjed om å stoppe roboten.

Etter stopp skal sidesensorene brukes til å vurdere hvilken retning roboten kan bevege seg.

Jeg vil unngå å lage en separat motorstyring, siden denne funksjonaliteten allerede er en del av gruppens arbeid.

Ved ugyldige sensordata, timeout eller andre feil må systemet velge en sikker handling. Ved usikker avstand foran roboten bør den stoppe fremfor å fortsette ukontrollert.

## 8. Testing og måling

Før periodene kan bestemmes endelig, må vi måle faktisk tidsbruk.

Jeg planlegger følgende tester:

1. Måle tiden for én frontsensor.
2. Måle tiden for begge sidesensorene.
3. Måle tiden for alle tre sensorene.
4. Kontrollere at perioden endres når avstanden til hindringer endres.
5. Teste stopp ved 20 cm og overgang til kontroll av sidesensorene.
6. Registrere om sensoroppgaven overskrider valgt deadline.
7. Kontrollere hvordan periodene påvirker styringssystemets responstid.

Jeg vil bruke `Ada.Real_Time` til tidsmålinger og sammenligne resultatene med de foreløpige beregningene.

Det må også tas hensyn til robotens hastighet, bremselengde og hvor langt roboten beveger seg mellom to sensoravlesninger.

Hvis målingene viser at en foreslått periode er for kort, må perioden eller målemetoden justeres.

## 9. Forventet resultat

Jeg forventer at dynamiske perioder kan gjøre sensoravlesningen mer effektiv og bedre tilpasset robotens bevegelse.

Når roboten er langt fra hindringer, kan den bruke lengre perioder. Når roboten nærmer seg et hinder, skal perioden kunne reduseres slik at roboten får hyppigere informasjon om avstanden.

Målet er å finne en løsning som gir god responstid, begrenset unødvendig sensoraktivitet og trygg samhandling med motorstyringen.

Planen skal først brukes som grunnlag for implementering i Ada. Deretter skal perioder, deadlines og reaksjon på hindringer testes på den fysiske roboten.
