  -- jeg for ikke tid til å skrive helt ferdig regel versjon med alle reglenen mine jeg tenker det jeg skriver er den leser front sensoren på en loop også om den ser noe så stopper den sjekker sidenen
 -- om den ser noe foran på 20 cm så stopper den sjekker venstre og høyrer og svinger den veien den veien det er plass det skal vøre en minst 12 vm på hver side for at den skal svinge
 -- om de er like har den en favoritt side og om det ikke er plassw stopper den og venter til det er plass igjen




with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Console; use MicroBit.Console;



package body styring is



   fart : constant := 1200; -- fart
   periode : constant Time_Span := Milliseconds (20);



   protected styringslager is

      procedure velg (ny : Directions); -- lagrer ny retning
      function hent return Directions; -- henter retnigner


   private
      valgt : Directions := Stop; 
   end styringslager;

   protected body styringslager is

      procedure velg (ny : Directions) is
      begin
         valgt := ny;
      end velg;

      function hent return Directions is
      begin
         return valgt;
      end hent;

   end styringslager;

   task body styringsoppgave is
      neste : Time := Clock;
      slutt : Time;
      ordre : Directions;


      -- test
      Time_Now_CPU : CPU_Time;
      Elapsed_CPU : Time_Span;
   begin
      loop
         delay until neste; -- venter på riktig tid

         Time_Now_CPU := Ada.Execution_Time.Clock; -- testing

         ordre := styringslager.hent; -- lager en kopi
         Drive (ordre, (others => fart)); -- order blir hvor og others ewr bare hvor motor kraft
         --test
         Elapsed_CPU := Ada.Execution_Time.Clock - Time_Now_CPU;
         slutt := Ada.Real_Time.Clock;
         --test
         Put_Line
           ("CPU time: " & Duration'Image (To_Duration (Elapsed_CPU))
            & " seconds");
         Put_Line
           ("Response time: " & Duration'Image (To_Duration (slutt - neste))
            & " seconds");

         neste := neste + periode;
      end loop;
   end styringsoppgave;
      -- til å huske 
   procedure sving_venstre is
   begin
      styringslager.velg (Rotating_Left);
   end sving_venstre;

   procedure sving_hoyre is
   begin
      styringslager.velg (Rotating_Right);
   end sving_hoyre;

   procedure stopp is
   begin
      styringslager.velg (Stop);
   end stopp;

   procedure fremover is
   begin
      styringslager.velg (Forward);
   end fremover;



end styring;