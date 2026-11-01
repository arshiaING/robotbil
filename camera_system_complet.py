
import time
from datetime import datetime
from pathlib import Path

import cv2
from ultralytics import YOLO


# ==========================================
# CONFIGURATION
# ==========================================

# False = laptop camera
# True = ESP32-CAM stream
USE_ESP32_CAM = False

# Replace with the actual ESP32-CAM stream URL
# when the camera is connected to Wi-Fi.
ESP32_CAM_URL = "http://192.168.1.100:81/stream"

MODEL_NAME = "yolo11n.pt"
CONFIDENCE_THRESHOLD = 0.45

PRINT_INTERVAL_SECONDS = 2.0
MAX_RECONNECT_ATTEMPTS = 5
RECONNECT_DELAY_SECONDS = 2

BASE_DIR = Path(__file__).resolve().parent
MODEL_PATH = BASE_DIR / MODEL_NAME
SAVE_DIR = BASE_DIR / "camera_tests"


# ==========================================
# OPEN CAMERA
# ==========================================

def open_camera():
    if USE_ESP32_CAM:
        print("Connecting to ESP32-CAM...")
        camera = cv2.VideoCapture(ESP32_CAM_URL)
    else:
        print("Opening laptop camera...")
        camera = cv2.VideoCapture(0, cv2.CAP_DSHOW)

        if not camera.isOpened():
            camera.release()
            camera = cv2.VideoCapture(0)

    if not camera.isOpened():
        camera.release()
        return None

    return camera


# ==========================================
# ANALYZE FRAME WITH YOLO
# ==========================================

def analyze_frame(model, frame):
    height, width = frame.shape[:2]

    results = model.predict(
        frame,
        conf=CONFIDENCE_THRESHOLD,
        verbose=False
    )

    detections = []

    for box in results[0].boxes:
        class_id = int(box.cls[0])
        name = model.names[class_id]
        confidence = float(box.conf[0])

        x1, y1, x2, y2 = map(
            int,
            box.xyxy[0].tolist()
        )

        center_x = (x1 + x2) / 2

        if center_x < width / 3:
            position = "LEFT"
        elif center_x > 2 * width / 3:
            position = "RIGHT"
        else:
            position = "CENTER"

        detections.append({
            "object": name,
            "confidence": confidence,
            "position": position,
            "box": (x1, y1, x2, y2)
        })

    annotated = results[0].plot()

    return detections, annotated


# ==========================================
# PRINT DETECTIONS
# ==========================================

def print_detections(detections):
    if not detections:
        print("No recognized objects.")
        return

    for item in detections:
        print(
            f"Object: {item['object']}, "
            f"Confidence: {item['confidence']:.2f}, "
            f"Position: {item['position']}"
        )

    print("Object detected (distance not known).")


# ==========================================
# SAVE IMAGE
# ==========================================

def save_image(frame):
    SAVE_DIR.mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now().strftime(
        "%Y%m%d_%H%M%S_%f"
    )

    filename = SAVE_DIR / f"camera_test_{timestamp}.jpg"

    if cv2.imwrite(str(filename), frame):
        print(f"Saved image: {filename}")
    else:
        print("Error: Could not save image.")


# ==========================================
# MAIN PROGRAM
# ==========================================

def main():
    camera = None

    print("Loading YOLO model...")

    try:
        if MODEL_PATH.exists():
            model = YOLO(str(MODEL_PATH))
        else:
            print("Model not found locally.")
            print("Trying to download YOLO model...")
            model = YOLO(MODEL_NAME)

    except Exception as error:
        print(f"Could not load YOLO model: {error}")
        return

    print("YOLO model loaded successfully.")

    camera = open_camera()

    if camera is None:
        print("Error: Could not open camera.")
        return

    print("Camera started!")
    print("Press Q to quit.")
    print("Press S to save an image.")

    last_print = 0.0
    reconnect_attempts = 0

    try:
        while True:
            success, frame = camera.read()

            if not success:
                print("Could not read camera frame.")

                camera.release()
                camera = None

                reconnect_attempts += 1

                if reconnect_attempts > MAX_RECONNECT_ATTEMPTS:
                    print("Maximum reconnect attempts reached.")
                    break

                print(
                    f"Reconnecting: "
                    f"{reconnect_attempts}/"
                    f"{MAX_RECONNECT_ATTEMPTS}"
                )

                time.sleep(RECONNECT_DELAY_SECONDS)
                camera = open_camera()

                if camera is None:
                    continue

                last_print = 0.0
                continue

            reconnect_attempts = 0

            detections, annotated = analyze_frame(
                model,
                frame
            )

            current_time = time.monotonic()

            if current_time - last_print >= PRINT_INTERVAL_SECONDS:
                print_detections(detections)
                last_print = current_time

            cv2.imshow(
                "Camera System - YOLO",
                annotated
            )

            key = cv2.waitKey(1) & 0xFF

            if key == ord("q"):
                print("Stopping camera...")
                break

            if key == ord("s"):
                save_image(annotated)

    except KeyboardInterrupt:
        print("Stopped by user.")

    except Exception as error:
        print(f"Camera processing error: {error}")

    finally:
        if camera is not None:
            camera.release()

        cv2.destroyAllWindows()
        print("Camera system closed.")


if __name__ == "__main__":
    main()
