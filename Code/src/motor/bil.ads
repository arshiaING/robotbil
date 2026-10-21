-- v1 Initialize, stopp, frem, bak


-- v2 høyre, venstre

-- v3 sidelengs hæyre og venstre



package Bil is
   -- variabler for motorstyring
   subtype kraft is Integer range 0 .. 100;


   -- v1

   procedure Initialize;
   procedure stopp;

   -- komandor for fremover og bakover + hvor mye kraft som skal brukes.
   procedure fremover (k : kraft);
   procedure bakover (k : kraft);

   -- v2


   procedure snu_hoyre (k : kraft);
   procedure snu_venstre (k : kraft);



   -- v3

   procedure sidelengs_hoyre (k : kraft);
   procedure sidelengs_venstre (k : kraft);


end Bil;