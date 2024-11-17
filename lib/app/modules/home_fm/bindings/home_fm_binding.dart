import 'package:get/get.dart';

import '../controllers/home_fm_controller.dart';

class HomeFmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeFmController>(
      () => HomeFmController(),
    );
  }
}
