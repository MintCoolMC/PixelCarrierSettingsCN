MODDIR=${0%/*}
CARRIER_LIST_PATH=/product/etc/CarrierSettings/carrier_list.pb

cat "$MODDIR/carrier_list_cn.pb" "$CARRIER_LIST_PATH" > "$MODDIR/system$CARRIER_LIST_PATH"
