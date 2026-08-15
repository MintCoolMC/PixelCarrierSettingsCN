#!/bin/sh
complete=$1

if [ "$complete" == "1" ]; then
    ./mk_carrier_list_cn.sh
    ./mk_carrier_settings.sh

    if [ -f "./PixelCarrierSettingsCN.zip" ]; then
        rm -f "./PixelCarrierSettingsCN.zip"
    fi
fi

if [ ! -f "./mkproto/CarrierList_pb/carrier_list_cn.pb" ]; then
    echo "Error: carrier_list_cn.pb not found, you may want to generate it first?" >&2
    exit 1
fi

if ! ls ./mkproto/CarrierSettings/*.pb 1> /dev/null 2>&1; then
    echo "Error: CarrierSettings pb files not found, you may want to generate them first?" >&2
    exit 1
fi

mkdir -p ./module/system/product/etc/CarrierSettings/
cp ./mkproto/CarrierSettings/*.pb ./module/system/product/etc/CarrierSettings/ 2>/dev/null
cp ./mkproto/CarrierList_pb/carrier_list_cn.pb ./module/carrier_list_cn.pb 2>/dev/null
(cd ./module && zip -r ../PixelCarrierSettingsCN.zip .)
