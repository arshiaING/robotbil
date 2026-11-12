Min del-Nasim
Dynamisk periode og deadline for ultralydsensorer
1. Innledning
I dette prosjektet jobber vi med en Mecanum-robot som skal kunne bevege seg uten å kollidere med hindringer. Roboten bruker tre ultralydsensorer: en foran, en på venstre side , en på høyre side.
Min del av prosjektet handler om dynamisk periode og deadline for ultralydsensorene.
En periode bestemmer hvor ofte en oppgave skal utføres. En deadline bestemmer hvor lang tid oppgaven har på å bli ferdig.
I et sanntidssystem er dette viktig fordi roboten må få informasjon fra sensorene og reagere raskt nok på hindringer.
Jeg har jobbet med en løsning perioden kan endres etter avstanden til hindringer og hvilke sensorer som brukes.
2. Mål
Målet med arbeidet mitt er å lage en dynamisk periode for ultralydsensorene i Ada.
Jeg ønsker at roboten skal lese frontsensoren oftere når den nærmer seg en hindring, og sjeldnere når det er bra plass.
Jeg vil også kontrollere om sensoroppgaven blir ferdig innenfor en bestemt deadline.
Målet er å redusere unødvendige sensormålinger og samtidig gi styringssystemet oppdaterte avstandsverdier.
3. Utgangspunkt og planlegging
Jeg har tatt utgangspunkt i lærerens eksempel med Ada.Real_Time, Clock og delay until.
Jeg har brukt samme prinsipp, men laget en løsning der perioden kan endres under kjøring.
Jeg har også brukt den eksisterende ultralydsensorkoden fra Arshia, siden vi arbeider med de samme tre sensorene.
Sensoravlesning	Estimert tid
Frontsensor	76 ms
Begge sidesensorene	102 ms
Alle tre sensorene	128 ms
Disse beregningene bygger på antatte måletider og en pause på 50 ms. De brukes som et utgangspunkt for valg av periode og deadline.
I den første planen vurderte jeg også andre perioder, blant annet 100 ms og 180 ms for frontsensoren. Under implementasjonen valgte jeg flere perioder for forskjellige avstander og sensorvalg.
4. Implementasjon i Ada
Jeg har skrevet kode for dynamisk periode og kontroll av deadline i Ada.
Koden er lagret på GitHub i min egen branch, nasim-dynamisk-periode, i filen dynamisk_periode_nasim.adb.
4.1 Periode og deadline
Jeg har definert perioden, deadline og pausen mellom sensoravlesningene:
periode : Time_Span := Milliseconds (180);
deadline : constant Time_Span := Milliseconds (130);
pause : constant Time_Span := Milliseconds (50);
Jeg bruker Time_Span fra Ada.Real_Time for å håndtere tidsverdiene.
Perioden er en variabel fordi den skal kunne endres under kjøring. Deadline er satt til 130 ms som en foreløpig tidsgrense, mens pausen mellom sensoravlesningene er satt til 50 ms.
4.2 Valg av sensorer
Sensoroppgaven bruker lager.hent_valg for å finne ut hvilke sensorer som skal leses.
valg := lager.hent_valg;
Jeg bruker fire forskjellige sensorvalg:
venter: Ingen sensoravlesning i denne kjøringen.
bare_foran: Bare frontsensoren.
begge_sider: Høyre og venstre sensor.
alle_tre: Alle tre sensorene.
Når bare frontsensoren brukes, leses avstanden og lagres slik:
ny.tidspunkt := Clock;
ny.avstand := sensor_foran.Read;
lager.lagre_foran (ny);
avstand_foran := Integer (ny.avstand);
Avstanden fra frontsensoren brukes videre til å bestemme neste periode.
4.3 Dynamisk periode
Dette er hoveddelen av arbeidet mitt.
Jeg har laget forskjellige perioder avhengig av sensorvalg og avstanden foran roboten.
if valg = venter then
   periode := Milliseconds (400);
elsif valg = alle_tre then
   periode := Milliseconds (400);
elsif valg = begge_sider then
   periode := Milliseconds (300);
elsif valg = bare_foran then
   if avstand_foran <= 20 then
      periode := Milliseconds (180);
   elsif avstand_foran <= 50 then
      periode := Milliseconds (240);
   else
      periode := Milliseconds (350);
   end if;
