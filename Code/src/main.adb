with MicroBit.Console; use MicroBit.Console;
use MicroBit;
with Ada.Real_Time; use Ada.Real_Time;

-- motorstyring 
with MicroBit.I2C;
with HAL.I2C;
with nRF.GPIO; use nRF.GPIO;
with DFR0548;


-- USN PROJECT TEMPLATE INTELLIGENT REAL-TIME SYSTEMS
-- Project name: [ADAM]
-- Project members: [Arshia, Nasim, Leo.]


procedure Main with Priority => 0 is

   motorkort : DFR0548.MotorDriver
     (MicroBit.I2C.ControllerExt);

   oppsett : constant GPIO_Configuration :=
     (Mode         => Mode_In,
      Resistors    => Pull_Up,
      Input_Buffer => Input_Buffer_Connect,
      Drive        => Drive_S0D1,
      Sense        => Sense_Disabled);

begin
   -- Klargjor forbindelsen til motorkortet.
   MicroBit.MB_SCL_EXT.Configure_IO (oppsett);
   MicroBit.MB_SDA_EXT.Configure_IO (oppsett);
   delay until Clock + Milliseconds (1);

   MicroBit.I2C.InitializeExt (MicroBit.I2C.S100kbps);
   motorkort.Initialize;
   motorkort.Set_Frequency_Hz (50);
   delay until Clock + Milliseconds (1);

   -- Alle hjul fremover med koblingen din.
   motorkort.Set_PWM_Wheels
     (rf => (2044, 0),
      rb => (2044, 0),
      lf => (0, 2044),
      lb => (0, 2044));

   delay until Clock + Seconds (10);

   motorkort.Set_PWM_Wheels
     (rf => (0, 0),
      rb => (0, 0),
      lf => (0, 0),
      lb => (0, 0));

   loop
      delay until Clock + Seconds (1);
   end loop;
end Main;