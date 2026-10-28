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


   function tid_hoy return time_span is
      start_tid : constant time := clock; -- skal ikke endres 
      slutt_tid : constant time := start_tid + milliseconds (30);
   begin
      loop
         -- avbryter hvis echo blir værende høyt
         if clock >= slutt_tid then
            return time_span_zero;
         end if;

         if not echo.set then -- lav når echo = hæy og høy når echo = lav
            return clock - start_tid;
         end if;
      end loop;
   end tid_hoy;





   function overfor (tid : time_span) return natural is
      tid_mikro : constant natural := natural (to_duration (tid) * 1_000_000); -- mikro og avrunder 
   begin
      return tid_mikro / 58;
   end overfor;


   function les_foran return natural is
      tid : time_span;
      avstand : natural;
   begin
      -- echo skal være lavt før en ny måling
      if echo.set then
         return 0;
      end if;

      send_puls;

      if not sjekk_ultralyd then
         return 0;
      end if;

      
      
      
      tid := tid_hoy;
      avstand := overfor (tid);

      if avstand not in 2 .. 400 then
         return 0;
      end if;

      return avstand;
   end les_foran;



end Ultralyd;