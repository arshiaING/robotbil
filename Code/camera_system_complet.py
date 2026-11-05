
import cv2
from ultralytics import YOLO

# Camera settings
USE_ESP32_CAM = False
ESP32_CAM_URL = "http://192.168.1.100:81/stream"

# Load YOLO
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

    # Object detection
    results = model(frame, conf=0.5, verbose=False)

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
    cv2.imshow("Robot Camera", image)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

camera.release()
cv2.destroyAllWindows()
