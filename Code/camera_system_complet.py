
import cv2
import time
from ultralytics import YOLO

# Camera settings
USE_ESP32_CAM = False
ESP32_CAM_URL = "http://192.168.1.100:81/stream"

# Evaluation settings
EVALUATION_FRAMES = 100
execution_times = []

# Load YOLO model
model = YOLO("yolo11n.pt")

# Choose camera
if USE_ESP32_CAM:
    camera = cv2.VideoCapture(ESP32_CAM_URL)
else:
    camera = cv2.VideoCapture(0, cv2.CAP_DSHOW)

if not camera.isOpened():
    print("Camera not connected")
    raise SystemExit

print("Camera started. Press Q to quit.")

while True:
    success, frame = camera.read()

    if not success:
        print("Cannot read image")
        break

    # Measure YOLO execution time
    start_time = time.perf_counter()

    # Object detection
    results = model(frame, conf=0.5, verbose=False)

    end_time = time.perf_counter()
    execution_time = (end_time - start_time) * 1000

    print(f"YOLO Execution Time: {execution_time:.2f} ms")

    # Store execution time
    execution_times.append(execution_time)

    # Evaluate every 100 frames
    if len(execution_times) == EVALUATION_FRAMES:
        average_time = sum(execution_times) / len(execution_times)
        minimum_time = min(execution_times)
        maximum_time = max(execution_times)

        print("\n--- YOLO Execution Time Evaluation ---")
        print(f"Frames: {EVALUATION_FRAMES}")
        print(f"Average: {average_time:.2f} ms")
        print(f"Minimum: {minimum_time:.2f} ms")
        print(f"Maximum: {maximum_time:.2f} ms")
        print("--------------------------------------\n")

        execution_times.clear()

    # Object position
    width = frame.shape[1]

    for box in results[0].boxes:
        name = model.names[int(box.cls[0])]
        x1, y1, x2, y2 = map(int, box.xyxy[0])

        center_x = (x1 + x2) / 2

        if center_x < width / 3:
            position = "LEFT"
        elif center_x > 2 * width / 3:
            position = "RIGHT"
        else:
            position = "CENTER"

        print(name, position)

    # Show result
    image = results[0].plot()

    # Show execution time on image
    cv2.putText(
        image,
        f"YOLO Time: {execution_time:.2f} ms",
        (20, 40),
        cv2.FONT_HERSHEY_SIMPLEX,
        0.8,
        (0, 255, 0),
        2
    )

    cv2.imshow("Robot Camera", image)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

camera.release()
cv2.destroyAllWindows()
