import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import 'package:valitag/button/smart_button.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/utils/gox.dart';

import '../../../constants/imageText/app_images.dart';
import '../../constants/appColors.dart';
import '../../providers/auth_provider.dart';
import '../../utils/navigator_service.dart';
import '../../utils/show_dialog.dart';
import '../readyToScan/ready_to_scan.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassShow = true;
  bool isRemember = false;
  bool checkVal = false;
  final loginFormKey = GlobalKey<FormState>();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.white;
  }

  @override
  void initState() {
    //sp?.clear();
    // checkVal = sp?.getBool(SpUtil.REMEBER_ME) ?? false;
    // var p = Provider.of<AuthProvider>(context, listen: false);
    // Future.microtask(() => p.getUserDetails(checkVal:checkVal));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, value, child) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: const BoxDecoration(
            color: Color(0xffFFFFFF),
          ),
          child: SafeArea(
            child: Form(
                key: loginFormKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),

                    Container(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(AppImages.valitagLogo,
                            width: 194, height: 80)),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),

                    //Login Text
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppText.login,
                        style: TextStyle(
                            fontFamily: FontFamily.neueMedium,
                            fontSize: 25,
                            color: Color(0xff000000)),
                      ),
                    ),

                    //EnterLoginDetails
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppText.loginDetails,
                        style: TextStyle(
                            fontFamily: FontFamily.neueLight,
                            fontSize: 13,
                            color: Color(0xff000000)),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),

                    //Email
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.lightGreyColorB,
                            // Border color
                            width: 1, // Border width
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: value.loginEmailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontFamily: FontFamily.neueLight,
                              fontSize: 14,
                              color: Color(0xff8A8A8A)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    //Password
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.lightGreyColorB,
                            // Border color
                            width: 1, // Border width
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: value.loginPassController,
                        obscureText: isPassShow,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              fontFamily: FontFamily.neueLight,
                              fontSize: 14,
                              color: Color(0xff8A8A8A)),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPassShow = !isPassShow;
                              });
                            },
                            icon: Icon(
                              isPassShow
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return '* Required';
                        //   } else {
                        //     null;
                        //   }
                        // }
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //CheckBox
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                              value: checkVal,
                              checkColor: AppColors.blueColor,
                              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              // visualDensity: VisualDensity(horizontal: 4),
                              activeColor: AppColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                  width: 1.0,
                                  color: AppColors.lightGreyColorB,
                                ),
                              ),
                              onChanged: (v) {
                                print("Value V is :: ${v}");
                                setState(() {
                                  checkVal = v ?? false;
                                  // sp?.putBool(SpUtil.REMEBER_ME, checkVal);
                                  print("CheckVal is :: ${checkVal}");
                                });
                                // value?.checkVal = value ;
                              }),
                        ),

                        //   Checkbox(
                        //     checkColor: Colors.blue,
                        //     // fillColor: Colors.grey,
                        //     fillColor: MaterialStateProperty.resolveWith(getColor),
                        //     value: isRemember,
                        //     onChanged: (bool? value) {
                        //   setState(() {
                        //     isRemember = value!;
                        //   });
                        //  },
                        // ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          AppText.rememberMe,
                          style: TextStyle(
                            fontFamily: FontFamily.neueLight,
                            color: Color(0xff000000),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //Login
                    SmartButton(
                        onTap: () {
                          if (loginFormKey.currentState!.validate()) {
                            value.loginApi();
                          }
                          // value.loginEmailController.clear();
                          // value.loginPassController.clear();
                          // GoX.goPush(const ReadyToScan());
                        },
                        height: 54,
                        color: const Color(0xff007FC5),
                        radius: 100,
                        value: "Login",
                        textStyle: const TextStyle(
                          fontFamily: FontFamily.neueMedium,
                          fontSize: 16,
                          color: Color(0xffFFFFFF),
                        )),

                    const SizedBox(
                      height: 10,
                    ),

                    //GuestUser
                    SmartButton(
                        onTap: () {
                          GoX.goPush(const ReadyToScan());
                          // mDialog(context, RouteLi/**/stDialog(title: "Route List",));
                        },
                        height: 54,
                        color: Colors.white,
                        radius: 100,
                        borderColor: const Color(0xff007FC5),
                        value: "Guest User",
                        textStyle: const TextStyle(
                          fontFamily: FontFamily.neueMedium,
                          fontSize: 16,
                          color: Color(0xff007FC5),
                        )),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                    ),

                    //NFCImage
                    GestureDetector(
                        onTap: () {
                          // GoX.goPush(const ReadyToScan());
                          initNFC(value);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.asset(AppImages.sensorIcon),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                AppText.nfcLogin,
                                style: TextStyle(
                                  fontFamily: FontFamily.neueMedium,
                                  color: Color(0xff007FC5),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        )),
                    // GestureDetector(
                    //   onTap: () {
                    //     GoX.goPush(const ReadyToScan());
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: 50,
                    //     child: Image.asset(AppImages.sensorIcon),
                    //   ),
                    // ),
                    //
                    // //NFCText
                    //  Container(
                    //     alignment: Alignment.center,
                    //     child: const Text(
                    //       AppText.nfcLogin,
                    //       style: TextStyle(
                    //         fontFamily: FontFamily.neueMedium,
                    //         color: Color(0xff007FC5),
                    //         fontSize: 14,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                )),
          ),
        ),
      );
    });
  }

  Future<void> initNFC(AuthProvider value) async {


    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (!isAvailable) showSnackBar('NFC Not Supported..');
      if (!isAvailable) return;
      showToastMessage('Please Wait...');
      // Start session
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        print('Data --- > ${tag.data}');

        final encryptedData = CryptoService().encryptData(tag.toString());

        final message = NdefMessage([
          NdefRecord.createText(encryptedData),
        ]);
        print('Data written to NFC tag. Message ${message}');
        print('Data written to NFC tag.');

        final Map<dynamic, dynamic> ndef = tag.data['ndef'] ?? {};
        List<int> identifierValue = ndef['identifier'] ?? [];
        String identifierHash = identifierValue.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(':');

        Map<String, dynamic> nfcData = {
          'ndef': {
            'identifier': {
              'nfcid': identifierHash,
              'value': identifierValue,
            },
          },
        };
        print('nfcData -- > $nfcData');
        await value.callApi(identifierHash);
      });
    } catch (e) {
      print('Catch --- > ${e.toString()}');
      showSnackBar(e.toString());
    }
  }
}


  // keyEncFun(){
  //   var encrypt = "48392017486029503718";
  //   // final key = encrypt.Key.fromLength(32);
  //   // final iv = encrypt.IV.fromLength(16);
  //   // final encrypter = encrypt.Encrypter(encrypt.AES(key));
  //   final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  //
  //   Key key = encrypt;
  //   final iv = IV.fromSecureRandom(16);
  //   final encrypter = Encrypter(AES(key));
  //
  //   final encrypted = encrypter.encrypt(plainText, iv: iv);
  //   final decrypted = encrypter.decrypt(encrypted, iv: iv);
  //
  //   print(decrypted);
  //   print(encrypted.bytes);
  //   print(encrypted.base16);
  //   print(encrypted.base64);
  // }

class AddDogModalSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                 children: [
                   const SizedBox(
                     height: 20,
                   ),
                   Container(
                     alignment: Alignment.center,
                     child:  const Text(
                       'Ready To Scan',
                       style: TextStyle(
                         fontFamily: FontFamily.neueMedium,
                         color: Colors.black,
                         fontSize: 18,
                       ),
                     ),
                   ),
                 ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}




class CryptoService {
  final key = encrypt.Key.fromLength(32); // 256-bit key
  final iv = encrypt.IV.fromLength(16);   // 128-bit IV

  String encryptData(String plainText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decryptData(String encryptedText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}