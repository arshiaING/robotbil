# My Part – Dynamic Period and Deadline for Ultrasonic Sensors

> **Editing note (not part of the report):** The English paragraphs below are taken from the sentences Nasim dictated in Persian and we translated together in this conversation. Technical code snippets have been retained from the original uploaded Markdown document. Any topics not covered by those dictated sentences are clearly marked rather than filled with new report prose. Please verify the snippets against the final Ada implementation: the screenshots showed an additional `Har_Gyldig_Foran` case not present in the original Markdown file.

## 1. Introduction

Scheduling is one of the important parts of our system. Because scheduling decides when different tasks should run and helps the system complete them on time.

We use scheduling in our robot project to control when the ultrasonic sensors measure distances. The robot needs to detect obstacles on time to avoid collisions.

Each task can have its own period and deadline. The deadline is the maximum time allowed to complete a task. The period is the time between two starts of the same task. If a task takes longer than its deadline, we call it a deadline miss.

## 2. Goal

Our goal was to make the sensors measure the distance more often when needed. When the robot has more space around it, the sensors do not need to measure as often, so we can avoid unnecessary measurements.

## 3. Starting Point and Planning

In this part of the project, my task was to work with deadlines and dynamic periods for the ultrasonic sensors. I used the sensor code from my group member Arshia and added my own code to it, so I could change the periods depending on the distance and which sensors were active.

> **Not yet described in my own words:** The original document's planning estimates (76 ms / 102 ms / 128 ms), teacher example, and initial 100 ms / 180 ms alternatives. These have not been presented as Nasim's own English statements.

## 4. Implementation in Ada

### 4.1 Time Settings

```ada
periode : Time_Span := Milliseconds (180);
deadline : constant Time_Span := Milliseconds (130);
pause : constant Time_Span := Milliseconds (50);
```

I used Ada.Real_Time to control the timing of the sensor task. We can see that the sensor task starts with a period of 180 ms, and I set the deadline to 130 ms. When more than one of our sensors is active, I used a 50 ms pause between the sensor readings.

### 4.2 Sensor Selection

```ada
valg := lager.hent_valg;
```

```ada
ny.tidspunkt := Clock;
ny.avstand := sensor_foran.Read;
lager.lagre_foran (ny);
avstand_foran := Integer (ny.avstand);
```

> **Not yet described in my own words:** How `lager.hent_valg` selects the modes and how the measured distance is saved. Code retained unchanged from the uploaded original.

### 4.3 Dynamic Period Based on Distance

```ada
if valg = venter then
   periode := Milliseconds (400);
elsif valg = alle_tre then
   periode := Milliseconds (400);
elsif valg = begge_sider then
   periode := Milliseconds (300);
elsif valg = bare_foran then
   if avstand_foran <= 20 then
      periode := Milliseconds (180);
   elsif avstand_foran <= 50 then
      periode := Milliseconds (240);
   else
      periode := Milliseconds (350);
   end if;
end if;
```

This part of the code is the main part of my work. I used different periods depending on which sensors were active.

For example, when only the front sensor was active, our period changed based on the measured distance. If the obstacle was close, the period became shorter so the sensor could measure the distance more often.

When the obstacle was farther away, my period became longer because the sensor did not need to measure the distance as often.

For example, if the distance is 20 cm or less, the period is 180 ms. If the distance is more than 50 cm, our period is 350 ms. And if the distance is between 20 and 50 cm, our period is 240 ms.

When both of our side sensors are active, our period is 300 ms. And when all three of our sensors are active, our period is 400 ms.

> **Code discrepancy to check:** In the later screenshots, the `bare_foran` branch also checks `not Har_Gyldig_Foran` and uses `Avstand_Foran`. The snippet above deliberately preserves the uploaded Markdown source rather than silently replacing it with a reconstructed code version.

### 4.4 Deadline Monitoring

```ada
start := Clock;
slutt := Clock;
if slutt > start + deadline then
   Put_Line ("Deadline overskredet.");
end if;
```

In my code, I used Clock to check how long the sensor task takes to finish. The program measures the response time and compares it with our deadline of 130 ms.

If the task takes longer than the deadline, we get a warning message in our terminal. Otherwise, the program shows a message in the terminal that the task was completed within the deadline.

> **Code discrepancy to check:** The original snippet above prints a warning only. The separate `else` / `Deadline OK` behavior was shown in your later screenshots, but is not in this uploaded original snippet.

### 4.5 Scheduling the Next Period

```ada
neste := start + periode;
if neste <= Clock then
   Put_Line ("Periode overskredet.");
   neste := Clock + periode;
end if;
```

After each execution, the program calculates when the sensor task should start again. The program uses the selected period to calculate the next start time.

If that time has already passed, the program shows a warning message in the terminal and sets a new start time for the next execution.

```ada
delay until neste;
```

The command `delay until Neste;` is used in the main loop to wait until the next scheduled start time.

## 5. Why I Chose This Solution

We also use different periods depending on which sensors are active. Because this helps us avoid unnecessary measurements when our robot does not need information from all three sensors.

When the obstacle is close, our front sensor measures the distance more often. When the obstacle is far away, we have a longer period. This means that our sensor measures the distance less often.

## 6. Working Together

In our project, we worked together to combine the sensor code with the scheduling code. For example, Arshia worked on the sensor measurement code, and Nasim worked on controlling the periods and checking the deadlines.

When we used more than one sensor, we added a 50 ms pause between the sensor readings. This helped us separate the measurements from different sensors more easily.

> **Not yet described in my own words:** The original document's motor-control integration and behavior when an obstacle is 20 cm away. Left out rather than writing an invented first-person explanation.

## 7. Results and Testing

We tested our combined code for dynamic scheduling and ultrasonic sensors. We tested the front sensor, both side sensors, and all three sensors together.

The results of our tests are shown in the table below.

| Sensor configuration | Measured distance | Period | Response time |
| --- | --- | --- | --- |
| Front sensor | 41 cm | 240 ms | 4.90 ms |
| Right and left sensors | 38 cm / 35 cm | 300 ms | 59.37 ms |
| All three sensors | 29 cm / 6 cm / 35 cm | 400 ms | 111.41 ms |

In our tests, we observed that the response time increased when more sensors were active. For example, the front sensor had the shortest response time of 4.90 ms, while the highest response time was 111.41 ms when all three sensors were active.

Also, the highest response time was still below our deadline of 130 ms. In our tests shown above, we can see that we did not have any deadline misses.

We also measured the time between two consecutive starts of the sensor task. We observed that the measured time intervals were approximately 240 ms, 300 ms, and 400 ms. These values were close to the periods we selected in our original code.

Finally, our tests showed that the three recorded sensor configurations followed our expected timing.

## 8. Discussion and Limitations

> **Not yet dictated in my own English wording:** The detailed Chapter 5 discussion, including the reported 300 ms maximum valid interval and the 400 ms conflict, was originally drafted by the assistant after Arshia's Norwegian message. It is deliberately not presented here as something Nasim dictated. The verified reported issue should be included in the final group discussion once its requirement is confirmed.

## 9. Summary

Scheduling helps us use our sensors more efficiently and at the same time control the timing requirements of our system.

> **Not yet described in my own words:** A fuller project summary. The sentence above is the closing sentence Nasim originally dictated for Scheduling.
