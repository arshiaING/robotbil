with Ada.Real_Time; use Ada.Real_Time;
with MicroBit; use MicroBit;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;
with lagring; use lagring;

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
      neste : Time := Clock; 
      slutt : Time;

      -- bytta variabel navn fordi jeg trykker på tab når jeg skriver og den gir meg dårlige navn og hadde verdi i lager navn så kan også bruke den her 
      valg : sensorvalg;
      ny : verdi;

   begin
      loop
         delay until neste;

         valg := lager.hent_valg;

         -- valg gar en som er vent fordi den ikke passer inn her så vil den bare gå videre vi for bare tidmeldign 
               -- dette bare bestemmer hva som skal kjøres
            if valg = bare_foran then
               ny.tidspunkt := Clock;
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



         slutt := Clock;

            
        --test for perioden    
         Put_Line("Tid til sluttkontroll:" & Duration'Image(To_Duration (slutt - neste)) & " s");



         if slutt > neste + deadline then
            Put_Line("Sluttkontrollen var etter testfristen.");
         end if;

         delay until slutt + pause;

         neste := neste + periode;
      end loop;

   end sensoroppgave;

end ultralydsensor;
