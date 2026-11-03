
 -- v1 leser bare avstand foran roboten

 -- v2 leser avstand venstre og hæyere roboten



package ultralyd is

   procedure initialize;

   -- avstand i cm. 0 betyr ugyldig måling
   -- v1
   function les_foran return natural;
   -- v2
   function les_venstre return natural;
   function les_hoyre return natural;

end ultralyd;