with Ada.Real_Time; use Ada.Real_Time;
with bil;
with MicroBit.Console; use MicroBit.Console;
with ultralyd;

-- USN PROJECT TEMPLATE INTELLIGENT REAL-TIME SYSTEMS
-- Project name: [ADAM]
-- Project members: [Arshia, Nasim, Leo.]


procedure Main with Priority => 0 is
avstand : natural;
begin
   put_line ("starter test av tre ultralydsensorer.");

   -- klargjør motorkortet og sender stopp ved oppstart
   bil.initialize;
   ultralyd.initialize;

   put_line ("sensorer klare.");



   -- leser én sensor om gangen så de ikke sender samtidig
   loop
      avstand := ultralyd.les_foran;

      -- 0 betyr at målingen er ugyldig
      if avstand = 0 then
         put_line ("foran ikke gyldig.");
      else
         put_line ("foran:" & natural'image (avstand) & " cm");
      end if;

      -- pause så vi rekker å lese utskriften
      delay until clock + seconds (1);


      avstand := ultralyd.les_venstre;

      if avstand = 0 then
         put_line ("venstre ikke gyldig.");
      else
         put_line ("venstre:" & natural'image (avstand) & " cm");
      end if;

      delay until clock + seconds (1);


      avstand := ultralyd.les_hoyre;

      if avstand = 0 then
         put_line ("høyre ikke gyldig.");
      else
         put_line ("høyre:" & natural'image (avstand) & " cm");
      end if;

      put_line ("");
      delay until clock + seconds (1);
   end loop;
end Main;