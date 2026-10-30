# Script y Servicio de Mitigación de Ataques DoS

Este módulo implementa un sistema automatizado para detectar y mitigar ataques de Denegación de Servicio (DoS) monitoreando conexiones simultáneas por IP.

## Componentes

1. **`stop-dos-attack.sh`**:
   - Monitorea periódicamente las conexiones de red activas usando `netstat`, `awk` y `sort`.
   - Identifica la dirección IP que acumula el mayor número de conexiones concurrentes.
   - Si el número de conexiones supera el umbral (50 conexiones), agrega una regla a `iptables` en la cadena `INPUT` para descartar (`DROP`) todo el tráfico proveniente de dicha IP.
   - Valida si la regla ya existe antes de insertarla para evitar duplicados.

2. **`stop-dos-attack.service`**:
   - Archivo de unidad de `systemd` para gestionar el script como un demonio continuo del sistema.
   - Se ejecuta en `/usr/local/bin/stop-dos-attack.sh` y se inicia automáticamente en el arranque (`multi-user.target`).

## Instalación y Uso

```bash
# 1. Copiar el script a la ruta de ejecutables del sistema
sudo cp stop-dos-attack.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/stop-dos-attack.sh

# 2. Copiar el archivo de servicio a systemd
sudo cp stop-dos-attack.service /etc/systemd/system/

# 3. Recargar el daemon y habilitar el servicio
sudo systemctl daemon-reload
sudo systemctl enable --now stop-dos-attack.service

# 4. Verificar el estado del servicio
sudo systemctl status stop-dos-attack.service
```
