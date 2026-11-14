# hvordan jeg skal kode oppgaven

## på c burde jeg bruke læreren 


with Ada.Execution_Time; use Ada.Execution_Time; # bruker dette her som læreren sin 


   start_cpu : CPU_Time;
   start_tid : Time;
   brukt_cpu, brukt_tid : Time_Span;


## oppgave

ultralyd har 2 oppgaver den skal hente sensor valget fra lager og bruke det til å velge hvilken sensor som skal read også skal den lagere avstanden og tiden så det kan hentes av styringsystemet 



## v1

hvordan ejg skal løse det 

snesor oppgaven skal starte med å beskrive hvilken pin som brukes til trig og echo 

så bare lager vi lokale varablenen som periode og slikt 

videre henter jeg valg fra lager og bruker det med 3 if og elsif til å bestemme hvilken sensor skal lese og sendes til lagere med ny den har tid og verdi 

