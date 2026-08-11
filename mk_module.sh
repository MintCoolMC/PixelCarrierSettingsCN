#!/bin/sh

mkdir -p ./module/system/product/etc/CarrierSettings/
cp ./mkproto/CarrierSettings/*.pb ./module/system/product/etc/CarrierSettings/ 2>/dev/null || true
(cd ./module && zip -r ../PixelCarrierSettingsCN.zip .)
