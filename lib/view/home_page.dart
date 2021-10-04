import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_beacon_listen/components/beacon_item.dart';
import 'package:flutter_beacon_listen/controller/beacon_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BeaconController b = Get.find<BeaconController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text("Flutter Beacon Listen App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  b.isListening.value ? b.stopListening() : b.startListening();
                },
                child:
                    b.isListening.value ? Text("비콘수신 중지!") : Text("비콘수신 시작!"),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: b.beacons.length,
                  itemBuilder: (context, index) {
                    Beacon beacon = b.beacons[index];
                    return BeaconItem(
                      uuid: beacon.proximityUUID,
                      majorId: beacon.major,
                      minorId: beacon.minor,
                      accuracy: beacon.accuracy,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
