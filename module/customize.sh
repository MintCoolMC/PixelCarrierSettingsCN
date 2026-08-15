if [ ! -f /product/etc/CarrierSettings/carrier_list.pb ]; then
    abort "Error: carrier_list.pb not found, are you using a Pixel device?"
fi

killall com.google.android.carrier
sed -i '/identified_carriers/d; /applied_settings_version/d' \
    /data/user_de/0/com.google.android.carrier/shared_prefs/com.google.android.carrier_preferences.xml
