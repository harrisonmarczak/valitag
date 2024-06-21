
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/ui/readyToScanAsset1/readyToScanAsset1.dart';

import '../button/smart_button.dart';
import '../providers/imageDialogProvider.dart';
import '../providers/scanAsset_provider.dart';
import '../utils/gox.dart';

class CommonImageDialog extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? content;
  final String? textPositive;
  final String? textNegative;
  final bool? isPositive;
  final bool? isNegative;
  final bool? isCancel;
  final double? titleSize;
  final Function()? positiveTap;
  final Function()? negativeTap;
  final XFile? image;

  const CommonImageDialog({
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
    this.titleSize,
    this.image,
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

                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width*0.8,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffBCBCBC), // Border color
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                value.image == null
                                ? GestureDetector(
                                onTap : () => value.getImageData(),
                                  child: Container(
                                      height:30, width: 30,
                                      child: Image.asset(AppImages.galleryIcon)),
                                )
                                :  Container(
                                    height: MediaQuery.of(context).size.height*0.2,
                                    width: MediaQuery.of(context).size.width *0.8,
                                    child: Image.file(File(value.image!.path))
                                ),

                            value.image == null
                             ? GestureDetector(
                                onTap: () => value.getImageData(),
                                child: const Text(
                                    "Please upload Image...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: FontFamily.neueLight,
                                        color: Color(0xff000000),
                                        //fontWeight: FontWeight.w600,
                                        fontSize: 13
                                    )
                                ),
                              )
                             : SizedBox(),



                            ],
                            ),
                          ),

                          SizedBox(height: 20,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
//CancelButton
                              GestureDetector(
                                onTap : () {
                                  GoX.goPop();
                                  value.image = null;
                                },
                                child: Container(
                                  height: 50, width: MediaQuery.of(context).size.width/3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xff858686)
                                  ),
                                  child: Center(
                                    child: const Text(
                                      AppText.cancel ,
                                      style: TextStyle(
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
                                  value.saveImages();
                                  GoX.goPop();
                                  // GoX.goPush(ReadyToScanAsset1());
                                },
                                child: Container(
                                  height: 50, width: MediaQuery.of(context).size.width/3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xff007FC5)
                                  ),
                                  child: Center(
                                    child: const Text(
                                      AppText.save ,
                                      style: TextStyle(
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
