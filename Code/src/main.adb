with Ada.Real_Time; use Ada.Real_Time;
with bil;

-- USN PROJECT TEMPLATE INTELLIGENT REAL-TIME SYSTEMS
-- Project name: [ADAM]
-- Project members: [Arshia, Nasim, Leo.]



procedure Main with Priority => 0 is
begin
   Bil.Initialize;
   

   loop
      delay until Clock + Seconds (1);
   end loop;
end Main;