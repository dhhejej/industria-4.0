from ultralytics import YOLO

# Carga tu modelo
model = YOLO('best.pt')

# Abre la cámara aplicando un filtro de confianza más alto (0.75 o 80%)
results = model(source=0, show=True, conf=0.75, iou=0.5)
