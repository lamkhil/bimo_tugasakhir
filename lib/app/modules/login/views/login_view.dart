import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugasakhir/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
                          'Checklist Inspeksi Rutin Harian Kantor Unit Pelayanan Bandar Udara',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: controller.usernameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'username'),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextFormField(
                          obscureText: true,
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'password'),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: ElevatedButton(
                              onPressed: () async {
                                controller.login();
                              },
                              child: const Text('Login'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                side: const BorderSide(color: Colors.black),
                                elevation: 2,
                              ),
                              onPressed: () async {
                                Get.toNamed(Routes.REGISTER);
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      )
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
