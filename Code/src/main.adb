with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit; use MicroBit;
with Ada.Execution_Time; use Ada.Execution_Time;


with MicroBit.Types; use MicroBit.Types;
with MicroBit.Ultrasonic;

-- Måleoppsett fra lærerens eksempel, tilpasset med AI hjelp. dette er bare overfæring av kode  
-- la tol 2 senor sjekk 
procedure Main with Priority => 0 is
   package sensor1 is new MicroBit.Ultrasonic (MB_P0, MB_P1);
   package sensor2 is new MicroBit.Ultrasonic (MB_P12, MB_P13);
   package sensor3 is new MicroBit.Ultrasonic (MB_P2, MB_P8);
   Time_Now_Stopwatch : Time;
   Time_Now_CPU : CPU_Time;
   Elapsed_Stopwatch : Time_Span;
   Elapsed_CPU : Time_Span;
   AmountOfMeasurement : Integer := 10;



   Distance : Distance_cm := 0;
   Distance2 : Distance_cm := 0;
   Distance3 : Distance_cm := 0;


begin
   loop
      Elapsed_Stopwatch := Time_Span_Zero;
      Elapsed_CPU := Time_Span_Zero;

      for Index in 1 .. AmountOfMeasurement loop
         Time_Now_Stopwatch := Clock;
         Time_Now_CPU := Clock;

         -- jeg for blank side jeg tror det er noe fiel med sensoren så det sitter fast 
         -- jeg fikk 2 start start så det er noe feil med sensor 2 
         -- fikk det til fant ikke feilen det bare fungerete
         put_line ("start");
         Distance := sensor3.Read;
         put_line ("start");
         Distance2 := sensor2.Read;
         put_line ("start");
         Distance3 := sensor1.Read;

         Elapsed_CPU := Elapsed_CPU + (Clock - Time_Now_CPU);
         Elapsed_Stopwatch :=
           Elapsed_Stopwatch + (Clock - Time_Now_Stopwatch);

         
         -- jeg ønsker å bare sjekke hvor mye cpu tid det tar og slikt så det er ikke så viktig med navn og slikt 
         Put_Line ("front: " & Distance_cm'Image (Distance));
         Put_Line ("right: " & Distance_cm'Image (Distance2));
         Put_Line ("left: " & Distance_cm'Image (Distance3));
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
