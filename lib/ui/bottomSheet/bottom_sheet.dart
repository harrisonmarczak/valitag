import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/dialog/common_dialog.dart';
import 'package:valitag/ui/bottomSheet/grabber.dart';
import 'package:valitag/ui/loginScreen/login_screen.dart';
import 'package:valitag/utils/SingleTapEvent.dart';
import 'package:valitag/utils/common_widget.dart';
import 'package:valitag/utils/gox.dart';

import '../../constants/imageText/app_images.dart';
import '../../dialog/image_dialog.dart';
import '../../providers/imageDialogProvider.dart';
import '../../providers/scanAsset_provider.dart';
import '../readyToScanAsset1/readyToScanAsset1.dart';
import '../readyToScanAssetNotification/readyToScanAssetNotification.dart';

class CustomBottomSheet extends StatefulWidget {
  String fromScreen;
  CustomBottomSheet({super.key, required this.fromScreen});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {

  double _sheetPosition = 0.3;
  final double _dragSensitivity = 100;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // allImages = [];
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // return buildSheet(),
    return Consumer<ScanAssetProvider>(
      builder: (context, value, child) {
        return DraggableScrollableSheet(
           minChildSize: 0.3,
           initialChildSize: widget.fromScreen == "Unscheduled" ? 0.35 : 0.4,
           maxChildSize: 0.5,
           builder: (context, scrollcontroller) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              // color: Colors.red,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff007FC5), // Start color
                  Color(0xff0070C7), // End color
                ],
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollcontroller,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 5),
                    width: 30, height: 3,
        
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: [
        
        
                      const SizedBox(height: 30,),
        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
//AddNotesButton
                          GestureDetector(
                            onTap : () {
                              if( value.notesText.isNotEmpty) {
                                  value.notesCont.text =  value.notesText;
                                }
                              mDialog(context, const CommonDialog(
                                title: "Add Notes",
                              ));
                            },
                            child: Container(
                              height: 50, width: MediaQuery.of(context).size.width/2.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0x33000000)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 20, width : 20,
                                      child: Image.asset(AppImages.startScanDocIcon)
                                  ),
        
                                  const SizedBox(width: 10,),
        
                                  const Text(
                                    AppText.startScanAddNotes ,
                                    style: TextStyle(
                                      fontFamily: FontFamily.neueLight,
                                      color: Color(0xffFFFFFF),
                                      fontSize: 14,
                                    ),
                                  ),
        
                                ],
                              ),
                            ),
                          ),

//AddPhotosButton
                          SingleTapEvent(
                            onTap: () {
                              // CommonImageDialog
                              mDialog(context, const CommonImageDialog(
                                title: "Add Photos",
                                // positiveTap: () => getImageData(),
                              ));
                            },
        
                            child: Container(
                              height: 50, width: MediaQuery.of(context).size.width/2.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0x33000000)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 20, width : 20,
                                      child: Image.asset(AppImages.startScanCameraIcon)
                                  ),
        
                                  const SizedBox(width: 10,),
        
                                  const Text(
                                    AppText.startScanAttachPhotos ,
                                    style: TextStyle(
                                      fontFamily: FontFamily.neueLight,
                                      color: Color(0xffFFFFFF),
                                      fontSize: 14,
                                    ),
                                  ),
        
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20,),

 //Note Text
                      value.notesText.isNotEmpty
                      ? Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ReadMoreText(
                          '${value.notesHeading}${value.notesText}',
                          trimMode: TrimMode.Line,
                          trimLines: 3,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.neueLight,
                            color: Color(0xffFFFFFF),
                          ),
                          textAlign: TextAlign.start,
                          colorClickableText: const Color(0xff000000),
                          trimCollapsedText: ' Read more',
                          trimExpandedText: ' Read less',
                          moreStyle: const TextStyle(fontSize: 14, color: Color(0xff000000), fontWeight: FontWeight.bold),
                          lessStyle: const TextStyle(fontSize: 14, color: Color(0xff000000), fontWeight: FontWeight.bold),
                          annotations: [
                            Annotation(
                              regExp: RegExp("Note: "),
                              spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
                                text: text,
                                style: textStyle?.copyWith(color: const Color(0xffFFFFFF), fontSize: 14, fontFamily: FontFamily.neueMedium,),
                              ),
                            ),
                          ],
                        ),
                      )
                      : SizedBox(),

                      // SizedBox(height: 10,),
                      (value.allImages ?? []).isNotEmpty
                       ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
                              child: Text(
                                "Photos: ",
                                style: TextStyle(
                                  fontFamily: FontFamily.neueBold,
                                  color: Color(0xffFFFFFF),
                                  fontSize: 14,
                                ),
                              ),
                          ),

                          Container(
                            height: 100,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width*0.9 ,
                            child: ListView.builder(
                              itemCount: value.allImages?.length ?? 0,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          height: 90, width: 90,
                                          color: Colors.yellow,
                                          child: Image.file(File(value.allImages![index]?.path ?? ''), fit: BoxFit.cover,),
                                        ),
                                      ),
                                      Positioned(
                                        top:-2,
                                        right :-6,
                                        child: GestureDetector(
                                          onTap : () {
                                            value.deleteImage(index);
                                          },
                                          child: Container(
                                            height: 30, width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(color: Color(0xff0070C7), width: 3),
                                              color: Color(0xffF44336),
                                            ),
                                            child: Icon(Icons.close, color: Color(0xffEEEEEE),)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
                      : SizedBox(),
        
                      const SizedBox(height: 20,),
        
//SubmitButton
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.2,
                        height: MediaQuery.of(context).size.width/7.5,
                        child: ElevatedButton(
                          onPressed: () {
                            if(widget.fromScreen == "Unscheduled") {
                                value.emptyFunc();
                                GoX.goPush(const ReadyToScanAssetNotification());
                              }
                            else{
                              // value.productSaveApi();
                              // value.uploadInspectionApi();todo new
                              value.emptyFunc();
                              GoX.goPush(const ReadyToScanAsset1());
                            }
                            // GoX.goPush(const ReadyToScanAsset1());
                            // mDialog(context, CommonDialog(
                            //   title: "Add Notes",
                            // ));
                          },
        
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 20, width : 20,
                                  child: Image.asset(AppImages.startScanUploadIcon)
                              ),
                              const SizedBox(width: 10,),
                              const Text(
                                AppText.startScanSubmit,
                                style: TextStyle(
                                  fontFamily: FontFamily.neueMedium,
                                  color: Color(0xff0070C7),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
        
                      const SizedBox(height: 40,),
 //CancelButton
                      GestureDetector(
                        onTap: () {
                          GoX.goPop();
                          // value.startNFCReading();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                            height: 25, width : 25,
                            child: Image.asset(AppImages.startScanBlockingIcon)
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ),
          );
         }
        );
      }
    );

  }

}
