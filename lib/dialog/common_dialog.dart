


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/ui/loginScreen/login_screen.dart';

import '../button/smart_button.dart';
import '../main.dart';
import '../providers/dialogProvider.dart';
import '../providers/imageDialogProvider.dart';
import '../providers/scanAsset_provider.dart';
import '../utils/gox.dart';

class CommonDialog extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? content;
  final String? textPositive;
  final String? textNegative;
  final String? cancelButtonTxt;
  final String? proceedButtonTxt;
  final bool? isPositive;
  final bool? isNegative;
  final bool? isCancel;
  final double? titleSize;
  final Function()? positiveTap;
  final Function()? negativeTap;

  const CommonDialog({
    super.key,
    this.icon,
    this.title,
    this.content,
    this.textPositive,
    this.textNegative,
    this.isPositive = true,
    this.isNegative = true,
    this.isCancel = true,
    this.positiveTap,
    this.negativeTap,
    this.titleSize, this.cancelButtonTxt, this.proceedButtonTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ScanAssetProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              //padding: MediaQuery.of(context).viewInsets,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
//Title
                          Padding(
                            padding: EdgeInsets.only(top: title == "" ? 0 : 20.0),
                            child: Text(title ?? "Dialog Title",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: FontFamily.neueMedium,
                                    color: Color(0xff000000),
                                    //fontWeight: FontWeight.w600,
                                    fontSize: titleSize ?? 24)),
                          ),

                          const SizedBox(height: 10),

//TextFormField
                        title == "Logout"
                          ? Text(
                            "Are you sure you want to Logout ?",
                            style: const TextStyle(
                              fontFamily: FontFamily.neueMedium,
                              color: Color(0xff686868),
                              fontSize: 15,
                            ),
                          )
                          : Container(
                            height: 200,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffBCBCBC), // Border color
                                  width: 2, // Border width
                                ),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: TextFormField(
                              controller: value.notesCont,
                              maxLines: 6,
                              maxLength: 900,
                              decoration: const InputDecoration(
                                hintText: 'Please enter any additional notes here.',
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

 //CancelButton
                              GestureDetector(
                                onTap : () {
                                  GoX.goPop();
                                },
                                child: Container(
                                  height: 50, width: MediaQuery.of(context).size.width/3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xff858686)
                                  ),
                                  child: Center(
                                    child: Text(
                                      cancelButtonTxt ??  AppText.cancel ,
                                      style: const TextStyle(
                                        fontFamily: FontFamily.neueMedium,
                                        color: Color(0xffFFFFFF),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

//SaveButton
                              GestureDetector(
                                onTap: () {
                                  if(title == "Logout")
                                    {
                                       value.logout();
                                     //GoX.goPushRemoveUntil(LoginScreen());
                                    }
                                  else
                                    {
                                      value.saveNotes();
                                      GoX.goPop();
                                    }

                                },
                                child: Container(
                                  height: 50, width: MediaQuery.of(context).size.width/3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xff007FC5)
                                  ),
                                  child: Center(
                                    child:  Text(
                                      proceedButtonTxt ?? AppText.save ,
                                      style: const TextStyle(
                                        fontFamily: FontFamily.neueMedium,
                                        color: Color(0xffFFFFFF),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),



                          /* Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isPositive == true) ...[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: SmartButton(
                                      value: textPositive ?? 'Yes',
                                      onTap: () {



                                         GoX.goPop();
                                        // print("Yes Button tapped");
                                        positiveTap?.call();
                                      },
                                      wrap: true,
                                      radius: 50,
                                      color: Color(0xff858686),
                                      height: 55,
                                      width: 107,
                                      // textStyle: light(
                                      //     fontSize: 15,
                                      //     color: AppColors.bgColorTextField)
                                  ),
                                ),
                              ],
                              if (isNegative == true) ...[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: SmartButton(
                                      value: textNegative ?? 'No',
                                      onTap: () {
                                        print("No Button tapped");
                                        GoX.goPop();
                                        negativeTap?.call();
                                      },
                                      wrap: true,
                                      radius: 50,
                                      // borderColor: AppColors.themeColor,
                                      color: Color(0xff007FC5),
                                      height: 55,
                                      borderWidth: 2,
                                      width: 107,
                                      // textStyle: light(
                                      //     fontSize: 15,
                                      //     color: AppColors.themeColor)
                                  ),
                                ),
                              ]
                            ],
                          ),*/
                          const SizedBox(height: 35),
                        ],
                      ),
                    ),
                  ),

                  if(isCancel == true)
                  Positioned(
                      right: 10,
                      top: 10,
                      child: InkWell(
                          onTap: () => GoX.goPop(),
                          child: Image.asset(
                            AppImages.startScanBlockingIcon,
                            height: 30,
                            color: Colors.grey,
                          )))
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
