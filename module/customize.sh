killall com.google.android.carrier
sed -i '/identified_carriers/d; /applied_settings_version/d' \
    /data/user_de/0/com.google.android.carrier/shared_prefs/com.google.android.carrier_preferences.xml
