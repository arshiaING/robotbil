# hva som trengs 


## kjøring 

- jeg må kunne kjøre 

funksjonene fra læreren er 

MotorDriver.Driver(retning, fart) fra 

Code/libs/Ada_Drivers_Library/boards/MicroBit_v2/src/full/microbit-motordriver.ads

vet ikke hav servo gjør procedure Servo (ServoPin : ServoPins ;
                    Angle : Degrees);

på retning har han skrevet 

type Directions is (Forward,
                       Backward,
                       Left,
                       Right,
                       Forward_Left,
                       Backward_Left,
                       Turning,
                       Lateral_Left,
                       Rotating_Left,
                       Rotating_Right,
                       Stop);

fart det går fra 0 til 4095 må sjekke fart basert på vekt og batteri eller kanksje det er en funksjon som gjør dette 



--Note: See implementation of wheel to be (Forward, Backward)
      --!! They can never be a non zero value at the same time !! eg. rf => (4000,2000) is illegal
      --rf = right front wheel, rb = right back wheel, etc.
      --for example direction see:


## ultralyd sensor

- må lese ultralyde sensorenen 

det jeg kan fra før sensoren går fra høyt til lavt tiden mellom de er tiden den tar for at signalen skal sende ut og tilbake 
for å starte sensorenen må du sende en sterkt hæy signal 
verdier på 0 er error automatisk 


funksjonene fra læreren er 

Distance := sensor1.Read;

Distance er variablen 
sensor1 er bare Ultrasonic(MB_P16, MB_P0); der MB_P16 er Trig og MB_p0 er Echo
Read gir tall verdi i cm 

eksemplet til læreren har 


procedure Main is
   package sensor1 is new Ultrasonic(MB_P16, MB_P0);
   package sensor2 is new Ultrasonic(MB_P15, MB_P0);
   package sensor3 is new Ultrasonic(MB_P14, MB_P0);

   Distance : Distance_cm := 0;
begin
   loop
      Put_Line ("");
      Distance := sensor1.Read;
      Put_Line ("Front: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      Distance := sensor2.Read;
      Put_Line ("Left: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      Distance := sensor3.Read;
      Put_Line ("Right: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly


### tanker om løsning 

de har samme echo dette betyr at vi må sende signalenne ut 1 om gangen vente på svar også neste sensor 
hvis hver måling er 26 vil det ta 78 ms + tidne det tar koden
om alle er samtidg er det ish 26 + tiden den tar koden 

i hvordan jeg har valgt til å løse dette er høyere og venstre ikke på for vi stopper men når den er stoppet og skal sjekke siden vil dette gjøre tiden 52 ms til 26 ms 

om jeg skal bruke løsningen om 3 sensorer samtidg må jeg sjekke om læreren sin biblotek fungere med dette kommer tilbake til seinere om jeg har tid 


### i straten må vi ha kanpe trykk knap a 

- må trykke på knap a for at det skal startes 

funksjonene fra læreren 

MivroBit.Buttons.State (knap)

State git meg 2 muligheter Preddes fordi læreren bruker det i eksmplet sitt 

 if MicroBit.Buttons.State (Button_A) = Pressed then
         MicroBit.DisplayRT.Display ('A');
         Put_Line ("Pressed A");

i ads funksjonene i boards har jeg 


type Button_State is (Pressed, Released);

den har også Subscribe og Unsubscribe vet ikke hva de gjør 

på type Button_Id is (Button_A, Button_B, Logo); Logo?



## lage lyd 

- jeg trenger dette når bilen blir fanget 


Code/libs/Ada_Drivers_Library/examples/MicroBit_v2/ravenscar/music/src/main.adb

lager lyd jeg fant også en som er Radio men har ikke sjekket hva den gjør 


My_Little_Melody : constant MicroBit.Music.Melody :=
   ((C4,   400),
   (G3,   800),
   (B3,   400),
   (Rest, 400),
   (A3,   400),
   (G3,   400));

My_Little_Melody er navnet 
constant skal ikke endres 
MicroBit.Music.Melody 
C4 tror jeg er note 
og 400 er enten hvor hæyt det er eller varighet 


også bruker den MicroBit.Music.Play (27, Music_KnightRider);

til å spille av 


Code/libs/Ada_Drivers_Library/boards/MicroBit_v2/src/full/microbit-music.ads 

fant jeg 

 procedure Play (Pin : Pin_Id; P : Pitch);

   procedure Play (Pin : Pin_Id; N : Note);

   procedure Play (Pin : Pin_Id; M : Melody);

   function Midi_To_Freq_Hz(key : UInt8) return Pitch;

   Volume : Analog_Value := 20;
   IsPlaying : Boolean := False;
   StopSignal : Boolean := False;
   procedure VolumeUp;

   procedure VolumeDown;

   Procedure StopMusic;



procedure Play (Pin : Pin_Id; N : Note) is
   begin
      Play (Pin, N.P);
      delay until Clock + Milliseconds(N.Ms);
      IsPlaying := False;
   end Play;

   pin id er pin den bruker? 

   N er en note 

   type Note is record
      P  : Pitch;
      Ms : Integer;

     note har tone den skal spille og tiden 


        melodu læreren bruker i9 eksmplet 

      procedure Play (Pin : Pin_Id; M : Melody) is
   begin

      StopSignal := False;

      for N of M loop
         Play (Pin, N);
         exit when StopSignal;
      end loop;

      Set (Pin, False); --stop
   end Play;

   type Melody is array (Natural range <>) of Note;

   så melody er en liste av noter som har 

     P  : Pitch; og Ms : Integer;
    så eksemplet lager en liste av eks a4 og tiden hver skal spille 

    for N of M loop er en for loop men vet ikke hva N OG M gjør kanskje M er listen og N er hva som er inni 


## måle tid den kjører frem med 

jeg brukte Ada.Real_Time.Clock fra ADA kode 

jeg trenger det for 

- hvor lenge bilen har kjørt sammenhengende frem
- hvor lenge den har rygget
- og hvor lenge den har forsøkt å rotere


kommer til 