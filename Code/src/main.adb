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
   put_line ("starter sensortest.");

   bil.initialize;
   ultralyd.initialize;

   put_line ("sensorer klare.");



   loop


   avstand := ultralyd.les_foran;

   if avstand = 0 then
      put_line ("foran: ingen gyldig avstand.");
   else
      put_line ("foran:" & natural'image (avstand) & " cm");
   end if;

   delay until clock + milliseconds (100);




   avstand := ultralyd.les_venstre;

   if avstand = 0 then
      put_line ("venstre: ingen gyldig avstand.");
   else
      put_line ("venstre:" & natural'image (avstand) & " cm");
   end if;

   delay until clock + milliseconds (100);




   avstand := ultralyd.les_hoyre;

   if avstand = 0 then
      put_line ("hoyre: ingen gyldig avstand.");
   else
      put_line ("hoyre:" & natural'image (avstand) & " cm");
   end if;

   delay until clock + milliseconds (100);


   end loop;
end Main;