# Código Firewall - 1 Interfaz

Configuración de Firewall de un solo host con una interfaz de red (`wlp1s0` / `net`).

## Estructura

- **`shorewall/`**: Configuración modular para Shorewall (Netfilter / Iptables):
  - `interfaces`: Define la interfaz de red (`wlp1s0`) con opciones `dhcp,tcpflags,logmartians,nosmurfs`.
  - `zones`: Declara las zonas `fw` (firewall local) y `net` (red externa).
  - `policy`: Política de seguridad por defecto:
    - `$FW -> net`: DROP
    - `net -> all`: DROP
    - `all -> all`: REJECT
  - `rules`: Reglas de filtrado específicas:
    - `Invalid(DROP)`: Descarta paquetes en estado inválido.
    - `Ping(DROP)`: Descarta solicitudes de ping entrantes.
    - `ACCEPT $FW net icmp`: Permite tráfico ICMP originado desde el firewall hacia el exterior.
- **`iptables_fw_1_interfaz.sh`**: Script en Bash que aplica las mismas políticas directamente con `iptables`.
