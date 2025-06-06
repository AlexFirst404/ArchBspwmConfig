#!/bin/bash

SERVICE="zapret_discord_youtube.service"

if systemctl is-active --quiet "$SERVICE"; then
    echo "[i] $SERVICE запущен — отключаю..."
    sudo systemctl stop "$SERVICE"
    echo "[✓] Отключено."
else
    echo "[i] $SERVICE неактивен — запускаю..."
    sudo systemctl start "$SERVICE"
    echo "[✓] Запущено."
fi

# Статус
echo -n "[*] Статус: "
systemctl is-active "$SERVICE"
