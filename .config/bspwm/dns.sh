#!/bin/bash

CONN="Wired connection 1"
COMSS_DNS="83.220.169.155 212.109.195.93"

# Получить текущие DNS
CURRENT=$(nmcli -g ipv4.dns connection show "$CONN")

echo "[+] Текущее DNS: $CURRENT"

if [[ "$CURRENT" == *"83.220.169.155"* ]] || [[ "$CURRENT" == *"212.109.195.93"* ]]; then
    echo "[i] DNS comss.one найден, переключаю на авто-DNS"
    nmcli connection modify "$CONN" ipv4.ignore-auto-dns no
    nmcli connection modify "$CONN" ipv4.dns ""
else
    echo "[i] DNS не comss.one — включаю comss.one"
    nmcli connection modify "$CONN" ipv4.ignore-auto-dns yes
    nmcli connection modify "$CONN" ipv4.dns "$COMSS_DNS"
fi

# Применить
nmcli connection down "$CONN"
sleep 1
nmcli connection up "$CONN"

# Показать результат
echo -e "\n[*] Новый /etc/resolv.conf:"
cat /etc/resolv.conf
