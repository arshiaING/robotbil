




package body styring is

   -- vi starter med 30 cm og tilpasser grensen senere
   stoppgrense : constant natural := 30;



   function velg_handling
     (foran, venstre, hoyre : natural) return handling
   is



   begin
      -- 0 betyr at vi mangler en gyldig måling
      if foran = 0 or venstre = 0 or hoyre = 0 then
         return stopp;



      -- velger stopp når noe er for nært foran
      elsif foran <= stoppgrense then
         return stopp;




      -- velger fremover når foran er over grensen
      else
         return fremover;
      end if;
   end velg_handling;

end styring;