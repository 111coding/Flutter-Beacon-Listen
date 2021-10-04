import 'package:flutter_beacon_listen/controller/beacon_controller.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BeaconController());
  }
}
