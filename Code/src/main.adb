with MicroBit.Console; use MicroBit.Console;
use MicroBit;
with Ada.Real_Time; use Ada.Real_Time;
-- USN PROJECT TEMPLATE INTELLIGENT REAL-TIME SYSTEMS
-- Project name: [ADAM]
-- Project members: [Arshia, Nasim, Leo.]


procedure Main with Priority => 0 is
   tid : Time := Clock;


begin
   Put_Line ("Starter livstegntest.");

   loop
   
      Put_Line ("Kjorer.");

      tid := tid + Seconds (1);
      delay until tid;
   
   
   
   
   
   
   
   
   
   
   end loop;
end Main;