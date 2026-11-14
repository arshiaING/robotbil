package body lagring is

   protected body lager is
      -- brukes til at styring systemet skal etter hvert legge til hvilken som skal brukes
      procedure velg (valg : sensorvalg) is
      begin
         valgt := valg;
      end velg;




      -- brukes så sensoren kan hente hvilken sensor som skal brukes
      function hent_valg return sensorvalg is
      begin
         return valgt;
      end hent_valg;



      -- lagrer verdiene fra sensorer
      procedure lagre_foran (ny : verdi) is
      begin
         foran := ny;
      end lagre_foran;



      -- lar styringssystemet hente de lagrede verdiene fra sensorer dette kommer når jeg starter på det 
      function hent_foran return verdi is
      begin
         return foran;
      end hent_foran;


      -- likt
      procedure lagre_hoyre (ny : verdi) is
      begin
         hoyre := ny;
      end lagre_hoyre;


      -- samme 
      function hent_hoyre return verdi is
      begin
         return hoyre;
      end hent_hoyre;



      -- samme
      procedure lagre_venstre (ny : verdi) is
      begin
         venstre := ny;
      end lagre_venstre;


      -- samme og kommer 
      function hent_venstre return verdi is
      begin
         return venstre;
      end hent_venstre;

   end lager;

end lagring;