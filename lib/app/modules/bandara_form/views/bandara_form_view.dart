import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/bandara_form_controller.dart';

class BandaraFormView extends GetView<BandaraFormController> {
  const BandaraFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SizedBox(
          height: 350.h,
          width: 250.w,
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              // margin: EdgeInsets.all(10),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Center(
                    child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          'Pilih Bandara',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Obx(
                          () => DropdownButton<int?>(
                              isExpanded: true,
                              hint: const Text("Kelas Bandara"),
                              value: controller.selectedKelas.value,
                              items: controller.kelas
                                  .map((e) => DropdownMenuItem(
                                      value: controller.kelas.indexOf(e),
                                      child: Text(
                                        e,
                                        overflow: TextOverflow.ellipsis,
                                      )))
                                  .toList(),
                              onChanged: (val) {
                                controller.selectedKelas.value = val;
                              }),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Obx(
                          () => DropdownButton<int?>(
                              isExpanded: true,
                              hint: const Text("Nama Bandara"),
                              value: controller.selectedBandara.value,
                              items: controller
                                  .bandara[controller.selectedKelas.value ?? 0]
                                  .map((e) => DropdownMenuItem(
                                      value: controller.bandara[
                                              controller.selectedKelas.value ??
                                                  0]
                                          .indexOf(e),
                                      child: Text(
                                        e,
                                        overflow: TextOverflow.ellipsis,
                                      )))
                                  .toList(),
                              onChanged: controller.selectedKelas.value == null
                                  ? null
                                  : (val) {
                                      controller.selectedBandara.value = val;
                                    }),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.amber),
                          onPressed: () async {
                            controller.lanjutkan();
                          },
                          child: const Text('Lanjutkan'),
                        ),
                      ),
                      // Add TextFormFields and ElevatedButton here.
                    ],
                  ),
                )),
              )),
        ),
      ),
    );
  }
}
