import cv2
from ultralytics import YOLO

# Carga tu modelo entrenado local
model = YOLO("best.pt")

# Abre la cámara web predeterminada
cap = cv2.VideoCapture(0)

print("Iniciando detección en tiempo real. Presiona la tecla 'ESC' en la ventana de video para salir.")

while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        print("No se pudo acceder a la cámara.")
        break

    # Realizar inferencia
    results = model(frame, conf=0.30)
    annotated_frame = results[0].plot()

    # Mostrar la ventana flotante nativa idéntica a la del tutorial
    cv2.imshow("Deteccion YOLO en Vivo", annotated_frame)

    # Salir al presionar la tecla ESC (código 27)
    if cv2.waitKey(1) & 0xFF == 27:
        break

cap.release()
cv2.destroyAllWindows()
