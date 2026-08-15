#!/bin/sh

mkdir -p mkproto/protobuf mkproto/CarrierList_pb 2>/dev/null
protoc -I./mkproto -I./mkproto/include --encode=com.google.carrier.CarrierList carrier_list.proto < mkproto/protobuf/carrier_list_cn.textpb > mkproto/CarrierList_pb/carrier_list_cn.pb
