
import cv2
from ultralytics import YOLO

# Load the object detection model
print("Loading YOLO model...")
model = YOLO("yolo11n.pt")

# Start the computer camera for testing
camera = cv2.VideoCapture(0)

if not camera.isOpened():
    print("Error: Could not open camera.")
    raise SystemExit

print("Camera started!")
print("Press Q to quit.")

while True:
    success, frame = camera.read()

    if not success:
        print("Error: Could not read image.")
        break

    # Detect objects in the image
    results = model.predict(frame, conf=0.45, verbose=False)

    obstacle_detected = False

    for result in results:
        for box in result.boxes:
            class_id = int(box.cls[0])
            object_name = model.names[class_id]
            confidence = float(box.conf[0])

            # Find the horizontal position of the object
            x1, y1, x2, y2 = map(int, box.xyxy[0])
            center_x = (x1 + x2) / 2
            image_width = frame.shape[1]

            if center_x < image_width / 3:
                position = "LEFT"
            elif center_x > 2 * image_width / 3:
                position = "RIGHT"
            else:
                position = "CENTER"

            obstacle_detected = True

            print(
                f"Object: {object_name}, "
                f"Confidence: {confidence:.2f}, "
                f"Position: {position}"
            )

    if obstacle_detected:
        print("Obstacle detected!")
    else:
        print("No recognized objects.")

    # Show the image with detection boxes
    annotated_frame = results[0].plot()
    cv2.imshow("Camera System", annotated_frame)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

camera.release()
cv2.destroyAllWindows()

