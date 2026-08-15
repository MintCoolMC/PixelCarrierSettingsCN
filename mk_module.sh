#!/bin/sh

mkdir -p ./module/system/product/etc/CarrierSettings/
cp ./mkproto/CarrierSettings/*.pb ./module/system/product/etc/CarrierSettings/ 2>/dev/null
cp ./mkproto/CarrierList_pb/carrier_list_cn.pb ./module/carrier_list_cn.pb 2>/dev/null
(cd ./module && zip -r ../PixelCarrierSettingsCN.zip .)
