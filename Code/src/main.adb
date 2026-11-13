with Ada.Real_Time; use Ada.Real_Time;
with ultralydsensor;
with think;
with styring;

procedure Main with Priority => 0 is
begin
   loop
      delay until Clock + Seconds (1);
   end loop;
end Main;