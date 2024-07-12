import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/model/routeList_model.dart';
import 'package:valitag/ui/readyToScanAsset1/readyToScanAsset1.dart';

import '../api_services/api_config.dart';
import '../button/smart_button.dart';
import '../model/product_model.dart';
import '../ui/googleMapScreen/google_map.dart';
import '../utils/gox.dart';

class CommonImageDialogB extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? content;
  final String? inspectedTime;
  final String? textPositive;
  final String? textNegative;
  final bool? isPositive;
  final bool? isNegative;
  final bool? isCancel;
  final double? titleSize;
  final Function()? positiveTap;
  final Function()? negativeTap;
  final String? meridiemTime;
  final  ProductModel? modal;

  const CommonImageDialogB({
    super.key,
    this.icon,
    this.title,
    this.content,
    this.inspectedTime,
    this.textPositive,
    this.textNegative,
    this.isPositive = true,
    this.isNegative = true,
    this.isCancel = true,
    this.positiveTap,
    this.negativeTap,
    this.titleSize,
    this.meridiemTime,
    this.modal,
  });



  @override
  Widget build(BuildContext context) {


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
                      Container(
                        height: 3, width: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xffEFEFEF)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: title == "" ? 0 : 20.0),
                        child: Text(title ?? "Dialog Title",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: FontFamily.neueMedium,
                                color: const Color(0xff000000),
                                //fontWeight: FontWeight.w600,
                                fontSize: titleSize ?? 24)),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
                              height: 20, width: 20,
                              child: Image.asset(AppImages.startScanClockIcon)),
                          const SizedBox(width: 10,),

                          Text(inspectedTime ?? '',
                            // "Inspection 10:40 am" ,
                            // AppText.startScanInspectedTime ,
                            style: const TextStyle(
                              fontFamily: FontFamily.neueLight,
                              color: Color(0xff434343),
                              fontSize: 14,
                            ),
                          ),

                          // Text(
                          //   "Inspection ${inspectedTime} $meridiemTime" ,
                          //   // AppText.startScanInspectedTime ,
                          //   style: const TextStyle(
                          //     fontFamily: FontFamily.neueLight,
                          //     color: Color(0xff434343),
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ],
                      ),


                      const SizedBox(height: 20),

                      Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  (modal?.data?.route?.image.toString() ?? "").isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network("${modal?.data?.route?.image}", fit: BoxFit.cover,errorBuilder: (BuildContext, Object, StackTrace){
                                    return Container(
                                      color: Colors.grey,
                                    );
                                  }))
                                : Image.asset(AppImages.aquariumImage)
                      ),

                      const SizedBox(height: 10,),

                      modal?.data != null && modal?.data!.assetsNotes != null && modal?.data!.assetsNotes!.isNotEmpty == true ? Text(
                          "Asset Instruction : ${modal?.data?.assetsNotes?.first.description ?? 'N/A'}",
                              // "Asset Instruction : ${AppText.assetInstruction}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: FontFamily.neueLight,
                              color: Color(0xff000000),
                              //fontWeight: FontWeight.w600,
                              fontSize: 14
                          )
                      ) : SizedBox.shrink(),

                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
//CloseButton
                          GestureDetector(
                            onTap : () {
                              GoX.goPop();
                            },
                            child: Container(
                              height: 46, width: MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xff858686)
                              ),
                              child: const Center(
                                child: Text(
                                  AppText.close ,
                                  style: TextStyle(
                                    fontFamily: FontFamily.neueLight,
                                    color: Color(0xffFFFFFF),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
//MapButton
                          GestureDetector(
                            onTap: () {
                              // MapsLauncher.launchQuery( '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA');
                              if(modal != null && modal!.data != null && modal!.data!.route != null && modal!.data!.route!.address != null){
                                MapsLauncher.launchQuery('${modal!.data!.route!.address}');
                              }
                              // GoX.goPush(GoogleMap());
                            },
                            child: Container(
                              height: 46, width: MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xff007FC5)
                              ),
                              child: const Center(
                                child: Text(
                                  AppText.map ,
                                  style: TextStyle(
                                    fontFamily: FontFamily.neueLight ,
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


            ],
          ),
        ),
      ),
    );
  }
}
