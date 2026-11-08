# Camera System – YOLO Object Detection

## 1. Introduction
This part of the robot project focuses on object detection using a camera and the YOLO (You Only Look Once) model.

The purpose is to detect objects in the camera image and determine whether they are located on the left, in the center, or on the right side of the image.

## 2. System Description
Kamerasystemet er utviklet i Python og bruker OpenCV og YOLO11n.

Programmet utfører følgende operasjoner:

1. Initialiserer kameraet.
2. Leser et bilde fra kameraet.
3. Bruker YOLO til å oppdage objekter.
4. Bestemmer objektets posisjon i bildet: LEFT, CENTER eller RIGHT.
5. Viser resultatet med markeringer rundt objektene.
6. Måler eksekveringstiden for YOLO.

Programmet kjører kontinuerlig til brukeren trykker på Q.

## 3. Hardware and Software
**Programvare:**
- Python
- OpenCV
- Ultralytics YOLO11n

**Maskinvare:**
- Bærbar PC med webkamera (testet)
- ESP32-CAM (planlagt)
- Raspberry Pi 5 (planlagt)

## 4. Execution Time Evaluation
For å undersøke ytelsen til YOLO ble eksekveringstiden målt med `time.perf_counter()`.

Testen ble gjennomført på en bærbar PC med 100 kamerabilder.

**Resultater:**

| Måling | Resultat |
|---|---|
| Antall bilder | 100 |
| Gjennomsnittlig eksekveringstid | 56,71 ms |
| Minimum eksekveringstid | 50,18 ms |
| Maksimum observert eksekveringstid | 81,84 ms |

Resultatene viser hvor lang tid YOLO-kallet brukte på å behandle hvert bilde under testen.

Målingene inkluderer ikke hele tiden for bildeinnhenting, visning eller kommunikasjon med roboten.

Den maksimale observerte tiden er ikke en garantert Worst-Case Execution Time (WCET).

## 5. Connection to Intelligent Real-Time Systems
Prosjektet er relevant for emnet Intelligent Real-Time Systems fordi det undersøker eksekveringstiden til en bildebehandlingsoppgave.

Eksekveringstid er viktig når et system må behandle informasjon og reagere innenfor bestemte tidsfrister.

Resultatene kan brukes som grunnlag for videre vurdering av perioder, deadlines og responstid når kamerasystemet integreres med roboten.

## 6. Future Work
Neste steg er å:

- Teste bildeoverføring fra ESP32-CAM.
- Kjøre YOLO på Raspberry Pi 5.
- Måle eksekveringstiden på den faktiske maskinvaren.
- Undersøke hvordan deteksjonsresultatene kan overføres til robotens Sense/Think/Act-system.

## 7. Conclusion
Kamerasystemet er testet med webkamera på en bærbar PC. YOLO kan oppdage objekter og vise deres posisjon i bildet.

Evalueringen av 100 bilder ga en gjennomsnittlig eksekveringstid på 56,71 ms.

Videre testing er nødvendig for å undersøke systemets ytelse og integrasjon med den fysiske roboten.
