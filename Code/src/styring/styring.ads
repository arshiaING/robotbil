



package styring is

   -- valgene styringen kan gi
   type handling is (stopp, fremover, snu_hoyre, snu_venstre);

   -- bruker avstandene i cm til å velge en handling
   function velg_handling
     (foran, venstre, hoyre : natural) return handling;

end styring;