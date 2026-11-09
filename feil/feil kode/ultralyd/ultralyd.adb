with MicroBit;
with nRF.GPIO; use nRF.GPIO;
with MicroBit.TimeHighspeed;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;



package body Ultralyd is



   Trig : GPIO_Point renames MicroBit.MB_P1;
   Echo : GPIO_Point renames MicroBit.MB_P2;

   Trig_venstre : GPIO_Point renames MicroBit.MB_P8;
   Echo_venstre : GPIO_Point renames MicroBit.MB_P13;

   Trig_hoyre : GPIO_Point renames MicroBit.MB_P14;
   Echo_hoyre : GPIO_Point renames MicroBit.MB_P15;



      procedure Initialize is
      oppsett : GPIO_Configuration :=
        (Mode         => Mode_Out,
         Resistors    => No_Pull,
         Input_Buffer => Input_Buffer_Connect,
         Drive        => Drive_S0S1,
         Sense        => Sense_Disabled);
   begin
      Trig.Clear;
      Trig_venstre.Clear;
      Trig_hoyre.Clear;

      Trig.Configure_IO (oppsett);
      Trig_venstre.Configure_IO (oppsett);
      Trig_hoyre.Configure_IO (oppsett);

      oppsett.Mode := Mode_In;

      Echo.Configure_IO (oppsett);
      Echo_venstre.Configure_IO (oppsett);
      Echo_hoyre.Configure_IO (oppsett);
   end Initialize;






 -- sender en startpuls
      procedure send_puls (Trig : in out GPIO_Point) is
   begin
      Trig.Clear;
      MicroBit.TimeHighspeed.Delay_Us (2);

      Trig.Set;
      MicroBit.TimeHighspeed.Delay_Us (10);
      Trig.Clear;
   end send_puls;



 -- venter på høyt echo med en frist på 10 millisekunder
   function sjekk_ultralyd (Echo : GPIO_Point) return boolean is
      tid : constant time := clock + Milliseconds (10);
   begin
      loop

      if clock >= tid then
         return false;
      end if;

      if Echo.Set then
         return true;
      end if;

      end loop;
   end sjekk_ultralyd;




   function tid_hoy (Echo : GPIO_Point) return time_span is
      start_tid : constant time := clock; -- skal ikke endres
      slutt_tid : constant time := start_tid + milliseconds (30);
   begin
      loop
         -- avbryter hvis echo blir værende høyt
         if clock >= slutt_tid then
            return time_span_zero;
         end if;

         if not Echo.Set then -- echo er lavt
            return clock - start_tid;
         end if;
      end loop;
   end tid_hoy;






   function overfor (tid : time_span) return natural is
      tid_mikro : constant natural :=
        natural (to_duration (tid) * 1_000_000); -- mikro og avrunder
   begin
      return tid_mikro / 58;
   end overfor;




 -- felles måling for alle sensorene
   procedure les_sensor
     (Trig : in out GPIO_Point;
      Echo : GPIO_Point;
      avstand : out natural)
   is
      tid : time_span;
   begin
      avstand := 0;

      -- echo skal være lavt før en ny måling
      if Echo.Set then
         put_line ("echo er høyt før start.");
         return;
      end if;

      send_puls (Trig);

      if not sjekk_ultralyd (Echo) then
         put_line ("echo ble ikke registrert innen 10 ms.");
         return;
      end if;



      tid := tid_hoy (Echo);
      avstand := overfor (tid);

      if avstand not in 2 .. 400 then
         avstand := 0;
      end if;

   end les_sensor;




   function les_foran return natural is
      avstand : natural;
   begin
      les_sensor (Trig, Echo, avstand);

      return avstand;
   end les_foran;




   function les_venstre return natural is
      avstand : natural;
   begin
      les_sensor (Trig_venstre, Echo_venstre, avstand);

      return avstand;
   end les_venstre;




   function les_hoyre return natural is
      avstand : natural;
   begin
      les_sensor (Trig_hoyre, Echo_hoyre, avstand);

      return avstand;
   end les_hoyre;



end Ultralyd;