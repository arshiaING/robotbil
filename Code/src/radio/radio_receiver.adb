with MicroBit;
with MicroBit.Radio;
with MicroBit.Console; use MicroBit.console;
with Ada.Real_Time; use Ada.Real_Time;
with HAL; use HAL;

package body radio_receiver is

   procedure receiver is

      buffer : MicroBit.Radio.RadioData;
      start : Time;
      elapsed  : Time_Span;
      period : constant Natural := 1000; -- ms

      function Get_Int16 (Index : UInt8) return Integer is
         bitOffset : Integer := Integer (buffer.Payload (Index)) * 256
                        + Integer (buffer.Payload (Index + 1));
      begin
         if bitOffset >= 32768 then
            bitOffset := bitOffset - 65536;
         end if;
         return bitOffset;
      end Get_Int16;

   begin
      start := Clock;
      MicroBit.Radio.Setup (RadioFrequency => 2467,
                           Length         => 32,
                           Version        => 12,
                           Group          => 1,
                           Protocol       => 14);

      MicroBit.Radio.StartReceiving;
      Put_Line("Receiver status:");
      Put_Line(MicroBit.Radio.State'Image);
      Put_Line("");
      elapsed := Clock - start;
      Put_Line(elapsed'Image);
      loop
         start := Clock;
         Put_Line(MicroBit.Radio.DataReady'Image);
         if MicroBit.Radio.DataReady then
            buffer := MicroBit.Radio.Receive;
            Put_Line
            ("X=" & Integer'Image (Get_Int16 (1)) &
               " Y=" & Integer'Image (Get_Int16 (3)) &
               " Z=" & Integer'Image (Get_Int16 (5)));
            elapsed:= Clock - start;
            Put_Line(To_Duration(elapsed)'Image);
            delay until(start + milliseconds(1000));
         end if;
         delay until(start + milliseconds(period));
      end loop;
   end receiver;

end radio_receiver;