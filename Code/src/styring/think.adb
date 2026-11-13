-- think skal velge beveglsen ut fra hva den for fra sensor den må snakke med lageret og styring
-- som jeg forklarte i styringen må jeg kutte ned reglenen fordi jeg har ikke nok tid
-- i strten blir det stopp og sjekker front sensoren (må for gyldig måling)
-- frontsensoren kjøres i en loop der det ser om noe er 20 cm unna om noe er nørme stopp om ikke loop dette her
-- om den stopper bruker den velg og bytter til sidesensorene
-- begge sensorenne må ha 12 cm, den velger siden med mest plass og om de er like bruker den favorit side som forige regel forklaring og om det er
--  ikke noe plass blir det bare stopp
-- om alt er riktig så skal den snu den bruker da alle sensorenen om sidenen blir mindre en 12 stopp
-- når front for 40 cm går den helt til toppen




with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types;
with lagring; use lagring;
with styring;



--test
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Console; use MicroBit.Console;




package body think is

   use type MicroBit.Types.Distance_cm;

   periode : constant Time_Span := Milliseconds (50); -- test 1
   maks_alder : constant Time_Span := Milliseconds (300); -- random

   type tilstand is
     (venter_foran, kjorer_fremover, sjekker_sider,
      klar_sving, svinger); -- dette er tilstander jeg kan få


   function gyldig (v : verdi; tid : Time) return Boolean is -- lager en funksjon som bare sjekker om verdien er riktig true om alt er bra og fals vis ikke
   begin
      return v.avstand >= 2
        and then tid - v.tidspunkt <= maks_alder;
   end gyldig;

   task body tenkeoppgave is

      neste : Time := Clock; -- som lager
      tid : Time; -- skal bruke dette her i gyldig når jeg kommer så langt

      status : tilstand := venter_foran; -- hva den tenker nå dette lar koden huske hva vi gjør

      -- lokalt
      foran : verdi;
      hoyre : verdi;
      venstre : verdi;


      --test

      Time_Now_CPU : CPU_Time;
      Elapsed_CPU : Time_Span;
      slutt : Time;

   begin
      styring.stopp; -- bruker den bare til å stoppe bilen i starten fær loop
      lager.velg (bare_foran);

      loop
         delay until neste; -- venter på tiden vi har valgt
         -- henter sensor verdi

         --test
         Time_Now_CPU := Ada.Execution_Time.Clock;

         foran := lager.hent_foran;
         hoyre := lager.hent_hoyre;
         venstre := lager.hent_venstre;

         -- dette for vi når vi henter verdienen skal brukes i gyldig
         tid := Clock;


         if status = venter_foran then -- venter den på måling
            if gyldig (foran, tid)
            then

               if foran.avstand > 20 then -- om det er mer en 20 cm så blir styring fremover og status registeres som at vi kjærer frem
                  styring.fremover;
                  status := kjorer_fremover;
               else -- dette er om vi ikke har 20 cm
                  lager.velg (begge_sider); -- ber om å sjekke side sensor
                  status := sjekker_sider;
               end if;
            end if;

         elsif status = kjorer_fremover then
            if not gyldig (foran, tid) then -- sjekk
               styring.stopp;
               lager.velg (bare_foran);
               status := venter_foran;
            elsif foran.avstand <= 20 then -- sjekk
               styring.stopp;
               lager.velg (begge_sider);
               status := sjekker_sider;
            end if;



         elsif status = sjekker_sider then -- alt som må vøre riktig
            if gyldig (venstre, tid)
              and then gyldig (hoyre, tid)
              and then venstre.avstand >= 12
              and then hoyre.avstand >= 12
            then
               lager.velg (alle_tre);
               status := klar_sving;
            end if;


 -- etter at sidene er riktig så skal den sjekke om alt til foran er klar
         elsif status = klar_sving then
            if gyldig (foran, tid)
              and then gyldig (venstre, tid)
              and then gyldig (hoyre, tid)

            then
               if venstre.avstand < 12 or else hoyre.avstand < 12 then -- sjekker om det er plass
                  lager.velg (begge_sider);
                  status := sjekker_sider;

               else -- sjekker hvilken side som har mest plass
                  if venstre.avstand > hoyre.avstand then
                     styring.sving_venstre;
                  else
                     styring.sving_hoyre;
                  end if;

                  status := svinger;
               end if;
            end if;


         elsif status = svinger then -- sjekk om det må stoppe
            if not gyldig (foran, tid)
              or else not gyldig (venstre, tid)
              or else not gyldig (hoyre, tid)
              or else venstre.avstand < 12
              or else hoyre.avstand < 12

            then
               styring.stopp;
               lager.velg (begge_sider);
               status := sjekker_sider;
            elsif foran.avstand >= 40 then -- om den ser 40 cm foran ser så starter den å kjøre
               styring.fremover;
               lager.velg (bare_foran);
               status := kjorer_fremover;
            end if;
         end if;

         Elapsed_CPU := Ada.Execution_Time.Clock - Time_Now_CPU;
         slutt := Ada.Real_Time.Clock;

         Put_Line("Think CPU time: " & Duration'Image (To_Duration (Elapsed_CPU))& " seconds");
         Put_Line("Think response time: " & Duration'Image (To_Duration (slutt - neste))& " seconds");

         neste := neste + periode;
      end loop;
   end tenkeoppgave;

end think;