#!/bin/bash
# ==============================================================================
# Firewall con 1 Interfaz de Red (Iptables)
# Interfaz: wlp1s0 (o eth0)
# ==============================================================================

IFACE="wlp1s0"

echo "[+] Limpiando reglas anteriores..."
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

echo "[+] Estableciendo políticas por defecto (DROP)..."
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

echo "[+] Permitir tráfico de loopback..."
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

echo "[+] Permitir conexiones ya establecidas y relacionadas..."
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

echo "[+] Descartar paquetes inválidos..."
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

echo "[+] Bloquear Ping (ICMP Echo Request) entrante para evitar flood..."
iptables -A INPUT -i $IFACE -p icmp --icmp-type echo-request -j DROP

echo "[+] Permitir respuestas ICMP salientes del firewall..."
iptables -A OUTPUT -p icmp -j ACCEPT

echo "[+] Firewall de 1 interfaz configurado correctamente."
