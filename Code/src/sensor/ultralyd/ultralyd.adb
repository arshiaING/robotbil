with MicroBit;
with nRF.GPIO; use nRF.GPIO;
with MicroBit.TimeHighspeed;
with Ada.Real_Time; use Ada.Real_Time;



package body Ultralyd is



   Trig : GPIO_Point renames MicroBit.MB_P1;
   Echo : GPIO_Point renames MicroBit.MB_P2;


      procedure Initialize is
      oppsett : GPIO_Configuration :=
        (Mode         => Mode_Out,
         Resistors    => No_Pull,
         Input_Buffer => Input_Buffer_Connect,
         Drive        => Drive_S0S1,
         Sense        => Sense_Disabled);
   begin
      Trig.Clear;
      Trig.Configure_IO (oppsett);

      oppsett.Mode := Mode_In;
      Echo.Configure_IO (oppsett);
   end Initialize;






 -- snder en startpuls 
      procedure send_puls is
   begin
      Trig.Clear;
      MicroBit.TimeHighspeed.Delay_Us (2);

      Trig.Set;
      MicroBit.TimeHighspeed.Delay_Us (10);
      Trig.Clear;
   end send_puls;

 --  venter på at echo signalet hæyt med en ventefrist på 10 millisekunder.
   function sjekk_ultralyd return boolean is
      tid : constant time := clock + Milliseconds (10);
   begin
      loop 

      if clock > tid then
         return false;
      end if;

      if Echo.set then
         return true;
      end if;
      end loop;
   end sjekk_ultralyd;

end Ultralyd;