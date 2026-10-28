with Ada.Real_Time; use Ada.Real_Time;
with bil;
with microbit.console; use microbit.console;
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
   put_line ("frontsensor klar.");

      
   loop
   
   
   
   
   avstand := ultralyd.les_foran;
   if avstand = 0 then
      put_line ("ingen gyldig avstand.");
   else
      put_line ("avstand:" & natural'image (avstand) & " cm");
   end if;

   delay until clock + milliseconds (200);
end loop;
end Main;