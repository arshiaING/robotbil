
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

      -- Forelopige perioder for testing
      periode : Time_Span := Milliseconds (180);

      -- Forelopig deadline fra Arshias test 1
      deadline : constant Time_Span := Milliseconds (130);

      -- Pause mellom sensoravlesninger
      pause : constant Time_Span := Milliseconds (50);

      neste : Time := Clock;
      start : Time;
      slutt : Time;

      valg : sensorvalg;
      ny : verdi;

      avstand_foran : Integer := 0;

   begin

      loop

         -- Vent til planlagt starttid
         delay until neste;

         start := Clock;

         -- Hent hvilke sensorer som skal leses
         valg := lager.hent_valg;

         if valg = bare_foran then

            ny.tidspunkt := Clock;
            ny.avstand := sensor_foran.Read;
            lager.lagre_foran (ny);

            avstand_foran := Integer (ny.avstand);

         elsif valg = begge_sider then

            ny.tidspunkt := Clock;
            ny.avstand := sensor_hoyre.Read;
            lager.lagre_hoyre (ny);

            delay until Clock + pause;

            ny.tidspunkt := Clock;
            ny.avstand := sensor_venstre.Read;
            lager.lagre_venstre (ny);

         elsif valg = alle_tre then

            ny.tidspunkt := Clock;
            ny.avstand := sensor_foran.Read;
            lager.lagre_foran (ny);

            avstand_foran := Integer (ny.avstand);

            delay until Clock + pause;

            ny.tidspunkt := Clock;
            ny.avstand := sensor_hoyre.Read;
            lager.lagre_hoyre (ny);

            delay until Clock + pause;

            ny.tidspunkt := Clock;
            ny.avstand := sensor_venstre.Read;
            lager.lagre_venstre (ny);

         end if;

         -- Dynamisk periode
         -- Perioden avhenger av sensorvalg og avstand

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

         -- Registrer sluttid
         slutt := Clock;

         -- Kontroller forelopig deadline
         if slutt > start + deadline then

            Put_Line ("Deadline overskredet.");

         end if;

         -- Planlegg neste starttid
         neste := start + periode;

         -- Haandter periodeoverskridelse
         if neste <= Clock then

            Put_Line ("Periode overskredet.");
            neste := Clock + periode;

         end if;

      end loop;

   end sensoroppgave;

end ultralydsensor;
