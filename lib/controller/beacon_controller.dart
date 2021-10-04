import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';

class BeaconController extends GetxController {
  final regions = <Region>[];
  RxBool isListening = false.obs;
  RxList<Beacon> beacons = RxList<Beacon>();

  @override
  void onInit() {
    super.onInit();
    _initFlutterBeacon();
  }

  void _initFlutterBeacon() async {
    try {
      await flutterBeacon.initializeScanning;
      await flutterBeacon.initializeAndCheckScanning; // 권한체크=>자동권한요청

      if (Platform.isIOS) {
        regions.add(Region(
          identifier: 'Test',
          proximityUUID: '39ED98FF-2900-441A-802F-9C398FC199D2', // 수신할 UUID
        ));
      } else {
        regions.add(Region(identifier: 'Test')); // Android는 모든 Beacon 수신 가능
      }

      print(
          '\x1B[95m========== Flutter Beacon Initialized ==========\x1B[105m');
    } on PlatformException {
      print('\x1B[95m========== Flutter Beacon Init Faild ==========\x1B[105m');
    }
  }

  void startListening() {
    _bindBeacon(); // Stream을 RxList에 바인딩!
    isListening.value = true;
  }

  void stopListening() {
    beacons.clear(); // Beacon List를 비워주고
    beacons.close(); // Stream을 닫아준다
    beacons =
        RxList(); // 스트림이 연결안된 새로운 RxList로 변경!(해주지 않으면 Obx로 해당 값을 바라보고 있는 위젯에서 닫힌 스트림을 읽고있어서 에러남)
    isListening.value = false;
  }

  void _bindBeacon() {
    Stream<RangingResult> originStream =
        flutterBeacon.ranging(regions); // flutterBacon 라이브러라 beacon 스트리 받아오기
    Stream<List<Beacon>> convertedStream = originStream
        .map((r) => r.beacons); // RangingResult 스트림을 List<Beacon> 스트림으로 변환
    beacons.bindStream(convertedStream); // RxList에 바인딩 시켜주기
  }
}
