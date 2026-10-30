# ==============================================================================
# Proyecto YOLO: Reconocimiento de Imágenes
# Pipeline de descarga de dataset desde Roboflow y entrenamiento con YOLOv11
# ==============================================================================

import os

# 1. Instalar dependencias si no están instaladas:
# pip install roboflow ultralytics opencv-python

from roboflow import Roboflow
from ultralytics import YOLO

def descargar_dataset():
    """Descarga el dataset anotado desde Roboflow."""
    rf = Roboflow(api_key="tHcv4L8Byw4D9MNe5C9X")
    project = rf.workspace("juan-mpxve").project("triada-stanhome")
    version = project.version(5)
    dataset = version.download("yolov11")
    return dataset

def entrenar_modelo(dataset_path):
    """Entrena el modelo YOLOv11 con el dataset descargado."""
    model = YOLO("yolo11s.pt")
    data_yaml = os.path.join(dataset_path, "data.yaml") if os.path.isdir(dataset_path) else dataset_path
    
    results = model.train(
        data=data_yaml,
        epochs=25,
        imgsz=640
    )
    return results

if __name__ == "__main__":
    print("Descargando dataset...")
    dataset = descargar_dataset()
    print("Iniciando entrenamiento...")
    entrenar_modelo(dataset.location)
