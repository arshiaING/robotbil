with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with MicroBit.Console; use MicroBit.Console;
with MicroBit; use MicroBit;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Ultrasonic;

-- USN PROJECT TEMPLATE INTELLIGENT REAL-TIME SYSTEMS
-- Project name: [ADAM]
-- Project members: [Arshia, Nasim, Leo.]


procedure Main with Priority => 0 is
   package sensor_foran is new MicroBit.Ultrasonic (MB_P1, MB_P2);
   package sensor_venstre is new MicroBit.Ultrasonic (MB_P8, MB_P13);
   package sensor_hoyre is new MicroBit.Ultrasonic (MB_P14, MB_P15);

   avstand : Distance_cm;
begin
   put_line ("starter test av tre ultralydsensorer.");

   -- sender stopp før sensortesten
   Drive (Stop);

   put_line ("sensorer klare.");



   -- leser én sensor om gangen så de ikke sender samtidig
   loop
      avstand := sensor_foran.Read;

      -- verdier under 2 betyr at målingen er ugyldig
      if avstand < 2 then
         put_line ("foran ikke gyldig.");
      else
         put_line ("foran:" & Distance_cm'image (avstand) & " cm");
      end if;

      -- pause så vi rekker å lese utskriften
      delay until clock + seconds (1);


      avstand := sensor_venstre.Read;

      if avstand < 2 then
         put_line ("venstre ikke gyldig.");
      else
         put_line ("venstre:" & Distance_cm'image (avstand) & " cm");
      end if;

      delay until clock + seconds (1);


      avstand := sensor_hoyre.Read;

      if avstand < 2 then
         put_line ("høyre ikke gyldig.");
      else
         put_line ("høyre:" & Distance_cm'image (avstand) & " cm");
      end if;

      put_line ("");
      delay until clock + seconds (1);
   end loop;
end Main;