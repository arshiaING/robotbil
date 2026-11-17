with Ada.Real_Time; use Ada.Real_Time;
with MicroBit; use MicroBit;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;
with lagring; use lagring;
with Ada.Execution_Time; use Ada.Execution_Time;

package body ultralydsensor is

   package sensor_foran is new MicroBit.Ultrasonic
     (MB_P0, MB_P1);
   package sensor_hoyre is new MicroBit.Ultrasonic
     (MB_P2, MB_P8);
   package sensor_venstre is new MicroBit.Ultrasonic
     (MB_P12, MB_P13);



   task body sensoroppgave is
   -- variabler 
      periode : constant Time_Span := Milliseconds (180); --test 1 
      deadline : constant Time_Span := Milliseconds (130); -- test 1
      pause : constant Time_Span := Milliseconds (50); -- så vi ikke leser samme igjen 
      neste : Time := Clock; -- clock gir tiden nå dette bruker jeg til å vente perioden 
      slutt : Time;


      Time_Now_CPU : CPU_Time;
      Elapsed_CPU : Time_Span;

      -- bytta variabel navn fordi jeg trykker på tab når jeg skriver og den gir meg dårlige navn og hadde verdi i lager navn så kan også bruke den her 
      -- dette bare bestemmer hva som skal kjøres kan gi oss venter, bare_foran, begge_sider og alle_tre
      valg : sensorvalg;
      -- bare lager plass ny vil bare gå inn til lager 
      ny : verdi;

   begin
      loop
         delay until neste; -- første runde går den med engang så skal den vente 180 ms til neste runde men den må også vente på at prosessoren blir ferdig først sp det kan hende at det ikke er 180ms akkurat
         Time_Now_CPU := Ada.Execution_Time.Clock;
         valg := lager.hent_valg; -- henter valg fra lager 






         -- bruker valgen til å bestemme hva som skal brukes kan bruke case her 
               
            if valg = bare_foran then
               ny.tidspunkt := Clock; -- om foran ikke Reader tror jeg den vil bare vente så det kommer kl også venter den så det kan bli feil (kan løse dette ved å sette tid på det så om det tar for mye tid gå videre )
               ny.avstand := sensor_foran.Read;
               lager.lagre_foran (ny);

         elsif valg = begge_sider then

            ny.tidspunkt := Clock;
            ny.avstand := sensor_hoyre.Read;
            lager.lagre_hoyre (ny);

            ny.tidspunkt := Clock;
            ny.avstand := sensor_venstre.Read;
            lager.lagre_venstre (ny);

         elsif valg = alle_tre then
            ny.tidspunkt := Clock;
            ny.avstand := sensor_foran.Read;
            lager.lagre_foran (ny);

            ny.tidspunkt := Clock;
            ny.avstand := sensor_hoyre.Read;
            lager.lagre_hoyre (ny);


            ny.tidspunkt := Clock;
            ny.avstand := sensor_venstre.Read;
            lager.lagre_venstre (ny);
            
         end if;


         -- vis valg blir venter så vil den bare komme ned hit 
         Elapsed_CPU := Ada.Execution_Time.Clock - Time_Now_CPU;
         slutt := Ada.Real_Time.Clock;

         if valg = bare_foran then
            Put_Line
              ("CPU time: " & Duration'Image (To_Duration (Elapsed_CPU))
               & " seconds");
            Put_Line
              ("Response time: " & Duration'Image (To_Duration (slutt - neste))
               & " seconds");

            if slutt > neste + deadline then
               Put_Line ("Deadline");
            end if;
         end if;

         delay until slutt + pause;
         neste := neste + periode;
      end loop;

   end sensoroppgave;

end ultralydsensor;
