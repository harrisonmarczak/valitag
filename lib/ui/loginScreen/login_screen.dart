import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:valitag/button/smart_button.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/main.dart';
import 'package:valitag/ui/routeList/route_list.dart';
import 'package:valitag/utils/common_widget.dart';
import 'package:valitag/utils/gox.dart';
import 'package:valitag/utils/shared_preferences.dart';

import '../../../constants/imageText/app_images.dart';
import '../../constants/appColors.dart';
import '../../providers/auth_provider.dart';
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
     sp?.clear();
    // checkVal = sp?.getBool(SpUtil.REMEBER_ME) ?? false;
    // var p = Provider.of<AuthProvider>(context, listen: false);
    // Future.microtask(() => p.getUserDetails(checkVal:checkVal));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, value, child) {
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height ,
            width: MediaQuery.of(context).size.width ,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Color(0xffFFFFFF),
            ),
            child: SafeArea(
              child: ListView(
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.height/ 10,
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                      child: Image.asset(AppImages.valitagLogo, width: 194, height: 80)
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height/ 30,
                  ),

        //Login Text
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      AppText.login,
                      style: TextStyle(
                        fontFamily: FontFamily.neueMedium,
                        fontSize: 25,
                        color: Color(0xff000000)
                      ),
                    ),
                  ),

        //EnterLoginDetails
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      AppText.loginDetails,
                      style: TextStyle(
                          fontFamily: FontFamily.neueLight ,
                          fontSize: 13,
                          color: Color(0xff000000)
                      ),
                   ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height/ 40,
                  ),

        //Email
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGreyColorB, // Border color
                        width: 1, // Border width
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      controller: value.loginEmailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontFamily: FontFamily.neueLight ,
                          fontSize: 14,
                          color: Color(0xff8A8A8A)
                        ),
                        border: InputBorder.none,
                      ),

                    ),
                  ),

                  const SizedBox(height: 15,),

        //Password
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightGreyColorB, // Border color
                          width: 1, // Border width
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      controller: value.loginPassController,
                      obscureText: isPassShow,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          fontFamily: FontFamily.neueLight ,
                          fontSize: 14,
                          color: Color(0xff8A8A8A)
                        ),
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
                          ) ,
                       )
                      ),

                    ),
                  ),

                  const SizedBox(height: 10,),
        //CheckBox
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(value: checkVal,
                            checkColor: AppColors.blueColor,
                            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            // visualDensity: VisualDensity(horizontal: 4),
                            activeColor: AppColors.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                                  (states) => const BorderSide(width: 1.0, color: AppColors.lightGreyColorB,),
                            ),
                            onChanged: (v) {
                              print("Value V is :: ${v}");
                              setState(() {
                                checkVal = v ?? false ;
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
                    const SizedBox(width: 5,),
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
                        // value.loginApi();
                        value.loginEmailController.clear();
                        value.loginPassController.clear();
                        GoX.goPush(const ReadyToScan());
                      },
                      height: 54,
                      color: Color(0xff007FC5),
                      radius: 100,
                      value: "Login",
                      textStyle: TextStyle(
                        fontFamily: FontFamily.neueMedium,
                        fontSize: 16,
                        color: Color(0xffFFFFFF),
                      )
                  ),

                const SizedBox(height: 10,),

        //GuestUser
                SmartButton(
                    onTap: () {
                      GoX.goPush(const ReadyToScan());
                      // mDialog(context, RouteLi/**/stDialog(title: "Route List",));
                    },
                    height: 54,
                    color: Colors.white,
                    radius: 100,
                    borderColor: Color(0xff007FC5),
                    value: "Guest User",
                    textStyle: TextStyle(
                      fontFamily: FontFamily.neueMedium,
                      fontSize: 16,
                      color: Color(0xff007FC5),
                    )
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height/ 8,
                ),

        //NFCImage
                  GestureDetector(
                    onTap: () {
                      GoX.goPush(const ReadyToScan());
                    },
                    child: Container(
                      height: 50, width: 50,
                        child: Image.asset(AppImages.sensorIcon),
                    ),
                  ),

        //NFCText
                  GestureDetector(
                    onTap: () {
                      GoX.goPush(const ReadyToScan());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppText.nfcLogin,
                        style: TextStyle(
                          fontFamily: FontFamily.neueMedium,
                          color: Color(0xff007FC5),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
