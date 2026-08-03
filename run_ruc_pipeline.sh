#!/bin/bash

cd /home/daniel/ICON_RUC

# Carica il file .env
set -a
source /home/daniel/ICON_RUC/.env
set +a

# Attivazione del NUOVO ambiente virtuale dedicato a ICON_RUC
source /home/daniel/ICON_RUC/venv/bin/activate
export ECCODES_LOG_STREAM="/dev/null"

echo "🌩️ Inizio elaborazione ICON-D2 RUC EPS..."

echo "🌧️ Calcolo Precipitazioni (Media e Probabilità) in parallelo..."
python3 icon_d2_ruc_prec_mean.py &
python3 icon_d2_ruc_prec_prob.py &
wait

echo "🧊 Calcolo Grandine (Dimensione e Probabilità) in parallelo..."
python3 icon_d2_ruc_hail.py &
python3 icon_d2_ruc_hail_prob.py &
wait

echo "💨 Calcolo Vento (Raffiche Massime)..."
python3 icon_d2_ruc_vmax.py

echo "✅ Finito ICON-D2 RUC EPS! Torno a riposo."
