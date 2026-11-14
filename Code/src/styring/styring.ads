with prioitet;

package styring is

   task styringsoppgave
     with Priority => prioitet.styring;





   procedure sving_venstre; -- lar think velge venstre 
   procedure sving_hoyre; -- videre
   procedure stopp; -- videre
   procedure fremover; --videre 



  -- function ordre sendt return Boolean; -- burde ha noe som bekrefter at det har gåt igjennom 


end styring;
