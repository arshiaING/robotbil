with Ada.Real_Time;
with MicroBit.Types;

package lagring is


   type sensorvalg is
     (venter, bare_foran, begge_sider, alle_tre);

   type verdi is record
      avstand : MicroBit.Types.Distance_cm := 0;
      tidspunkt : Ada.Real_Time.Time :=
        Ada.Real_Time.Time_First;
   
   
   
   
   end record;

   
   
   protected lager is
      
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