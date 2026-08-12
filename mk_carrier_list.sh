#!/bin/sh

input_file="$1"
version="$2"

if [ -n "$input_file" ] && [ -z "$version" ]; then
    echo "Error: missing output version (int64)" >&2
    exit 1
fi

if [ -n "$input_file" ] && [ ! -f "$input_file" ]; then
    echo "Error: input file '$input_file' not found" >&2
    exit 1
fi

if [ -n "$version" ]; then
    case $version in
        ''|*[!0-9]*)
            echo "Error: version '$version' is not a valid int64" >&2
            exit 1
            ;;
    esac
fi

mkdir -p mkproto/protobuf mkproto/CarrierSettings 2>/dev/null

if [ -n "$input_file" ]; then
    protoc -I./mkproto -I./mkproto/include --decode=com.google.carrier.CarrierList carrier_list_1.proto < "$input_file" > mkproto/protobuf/carrier_list.proto
    if [ $? -ne 0 ]; then
        echo "Error: protoc decode failed" >&2
        exit 1
    fi
    if [ -f mkproto/protobuf/carrier_list_cn.proto ]; then
        cat mkproto/protobuf/carrier_list_cn.proto mkproto/protobuf/carrier_list.proto > mkproto/protobuf/carrier_list.proto.tmp
        mv mkproto/protobuf/carrier_list.proto.tmp mkproto/protobuf/carrier_list.proto
    else
        echo "Error: mkproto/protobuf/carrier_list_cn.proto not found" >&2
        exit 1
    fi

    sed "s/version: [0-9]*/version: $version/g" mkproto/protobuf/carrier_list.proto > mkproto/protobuf/carrier_list.proto.tmp
    mv mkproto/protobuf/carrier_list.proto.tmp mkproto/protobuf/carrier_list.proto
else
    previous_version=$(sed -n 's/^version: \([0-9]*\)$/\1/p' mkproto/protobuf/carrier_list.proto)
    [ -z "$previous_version" ] && previous_version=0
    version=$((previous_version + 1))
    sed "s/version: [0-9]*/version: $version/g" mkproto/protobuf/carrier_list.proto > mkproto/protobuf/carrier_list.proto.tmp
    mv mkproto/protobuf/carrier_list.proto.tmp mkproto/protobuf/carrier_list.proto
fi

current_timestamp=$(date +%s)
sed "/last_updated {/,/}/ s/seconds: [0-9]*/seconds: $current_timestamp/" \
    mkproto/protobuf/carrier_list.proto > mkproto/protobuf/carrier_list.proto.tmp
mv mkproto/protobuf/carrier_list.proto.tmp mkproto/protobuf/carrier_list.proto

protoc -I./mkproto -I./mkproto/include --encode=com.google.carrier.CarrierList carrier_list_1.proto < mkproto/protobuf/carrier_list.proto > mkproto/CarrierSettings/carrier_list.pb
if [ $? -ne 0 ]; then
    echo "Error: protoc encode failed" >&2
    exit 1
fi
