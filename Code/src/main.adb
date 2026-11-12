with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit; use MicroBit;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Ultrasonic;

-- Måleoppsett fra lærerens eksempel, tilpasset med AI hjelp.
procedure Main with Priority => 0 is
   package sensor1 is new MicroBit.Ultrasonic (MB_P0, MB_P1);

   Time_Now_Stopwatch : Time;
   Time_Now_CPU : CPU_Time;
   Elapsed_Stopwatch : Time_Span;
   Elapsed_CPU : Time_Span;
   AmountOfMeasurement : Integer := 10;

   Distance : Distance_cm := 0;
begin
   loop
      Elapsed_Stopwatch := Time_Span_Zero;
      Elapsed_CPU := Time_Span_Zero;

      for Index in 1 .. AmountOfMeasurement loop
         Time_Now_Stopwatch := Clock;
         Time_Now_CPU := Clock;

         Distance := sensor1.Read;

         Elapsed_CPU := Elapsed_CPU + (Clock - Time_Now_CPU);
         Elapsed_Stopwatch :=
           Elapsed_Stopwatch + (Clock - Time_Now_Stopwatch);

         Put_Line ("Front: " & Distance_cm'Image (Distance));
         delay 0.05;
      end loop;

      Elapsed_CPU := Elapsed_CPU / AmountOfMeasurement;
      Elapsed_Stopwatch := Elapsed_Stopwatch / AmountOfMeasurement;

      Put_Line
        ("Average CPU time: " & To_Duration (Elapsed_CPU)'Image
         & " seconds");
      Put_Line
        ("Average Stopwatch time: " & To_Duration (Elapsed_Stopwatch)'Image
         & " seconds");
   end loop;
end Main;