end if;
Når bare frontsensoren brukes, har jeg valgt følgende perioder:
Avstand foran roboten	Periode
20 cm eller mindre	180 ms
Over 20 cm til 50 cm	240 ms
Over 50 cm	350 ms
Hvis roboten kommer nær en hindring, blir perioden kortere. Da kan frontsensoren lese avstanden oftere.
Hvis hindringen er langt unna, blir perioden lengre.
Når begge sidesensorene brukes, er perioden 300 ms. Når alle tre sensorene brukes, er perioden 400 ms.
Jeg har valgt lengre perioder når flere sensorer brukes, fordi flere sensoravlesninger kan kreve mer tid.
4.4 Deadline og tidskontroll
Jeg har også lagt inn en kontroll for å undersøke om sensoroppgaven overskrider deadline.
Før sensoravlesningene registrerer jeg starttidspunktet:
start := Clock;
Etter sensoravlesningene registrerer jeg sluttidspunktet:
slutt := Clock;
Deretter kontrollerer programmet deadline:
if slutt > start + deadline then
   Put_Line ("Deadline overskredet.");
end if;
Hvis utførelsestiden blir lengre enn 130 ms, skriver programmet meldingen Deadline overskredet.
Denne kontrollen brukes til å registrere et deadline-brudd. Den stopper ikke roboten automatisk.
4.5 Planlegging av neste kjøring
Jeg bruker delay until for å styre når sensoroppgaven skal starte neste gang.
delay until neste;
Etter sensoravlesningene beregnes neste starttidspunkt:
neste := start + periode;
if neste <= Clock then
   Put_Line ("Periode overskredet.");
   neste := Clock + periode;
end if;
Hvis neste planlagte starttidspunkt allerede er passert, skriver programmet en melding og planlegger en ny starttid.
Dette gjør at sensoroppgaven kan bruke forskjellige perioder mellom kjøringene.
5. Hvorfor jeg har valgt denne løsningen
Jeg har valgt dynamisk periode fordi roboten ikke alltid trenger like hyppige sensormålinger.
Når roboten kjører fremover og har god plass, kan frontsensoren bruke en lengre periode.
Når roboten nærmer seg en hindring, blir perioden kortere, slik at roboten kan få informasjon om avstanden oftere.
Når roboten trenger å undersøke hvilken vei den kan kjøre, kan begge sidesensorene brukes.
På denne måten ønsker jeg å tilpasse sensoravlesningene til robotens situasjon.
6. Samarbeid med resten av roboten
Min kode skal fungere sammen med den eksisterende sensorlogikken og motorstyringen.
Sensoroppgaven leser avstandene og lagrer resultatene gjennom lagring. Styringssystemet skal bruke disse verdiene for å bestemme hvordan roboten skal bevege seg.
Når frontsensoren oppdager en hindring på 20 cm eller mindre, er målet at roboten skal stoppe og undersøke sidene før den velger en ny retning.
Min del styrer perioden for sensoroppgaven, mens motorstyringen er en annen del av gruppeprosjektet.
7. Testing og utfordringer
Vi skal undersøke hvordan de dynamiske periodene fungerer sammen med resten av roboten.
Først skal vi bruke en fast periode på 200 ms. Deretter skal vi teste de dynamiske periodene og måle utførelsestiden for de forskjellige sensorvalgene.
En utfordring er at sensoroppgaven bruker mer tid når flere sensorer leses. Vi må også ta hensyn til pausene mellom målingene.
Vi skal kontrollere om deadline på 130 ms kan overholdes, og om perioden endres riktig når avstanden til hindringer endres.
I koden min endres perioden etter avstanden når bare frontsensoren brukes. Når alle tre sensorene brukes, er perioden satt til 400 ms.
Resultatene skal brukes til å vurdere om periodene eller deadline må justeres.
8. Oppsummering
Jeg har skrevet kode for dynamisk periode og deadline for ultralydsensorene på Mecanum-roboten.
Jeg har brukt Ada.Real_Time, Clock og delay until for å styre når sensoroppgaven skal kjøre.
Perioden endres etter sensorvalget og avstanden foran roboten. Jeg har også lagt inn kontroll av deadline og periodeoverskridelse.
Målet med arbeidet mitt er at roboten skal kunne lese sensorene oftere når det er nødvendig, og samtidig redusere unødvendige sensormålinger.

