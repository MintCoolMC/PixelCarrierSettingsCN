#!/bin/sh

modify_last_updated=$1

function generate_carrier_settings() {
    local input_file="$1"
    local output_file="$2"

    if [ ! -f "$input_file" ]; then
        echo "Error: input file '$input_file' not found" >&2
        exit 1
    fi

    if [  "$modify_last_updated" == "1" ]; then
        current_timestamp=$(date +%s)
        sed "/last_updated {/,/}/ s/seconds: [0-9]*/seconds: $current_timestamp/" \
        "$input_file" > "$input_file".tmp
        mv "$input_file".tmp "$input_file"
    fi

    protoc -I./mkproto -I./mkproto/include --encode=com.google.carrier.CarrierSettings carrier_settings.proto < "$input_file" > "$output_file"
    if [ $? -ne 0 ]; then
        echo "Error: protoc encode failed for '$input_file'" >&2
        exit 1
    fi
}

generate_carrier_settings "mkproto/protobuf/cbn_cn.textpb" "mkproto/CarrierSettings/cbn_cn.pb"
generate_carrier_settings "mkproto/protobuf/chinamobile_cn.textpb" "mkproto/CarrierSettings/chinamobile_cn.pb"
generate_carrier_settings "mkproto/protobuf/chinatelecom_cn.textpb" "mkproto/CarrierSettings/chinatelecom_cn.pb"
generate_carrier_settings "mkproto/protobuf/chinaunicom_cn.textpb" "mkproto/CarrierSettings/chinaunicom_cn.pb"
