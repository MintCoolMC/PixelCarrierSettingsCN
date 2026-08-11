#!/bin/sh

protoc -I./mkproto -I./mkproto/include --encode=com.google.carrier.CarrierSettings carrier_settings_1.proto < mkproto/protobuf/cbn_cn.proto > mkproto/CarrierSettings/cbn_cn.pb
protoc -I./mkproto -I./mkproto/include --encode=com.google.carrier.CarrierSettings carrier_settings_1.proto < mkproto/protobuf/chinamobile_cn.proto > mkproto/CarrierSettings/chinamobile_cn.pb
protoc -I./mkproto -I./mkproto/include --encode=com.google.carrier.CarrierSettings carrier_settings_1.proto < mkproto/protobuf/chinatelecom_cn.proto > mkproto/CarrierSettings/chinatelecom_cn.pb
protoc -I./mkproto -I./mkproto/include --encode=com.google.carrier.CarrierSettings carrier_settings_1.proto < mkproto/protobuf/chinaunicom_cn.proto > mkproto/CarrierSettings/chinaunicom_cn.pb
