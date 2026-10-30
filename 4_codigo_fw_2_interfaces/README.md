# Código Firewall - 2 Interfaces

Configuración de Firewall Perimetral / Router con dos interfaces de red:
- **WAN (Externa):** `wlp1s0` (Internet / DHCP).
- **LAN (Interna):** `enp0s31f6` (Red privada `192.168.100.0/24`).

## Componentes

1. **`shorewall/`**: Configuración modular para Shorewall:
   - `interfaces`: Declara `net` (`wlp1s0`) y `loc` (`enp0s31f6`).
   - `zones`: Zonas `fw`, `net` y `loc`.
   - `policy`: Permite tráfico de `loc` a `net` (`ACCEPT`) y bloquea tráfico entrante de `net`.
   - `rules`: Reglas de filtrado, DNS, SSH administrativo y protección contra pings no deseados.
   - `snat`: Enmascaramiento / NAT (`MASQUERADE`) para otorgar salida a Internet a los hosts de la LAN.
2. **`iptables_fw_2_interfaces.sh`**: Script en Bash que configura `ip_forward`, reglas de `FORWARD` y `MASQUERADE` en `iptables`.
3. **`kea-dhcp4.conf`**: Configuración del servidor Kea DHCP para asignar dinámicamente direcciones IP en la interfaz local (`enp0s31f6`) dentro del pool `192.168.100.50 - 192.168.100.100`.
