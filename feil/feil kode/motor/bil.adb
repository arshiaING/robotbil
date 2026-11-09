with MicroBit.I2C;
with nRF.GPIO; use nRF.GPIO;
with DFR0548;
with Ada.Real_Time; use Ada.Real_Time;

with HAL;



package body Bil is

  -- v1
   motorkort : DFR0548.MotorDriver
     (MicroBit.I2C.ControllerExt);

   oppsett : constant GPIO_Configuration :=
     (Mode         => Mode_In,
      Resistors    => Pull_Up,
      Input_Buffer => Input_Buffer_Connect,
      Drive        => Drive_S0D1,
      Sense        => Sense_Disabled);

   procedure stopp is
   begin
      motorkort.Set_PWM_Wheels
        (rf => (0, 0),
         rb => (0, 0),
         lf => (0, 0),
         lb => (0, 0));
   end stopp;


      procedure Initialize is
   begin
      MicroBit.MB_SCL_EXT.Configure_IO (oppsett);
      MicroBit.MB_SDA_EXT.Configure_IO (oppsett);
      delay until Clock + Milliseconds (1);

      MicroBit.I2C.InitializeExt (MicroBit.I2C.S100kbps);

      motorkort.Initialize;
      motorkort.Set_Frequency_Hz (50);
      delay until Clock + Milliseconds (1);

      stopp;
   end Initialize;






      procedure fremover (k : kraft) is
      pwm : constant HAL.UInt12 :=
        HAL.UInt12 ((k * 4095) / 100);
   begin
      motorkort.Set_PWM_Wheels
        (rf => (pwm, 0),
         rb => (pwm, 0),
         lf => (0, pwm),
         lb => (0, pwm));
   end fremover;








      procedure bakover (k : kraft) is
      pwm : constant HAL.UInt12 :=
        HAL.UInt12 ((k * 4095) / 100);
   begin
      motorkort.Set_PWM_Wheels
        (rf => (0, pwm),
         rb => (0, pwm),
         lf => (pwm, 0),
         lb => (pwm, 0));
   end bakover;




   -- v2

      procedure snu_hoyre (k : kraft) is
      pwm : constant HAL.UInt12 :=
        HAL.UInt12 ((k * 4095) / 100);
   begin
      motorkort.Set_PWM_Wheels
        (rf => (pwm, 0),
         rb => (pwm, 0),
         lf => (pwm, 0),
         lb => (pwm, 0));
   end snu_hoyre;



      procedure snu_venstre (k : kraft) is
      pwm : constant HAL.UInt12 :=
        HAL.UInt12 ((k * 4095) / 100);
   begin
      motorkort.Set_PWM_Wheels
        (rf => (0, pwm),
         rb => (0, pwm),
         lf => (0, pwm),
         lb => (0, pwm));
   end snu_venstre;


   --- v3

      procedure sidelengs_hoyre (k : kraft) is
      pwm : constant HAL.UInt12 :=
        HAL.UInt12 ((k * 4095) / 100);
   begin
      motorkort.Set_PWM_Wheels
       
        (rf => (0, pwm),
         rb => (pwm, 0),
         lf => (0, pwm),
         lb => (pwm, 0));
   end sidelengs_hoyre; 

   

      procedure sidelengs_venstre (k : kraft) is
      pwm : constant HAL.UInt12 :=
        HAL.UInt12 ((k * 4095) / 100);
   begin
      motorkort.Set_PWM_Wheels
        (rf => (pwm, 0),
         rb => (0, pwm),
         lf => (pwm, 0),
         lb => (0, pwm));
   end sidelengs_venstre;

   

      
end Bil;