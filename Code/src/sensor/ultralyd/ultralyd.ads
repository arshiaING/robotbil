
 -- v1 leser bare avstand foran roboten

 -- v2 leser avstand venstre og hæyere roboten



package Ultralyd is
 -- v1 
   procedure Initialize;

   -- Avstand i cm. 0 betyr ugyldig mling.
   function les_foran return Natural;











end Ultralyd;