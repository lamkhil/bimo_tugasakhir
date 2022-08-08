import 'package:get/get.dart';

import '../controllers/bandara_form_controller.dart';

class BandaraFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BandaraFormController>(
      () => BandaraFormController(),
    );
  }
}
