# Industria 4.0 - Prácticas de Código

Repositorio que contiene los proyectos y configuraciones desarrolladas para la materia de **Industria 4.0**:

| No. | Proyecto / Práctica | Tecnología | Descripción |
|---|---|---|---|
| **1** | Proyecto YOLO Reconocimiento de Imágenes | Python / Ultralytics / OpenCV / Roboflow | Detección de objetos e inferencia en tiempo real mediante cámara web con pesos entrenados (`best.pt`). |
| **2** | Script y Servicio de DoS | Bash / Iptables / Systemd | Detección automática y bloqueo de IPs maliciosas ante ataques de Denegación de Servicio gestionado como servicio daemon. |
| **3** | Código Firewall 1 Interfaz | Shorewall / Iptables | Políticas y reglas de filtrado para la protección de un host individual conectado a una sola interfaz de red. |
| **4** | Código Firewall 2 Interfaces | Shorewall / Iptables / Kea DHCP | Configuración de firewall perimetral y router NAT entre interfaz WAN e interfaz LAN con servidor DHCP. |

---

## Estructura del Repositorio

- **`1_proyecto_yolo_reconocimiento/`**
  - `detectar.py`: Inferencia en tiempo real utilizando OpenCV y cámara web.
  - `predecir.py`: Script de inferencia directa con Ultralytics.
  - `entrenamiento_roboflow_yolo.py`: Pipeline para descargar dataset de Roboflow y entrenar el modelo.
  - `best.pt`: Pesos optimizados del modelo entrenado.
  - `yolo.py`: Script base de detección con clases preentrenadas.

- **`2_script_y_servicio_dos/`**
  - `stop-dos-attack.sh`: Script en Bash que monitorea conexiones por IP y bloquea con `iptables`.
  - `stop-dos-attack.service`: Unidad de `systemd` para ejecución en segundo plano.

- **`3_codigo_fw_1_interfaz/`**
  - `shorewall/`: Archivos de configuración modular (`interfaces`, `zones`, `policy`, `rules`, `shorewall.conf`).
  - `iptables_fw_1_interfaz.sh`: Script en Bash equivalente con reglas directas en `iptables`.

- **`4_codigo_fw_2_interfaces/`**
  - `shorewall/`: Configuración para router perimetral con NAT (`interfaces`, `zones`, `policy`, `rules`, `snat`, `shorewall.conf`).
  - `iptables_fw_2_interfaces.sh`: Script en Bash con reenvío de paquetes y reglas `MASQUERADE`.
  - `kea-dhcp4.conf`: Archivo de configuración del servidor DHCP para la red local.
