import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/dialog/common_dialog.dart';
import 'package:valitag/dialog/imageDialogB.dart';
import 'package:valitag/dialog/image_dialog.dart';
import 'package:valitag/ui/bottomSheet/bottom_sheet.dart';
import 'package:valitag/ui/loginScreen/login_screen.dart';
import 'package:valitag/ui/readyToScanAssetB/readyToScanAssetB.dart';
import 'package:valitag/ui/startScanAssetRouteB/startScanAssetRouteB.dart';
import 'package:valitag/utils/SingleTapEvent.dart';
import 'package:valitag/utils/common_widget.dart';
import 'package:valitag/utils/gox.dart';

import '../../constants/text/app_text.dart';
import '../../providers/imageDialogProvider.dart';
import '../../providers/scanAsset_provider.dart';
import '../fullScreen/image_fullscreen.dart';

class StartScanAsset extends StatefulWidget {

  const StartScanAsset({super.key});

  @override
  State<StartScanAsset> createState() => _StartScanAssetState();
}

class _StartScanAssetState extends State<StartScanAsset> {
  final List<IconData> icons = const [
    Icons.message,
    Icons.call,
    Icons.mail,
    Icons.notifications,
    Icons.settings,
  ];
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  double _sheetPosition = 0.5;
  final double _dragSensitivity = 600;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startFunc();
  }

  startFunc() {
    Future.microtask(() {
      context.read<ScanAssetProvider>().emptyFunc();
      // context.read<ScanAssetProvider>().assetApi();
    });
  }



  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Consumer<ScanAssetProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Color(0xffFFFFFF),

          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    const Text(
                      AppText.routeA ,
                      style: TextStyle(
                        fontFamily: FontFamily.neueMedium,
                        color: Color(0xff007FC5),
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 40,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 25, width: 25,
                            child: Image.asset(AppImages.startScanLocationPinIcon)
                        ),
                        const SizedBox(width: 10,),

                        Column(
                          children: [
//Location
                            GestureDetector(
                              onTap : () {
                                // GoX.goPush(GoogleMap());
                                // mDialog(context, CommonImageDialogB(title: "457 Next Avenue",));
                              },
                              child: const Text(
                                // value.
                                AppText.startScanAddress ,
                                style: TextStyle(
                                  fontFamily: FontFamily.neueMedium,
                                  color: Color(0xff007FC5),
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            Container(
                              height: 2, width: MediaQuery.of(context).size.width *0.55,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Container(
                            height: 20, width: 20,
                            child: Image.asset(AppImages.startScanClockIcon)),
                        const SizedBox(width: 10,),
                        const Text(
                          // value.
                          AppText.startScanInspectedTime ,
                          style: TextStyle(
                            fontFamily: FontFamily.neueLight,
                            color: Color(0xff434343),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

        //Aquarium Image
                    GestureDetector(
                      onTap: () {
                        GoX.goPush(ImageFullScreen(imagePath: AppImages.aquariumImage,));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height /4 , width: MediaQuery.of(context).size.width /1.3 ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.red,
                        ),
                        child: ClipRRect(child: Image.asset(AppImages.aquariumImage)),
                        // value.
                        // ?  ClipRRect(child: Image.asset(AppImages.aquariumImage))
                        // :

                      ),
                    ),

                    const SizedBox(height: 20,),

                    const Text(
                      AppText.startScanOnTime ,
                      style: TextStyle(
                        fontFamily: FontFamily.neueMedium,
                        color: Color(0xff20CB0E),
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
               CustomBottomSheet(fromScreen: "Scheduled",),
            ],
          ),
        );
      }
    );
  }

}
