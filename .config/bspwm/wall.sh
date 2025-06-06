#!/bin/bash

DIR="$HOME/wallpapers"
LIST="$HOME/.wallpapers_list"
INDEX_FILE="$HOME/.wall_index"

# Сгенерировать список, если его нет
if [ ! -f "$LIST" ]; then
  find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort > "$LIST"
fi

# Прочитать индекс
if [ ! -f "$INDEX_FILE" ]; then
  echo 0 > "$INDEX_FILE"
fi

index=$(<"$INDEX_FILE")
total=$(wc -l < "$LIST")

# Сбросить, если вышли за предел
if (( index >= total )); then
  index=0
fi

# Получить путь к обоям
wallpaper=$(sed -n "$((index+1))p" "$LIST")

# Установить обои
feh --bg-fill "$wallpaper"

# Сохранить следующий индекс
echo $((index + 1)) > "$INDEX_FILE"
