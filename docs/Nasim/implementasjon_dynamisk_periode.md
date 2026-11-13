
# My Work – Dynamic Period and Deadline

In this part of the project, my task was to work with dynamic periods and deadlines for the ultrasonic sensors. I used the sensor code from my group member Arshia and added my own code to it.

The main part of my work was to change the periods depending on the distance and which sensors were active. I also used Ada.Real_Time, Clock and delay until to control the timing and check if the sensor task finished before its deadline of 130 ms.

## 1. Time Settings

```ada
Periode : Time_Span := Milliseconds(180);
Deadline : constant Time_Span := Milliseconds(130);
Pause : constant Time_Span := Milliseconds(50);

Neste : Time := Clock;
Start : Time;
Slutt : Time;
```

I used Ada.Real_Time to control the timing of the sensor task. We can see that the sensor task starts with a period of 180 ms, and I set the deadline to 130 ms. When more than one of our sensors is active, I used a 50 ms pause between the sensor readings.

## 2. Dynamic Period Based on Distance

```ada
if Valg = venter then
   Periode := Milliseconds(400);

elsif Valg = alle_tre then
   Periode := Milliseconds(400);

elsif Valg = begge_sider then
   Periode := Milliseconds(300);

elsif Valg = bare_foran then

   if not Har_Gyldig_Foran then
      Periode := Milliseconds(180);

   elsif Avstand_Foran <= 20 then
      Periode := Milliseconds(180);

   elsif Avstand_Foran <= 50 then
      Periode := Milliseconds(240);

   else
      Periode := Milliseconds(350);
   end if;

end if;
```

This part of the code is the main part of my work. I used different periods depending on which sensors were active.

For example, when only the front sensor was active, our period changed based on the measured distance. If the obstacle was close, the period became shorter so the sensor could measure the distance more often.

When the obstacle was farther away, my period became longer because the sensor did not need to measure the distance as often.

## 3. Deadline Monitoring

```ada
Slutt := Clock;

if Slutt > Start + Deadline then
   Put_Line("DEADLINE OVERSKREDET (130 ms)");
else
   Put_Line("Deadline OK (130 ms)");
end if;
```

In my code, I used Clock to check how long the sensor task takes to finish. The program measures the response time and compares it with our deadline of 130 ms.

If the task takes longer than the deadline, we get a warning message in our terminal. Otherwise, the program shows a message in the terminal that the task was completed within the deadline.

## 4. Scheduling the Next Period

```ada
Neste := Start + Periode;

if Neste <= Clock then
   Put_Line("PERIODE OVERSKREDET");
   Neste := Clock + Periode;
end if;
```

After each execution, the program calculates when the sensor task should start again. The program uses the selected period to calculate the next start time.

If that time has already passed, the program shows a warning message in the terminal and sets a new start time for the next execution.

The command `delay until Neste;` is used in the main loop to wait until the next scheduled start time.

```ada
delay until Neste;
```
