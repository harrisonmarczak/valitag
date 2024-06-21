import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/model/routeList_model.dart';
import 'package:valitag/model/route_list_modal_client.dart';
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
  final  RouteDetailsModal? modal;

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
                        padding: EdgeInsets.only(top: modal?.name == "" ? 0 : 20.0),
                        child: Text(modal?.name ?? "Dialog Title",
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

                          SizedBox(
                              height: 20, width: 20,
                              child: Image.asset(AppImages.startScanClockIcon)),
                          const SizedBox(width: 10,),

                          const Text(
                            "Inspection 10:40 am" ,
                            // AppText.startScanInspectedTime ,
                            style: TextStyle(
                              fontFamily: FontFamily.neueLight,
                              color: Color(0xff434343),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  (modal?.assetNo?? "").isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network("$baseImageUrl${modal?.assetNo}"))
                                : Image.asset(AppImages.aquariumImage)
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                              "Asset Instruction : ${AppText.assetInstruction}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: FontFamily.neueLight,
                              color: Color(0xff000000),
                              //fontWeight: FontWeight.w600,
                              fontSize: 14
                          )
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                          GestureDetector(
                            onTap: () {
                              //MapsLauncher.launchQuery( '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA');
                              openGoogleMaps(lat:modal?.latitude,long:modal?.longitude);
                            //  GoX.goPush(GoogleMap());
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

  void openGoogleMaps({String ? lat, String ? long}) async {
    // Replace with your desired latitude and longitude
     double latitude = double.parse(lat??"26.922070");
     double longitude = double.parse(long??"75.778885");

    // Create the Google Maps URL
    final Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    // Check if the URL can be launched
    if (await canLaunchUrl(googleMapsUrl)) {
      // Launch the URL
      await launchUrl(googleMapsUrl);
    } else {
      // If the URL cannot be launched, print an error message
      print('Could not open Google Maps.');
    }
  }
}
