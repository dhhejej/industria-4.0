#!/bin/bash
# ==============================================================================
# Firewall Router con 2 Interfaces de Red (Iptables + NAT)
# WAN: wlp1s0 (Conexión a Internet)
# LAN: enp0s31f6 (Red local privada 192.168.100.0/24)
# ==============================================================================

WAN_IF="wlp1s0"
LAN_IF="enp0s31f6"
LAN_NET="192.168.100.0/24"

echo "[+] Habilitando el reenvío de paquetes (IP Forwarding)..."
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "[+] Limpiando tablas de iptables..."
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

echo "[+] Estableciendo políticas por defecto..."
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

echo "[+] Permitir tráfico de loopback..."
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

echo "[+] Permitir conexiones establecidas y relacionadas..."
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

echo "[+] Descartar paquetes inválidos..."
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A FORWARD -m conntrack --ctstate INVALID -j DROP

echo "[+] Permitir acceso SSH y Ping desde la red local (LAN) al Firewall..."
iptables -A INPUT -i $LAN_IF -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i $LAN_IF -p icmp -j ACCEPT

echo "[+] Permitir solicitudes DHCP en la interfaz LAN..."
iptables -A INPUT -i $LAN_IF -p udp --dport 67:68 --sport 67:68 -j ACCEPT

echo "[+] Permitir tráfico saliente de LAN hacia Internet (FORWARD)..."
iptables -A FORWARD -i $LAN_IF -o $WAN_IF -s $LAN_NET -j ACCEPT

echo "[+] Configurando NAT (Masquerade) en la interfaz WAN..."
iptables -t nat -A POSTROUTING -o $WAN_IF -s $LAN_NET -j MASQUERADE

echo "[+] Firewall de 2 interfaces con NAT configurado exitosamente."
