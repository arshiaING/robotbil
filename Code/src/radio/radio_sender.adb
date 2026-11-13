with MicroBit;
with MicroBit.Radio;
with MicroBit.Accelerometer;
with MicroBit.Console; use MicroBit.console;
with Ada.Real_Time; use Ada.Real_Time;
with HAL; use HAL;
with LSM303AGR;

package body radio_sender is

   procedure sender is

      Frame : MicroBit.Radio.RadioData;
      start : Time;
      data  : LSM303AGR.All_Axes_Data;
      elapsed  : Time_Span;
      period : constant Natural := 1000; -- ms

      procedure Put_Int16 (Index : UInt8; Value : Integer) is
         bitOffset : constant UInt16 := UInt16 (Value mod 65536);  -- two's complement
      begin
         Frame.Payload (Index)     := UInt8 (bitOffset / 256);
         Frame.Payload (Index + 1) := UInt8 (bitOffset mod 256);
      end Put_Int16;

   begin
      MicroBit.Radio.Setup (RadioFrequency => 2467,
                           Length         => 32,
                           Version        => 12,
                           Group          => 1,
                           Protocol       => 14);

      Frame.Length   := 32;
      Frame.Version  := 12;
      Frame.Group    := 1;
      Frame.Protocol := 14;

      loop
         start := Clock;
         data := MicroBit.Accelerometer.AccelData;

         Put_Int16 (1, Integer (data.X));
         Put_Int16 (3, Integer (data.Y));
         Put_Int16 (5, Integer (data.Z));

         MicroBit.Radio.Transmit(Frame);
         Put_Line("Sent");
         elapsed := Clock - start;
         Put_Line(To_Duration(elapsed)'Image);
         delay until(start + milliseconds(period));
      end loop;
   end sender;

end radio_sender;