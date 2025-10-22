#!/bin/bash
BIN="w240d-dvi.bin"
BUS=3
ADDR=0x50

if [ ! -f "$BIN" ]; then
  echo "Missing EDID binary: $BIN"
  exit 1
fi

for i in $(seq 0 255); do
  byte=$(xxd -p -s $i -l 1 "$BIN")
  echo "Writing byte $i: 0x$byte"
  sudo i2cset -y $BUS $ADDR $i 0x$byte
  sleep 0.01
done

echo "✅ Done flashing EDID to $ADDR on i2c-$BUS"

