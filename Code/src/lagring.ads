with Ada.Real_Time;
with MicroBit.Types;

package lagring is

      -- mulige valg think kan spøre om 
   type sensorvalg is
     (venter, bare_foran, begge_sider, alle_tre);
      -- bruker record til å samle info så vi har avstand og tid 
   type verdi is record
      avstand : MicroBit.Types.Distance_cm := 0; -- sier bare at maks verdien er fra 0 til 400 i koden til læreren er minsre to invalid 
      tidspunkt : Ada.Real_Time.Time :=
        Ada.Real_Time.Time_First; -- dette lar oss sjekke om vi har fått noen verdier 
   

   
   
   end record;

   
   
   protected lager is -- beskytet lager slik at bare 1 oppgave kan jobbe med det 
      
      procedure velg (valg : sensorvalg);
      function hent_valg return sensorvalg;
      
      procedure lagre_foran (ny : verdi);
      function hent_foran return verdi;
      
      procedure lagre_hoyre (ny : verdi);
      function hent_hoyre return verdi;
      
      procedure lagre_venstre (ny : verdi);
      function hent_venstre return verdi;




   private 
      valgt : sensorvalg := venter;
      foran   : verdi;
      hoyre   : verdi;
      venstre : verdi;
   end lager;






end lagring;