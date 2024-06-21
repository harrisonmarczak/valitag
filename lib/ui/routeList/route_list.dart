import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/model/route_list_modal_client.dart';
import 'package:valitag/providers/common_provider.dart';
import 'package:valitag/ui/readyToScanAsset1/readyToScanAsset1.dart';
import 'package:valitag/utils/gox.dart';

import '../../dialog/imageDialogB.dart';
import '../../model/routeList_model.dart';
import '../../utils/common_widget.dart';



class RouteListDialog extends StatelessWidget {
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
  final int? itemLength;
  List<Inspections>? modeldata;

   RouteListDialog({
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
    this.itemLength=7,
    this.modeldata,
  });



  @override
  Widget build(BuildContext context) {
    return Consumer<CommonProvider>(
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
                          vertical: 16.0, horizontal: 15),
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

                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: modeldata?.length ?? 0,// value.demoRouteList.length,
                            itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: () async {
                                    // Future.microtask(() {
                                    //   value.selectedRouteList(
                                    //       modeldata?.data?[0].id.toString(),
                                    //       // modeldata?.data?[0].address.toString(),
                                    //       // value.formatDateTime(modeldata?.data?[0].datetime).toString()
                                    //     value.demoRouteList[index].address,
                                    //     value.formatDateTime(value.demoRouteList[index].inspectedTime).toString()
                                    //
                                    //   );
                                    // });

                                    await value.routeDetailsApi(id: modeldata![index].id!);

                                    //mDialog(context, CommonImageDialogB(title: value.demoRouteList[index].address));
                                   // mDialog(context, CommonImageDialogB(title: value.demoRouteList[index].address, inspectedTime: value.demoRouteList[index].inspectedTime ,));
                                  },
                                  child: Row(

                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment : CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 25, width: 25,
                                          child: Image.asset(AppImages.startScanLocationPinIcon)
                                      ),
                                      const SizedBox(width: 5,),
                                       Expanded(
                                         child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                             Text(
                                              // value.demoRouteList[index].address ,
                                                 modeldata?[index].additionalInfo ?? "",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontFamily: FontFamily.neueMedium,
                                                    color: Color(0xff000000),
                                                    //fontWeight: FontWeight.w600,
                                                    fontSize: 14
                                                )
                                            ),
                                             Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               children: [
                                         //StartTime
                                               value.demoRouteList[index].startTime.isNotEmpty
                                                 ? Text(
                                                    // value.startDateTimeConvert(value.demoRouteList[index].startTime),
                                                    value.startDateTimeConvert("2024-04-16 09:30:00"),
                                                     // value.formatDateTime(modeldata?.data?[index].datetime) ?? "" ,
                                         
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontFamily: FontFamily.neueLight,
                                                        color: Color(0xff000000),
                                                        //fontWeight: FontWeight.w600,
                                                        fontSize: 11
                                                    )
                                                 )
                                                 : SizedBox(width: MediaQuery.of(context).size.width *0.17 ,),
                                         
                                         //EndTime
                                               value.demoRouteList[index].endTime.isNotEmpty
                                                 ? Text(
                                                   // " - ${value.startDateTimeConvert(value.demoRouteList[index].endTime)}",
                                                   " - ${value.startDateTimeConvert("2024-04-16 10:00:00")}",
                                                     // value.formatDateTime(modeldata?.data?[index].datetime) ?? "" ,
                                         
                                                     textAlign: TextAlign.start,
                                                     style: const TextStyle(
                                                         fontFamily: FontFamily.neueLight,
                                                         color: Color(0xff000000),
                                                         //fontWeight: FontWeight.w600,
                                                         fontSize: 11
                                                     )
                                                 )
                                                 : SizedBox(),
                                         
                                                 const SizedBox(width: 20,),
                                         
                                         //InspectedTime
                                                /* value.demoRouteList[index].inspectedTime == ""
                                                 ? SizedBox()
                                                 : Text(
                                                     "Inspected at ${value.startDateTimeConvert(value.demoRouteList[index].inspectedTime)}",
                                                     // value.formatDateTime(modeldata?.data?[index].datetime) ?? "" ,
                                         
                                                     textAlign: TextAlign.center,
                                                     style: const TextStyle(
                                                         fontFamily: FontFamily.neueLight,
                                                         color: Color(0xff000000),
                                                         //fontWeight: FontWeight.w600,
                                                         fontSize: 11
                                                     )
                                                 ),*/
                                         
                                                 const SizedBox(width: 20,),
                                         
                                               ],
                                             ),
                                            value.demoRouteList[index].inspectedTime == ""
                                                ? SizedBox()
                                                : Text(
                                                "Inspected at ${value.startDateTimeConvert("2024-04-16 10:40:00")}",
                                                // "Inspected at ${value.startDateTimeConvert(value.demoRouteList[index].inspectedTime)}",
                                                // value.formatDateTime(modeldata?.data?[index].datetime) ?? "" ,

                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontFamily: FontFamily.neueLight,
                                                    color: Color(0xff000000),
                                                    //fontWeight: FontWeight.w600,
                                                    fontSize: 11
                                                )
                                            ),
                                          ],
                                                                               ),
                                       ),

                             // //InspectedTime
                        //                  Text(
                     //                      "Inspected at ${value.startDateTimeConvert(value.demoRouteList[index].inspectedTime)}",
                     //                      // value.formatDateTime(modeldata?.data?[index].datetime) ?? "" ,
                     //
                     //                      textAlign: TextAlign.center,
                     //                      style: const TextStyle(
                     //                          fontFamily: FontFamily.neueLight,
                     //                          color: Color(0xff000000),
                     //                          //fontWeight: FontWeight.w600,
                     //                          fontSize: 11
                     //                      )
                     //                  ),

                                      // SizedBox(width: MediaQuery.of(context).size.width * 0.05 ,),

                                  //Schedule-Unschedule
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                        // height: 25, width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.white,
                                          border: Border.all(
                                            color: Color(0xff858686), // Border color
                                            width: 1.0, // Border width
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("Unscheduled",
                                            // value.dateTimeCompare(
                                            //     value.demoRouteList[index].startTime,
                                            //     value.demoRouteList[index].endTime,
                                            //     value.demoRouteList[index].inspectedTime,
                                            //     index,
                                            // ) == "Unscheduled"
                                            //   ? "Unscheduled"
                                            //   : value.dateTimeCompare(
                                            //       value.demoRouteList[index].startTime,
                                            //       value.demoRouteList[index].endTime,
                                            //       value.demoRouteList[index].inspectedTime,
                                            //        index,
                                            //     ) == "Scheduled"
                                            //     ? "Scheduled"
                                            //     : value.dateTimeCompare(
                                            //         value.demoRouteList[index].startTime,
                                            //         value.demoRouteList[index].endTime,
                                            //         value.demoRouteList[index].inspectedTime,
                                            //          index,
                                            //       ) == "Inspected"
                                            //       ? "Inspected"
                                            //       : value.dateTimeCompare(
                                            //           value.demoRouteList[index].startTime,
                                            //           value.demoRouteList[index].endTime,
                                            //           value.demoRouteList[index].inspectedTime,
                                            //           index,
                                            //         ) == "Late"
                                            //         ? "Late"
                                            //         :  value.dateTimeCompare(
                                            //               value.demoRouteList[index].startTime,
                                            //               value.demoRouteList[index].endTime,
                                            //               value.demoRouteList[index].inspectedTime,
                                            //               index,
                                            //             ) == "Early"
                                            //           ? "Early"
                                            //           : "Duplicate",
                                            // AppText.schedule ,
                                            style: TextStyle(
                                              fontFamily: FontFamily.neueMedium,
                                              color: index == 1
                                                  ? Color(0xff20CB0E)
                                                  : index == 2
                                                    ? Color(0xff2F71F5)
                                                    : index == 3
                                                       ? Color(0xffFF0000)
                                                       : index == 4
                                                          ? Color(0xff13A104)
                                                          : index == 5
                                                            ? Color(0xff13A104)
                                                            : index == 6
                                                              ? Color(0xff5DD850)
                                                              : Color(0xffACACAC),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                index+1 == modeldata?.length  //modeldata?.data?.length
                                ? const SizedBox()
                                : Container(
                                  width: MediaQuery.of(context).size.width ,
                                  height: 0.4,
                                 color: Colors.grey,
                                )
                              ],
                            );
                          }
                          ),


                          //
                          // const SizedBox(height: 10),
                          //
                          // Container(
                          //     height: 200,
                          //     width: MediaQuery.of(context).size.width*0.8,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: Color(0xffBCBCBC), // Border color
                          //           width: 2, // Border width
                          //         ),
                          //         borderRadius: BorderRadius.circular(10)
                          //     ),
                          //     child: Image.asset(AppImages.aquariumImage)
                          // ),
                          //
                          // SizedBox(height: 10,),
                          //
                          // Text(
                          //     AppText.assetInstruction,
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         fontFamily: FontFamily.neueLight,
                          //         color: Color(0xff000000),
                          //         //fontWeight: FontWeight.w600,
                          //         fontSize: 13
                          //     )
                          // ),
                          //
                          // SizedBox(height: 20,),
                          //
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //
                          //     Container(
                          //       height: 50, width: MediaQuery.of(context).size.width/3,
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(30),
                          //           color: Color(0xff858686)
                          //       ),
                          //       child: Center(
                          //         child: const Text(
                          //           AppText.close ,
                          //           style: TextStyle(
                          //             fontFamily: FontFamily.neueMedium,
                          //             color: Color(0xffFFFFFF),
                          //             fontSize: 15,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //
                          //     GestureDetector(
                          //       onTap: () {
                          //         // GoX.goPush(ReadyToScanAsset1());
                          //       },
                          //       child: Container(
                          //         height: 50, width: MediaQuery.of(context).size.width/3,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(30),
                          //             color: Color(0xff007FC5)
                          //         ),
                          //         child: Center(
                          //           child: const Text(
                          //             AppText.map ,
                          //             style: TextStyle(
                          //               fontFamily: FontFamily.neueMedium,
                          //               color: Color(0xffFFFFFF),
                          //               fontSize: 15,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          //
                          // const SizedBox(height: 35),
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
