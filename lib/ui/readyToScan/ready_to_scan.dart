import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfc_manager/nfc_manager.dart';

// import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import 'package:valitag/constants/fontFamily.dart';
import 'package:valitag/constants/imageText/app_images.dart';
import 'package:valitag/constants/text/app_text.dart';
import 'package:valitag/utils/common_widget.dart';

import '../../api_services/api_base_helper.dart';
import '../../api_services/api_config.dart';
import '../../main.dart';
import '../../model/nfc_route_scan_model.dart';
import '../../providers/common_provider.dart';
import '../../utils/navigator_service.dart';
import '../../utils/shared_preferences.dart';
import '../../utils/show_dialog.dart';

class ReadyToScan extends StatefulWidget {
  final String? address;

  const ReadyToScan({super.key, this.address});

  @override
  State<ReadyToScan> createState() => _ReadyToScanState();
}

class _ReadyToScanState extends State<ReadyToScan> {
  String? address = '';
  List<dynamic> records = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    address = widget.address;
    Future.delayed(const Duration(seconds: 3), () async {
      initNFC();
    });
  }

  Future<void> initNFC() async {
    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;
    try {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        Map<String, dynamic> rawData = _extractRawData(tag);
        print('rawData ----  > ${rawData.keys.isNotEmpty}');
       if(rawData.keys.isNotEmpty){
         setData(rawData);
       }else{
         showSnackBar('Not Data Found...');
       }
      });

    } catch (e) {
      //myCustomErrorToast(e.toString(), context);
    }
  }

  Map<String, String> _extractRawData(NfcTag tag) {
  // String _extractRawData(NfcTag tag) {
    var ndef = Ndef.from(tag);
    if (ndef == null || ndef.cachedMessage == null) return {};
    final Map<dynamic, dynamic> ndef1 = tag.data['ndef'] ?? {};
    List<int> identifierValue = ndef1['identifier'] ?? [];
    String identifierHash = identifierValue.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(':');

    String result = '';
    Map<String, String> data = {
      'image': '',
      'route_name': '',
      'address': '',
      'nfc_id': '${sp!.getString(SpUtil.nfcId)}',
      'address_nfc_id': identifierHash,
    };
    int i = 0;
    for (var record in ndef.cachedMessage!.records) {

      if (record.typeNameFormat == NdefTypeNameFormat.nfcWellknown) {
        if (record.type.length == 1 && record.type[0] == 0x54) {
          // This is a Text record
          var payload = record.payload!;
          int languageCodeLength = payload[0];
          String text = utf8.decode(payload.sublist(1 + languageCodeLength));
          result += 'Text: $text\n';
          data['route_name'] = text;
        } else if (record.type.length == 1 && record.type[0] == 0x55) {
          // This is a URL record
          var prefixMap = {
            0x00: '',
            0x01: 'http://www.',
            0x02: 'https://www.',
            0x03: 'http://',
            0x04: 'https://',
            0x1F: 'geo:',
            // Add more prefixes as needed
          };
          var payload = record.payload!;
          int prefix = payload[0];
          String url = prefixMap[prefix]! + utf8.decode(payload.sublist(1));
          result += 'URL: $url\n';
          if(i == 0){
            data['image'] = url;
          }else{
            var uri1 = Uri.parse(url);
            String query = uri1.query;
            String queryWithoutQ = query.substring(2); // Remove 'q=' from the query
            String decodedAddress = Uri.decodeComponent(queryWithoutQ.replaceAll('+', ' '));
            data['address'] = decodedAddress;
          }
          print('record --- > ${url}');
        }
      } else {
        result +=
            'Type: ${record.type}, Payload: ${utf8.decode(record.payload!)}\n';
      }
      i++;
    }
    print('data -- > $data');
    return data;
  }

  String? parseUriRecord(NdefRecord record) {
    const prefixMap = [
      '',
      'http://www.',
      'https://www.',
      'http://',
      'https://',
      'tel:',
      'mailto:',
      'ftp://anonymous:anonymous@',
      'ftp://ftp.',
      'ftps://',
      'sftp://',
      'smb://',
      'nfs://',
      'ftp://',
      'dav://',
      'news:',
      'telnet://',
      'imap:',
      'rtsp://',
      'urn:',
      'pop:',
      'sip:',
      'sips:',
      'tftp:',
      'btspp://',
      'btl2cap://',
      'btgoep://',
      'tcpobex://',
      'irdaobex://',
      'file://',
      'urn:epc:id:',
      'urn:epc:tag:',
      'urn:epc:pat:',
      'urn:epc:raw:',
      'urn:epc:',
      'urn:nfc:',
    ];
    int prefixIndex = record.payload[0];
    String prefix =
        (prefixIndex < prefixMap.length) ? prefixMap[prefixIndex] : '';
    String uri = prefix + String.fromCharCodes(record.payload.sublist(1));
    return uri;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<CommonProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: customAppBar(
            context: context, showLeadingIcon: false, showMenuButton: true),
        body: SafeArea(
          child: Container(
            width: width,
            child: Stack(
              // fit: StackFit.loose,
              children: [
                //RouteA Text
                //           Align(
                //             alignment: Alignment.topCenter,
                //             child: Container(
                //               margin: const EdgeInsets.only(top: 20),
                //               child: const Text(
                //                 AppText.routeA ,
                //               style: TextStyle(
                //                 fontFamily: FontFamily.neueLight,
                //                 color: Color(0xff007FC5),
                //                 fontSize: 14,
                //               ),
                //               ),
                //             ),
                //           ),

                Container(
                  height: height,
                  width: width,
                  child: Image.asset(AppImages.readyToScanBack),
                ),

                Positioned(
                  top: 10,
                  left: 100,
                  child: Container(
                    alignment: Alignment.center,
                    height: height / 2,
                    width: width / 2,
                    child: Opacity(
                        opacity: 0.3,
                        child: Image.asset(AppImages.readyToScanWifi)),
                  ),
                ),

                Positioned(
                  top: 200,
                  left: 140,
                  child: GestureDetector(
                    onTap: () {
                      // GoX.goPush(const StartScanAsset());
                    },
                    child: Container(
                      height: height * 0.4,
                      width: width * 0.4,
                      child: Image.asset(AppImages.readyToScanNfc),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 24,
                  left: width * 0.08,
                  child: Column(
                    children: [
                      address != null && address != ''
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Color(0xffEEF1F4),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Container(
                                      height: 25,
                                      width: 25,
                                      child:
                                          Image.asset(AppImages.greenTickIcon)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Inspection for ${address} has been sent',
                                          style: const TextStyle(
                                            fontFamily: FontFamily.neueLight,
                                            color: Color(0xff000000),
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              child: const Text(
                                AppText.readyToScan,
                                style: TextStyle(
                                  fontFamily: FontFamily.neueMedium,
                                  color: Color(0xff000000),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            // setState(() {
                            address = '';
                            // });
                            value.routeListApi();
                            // mDialog(context, RouteListDialog(title: "Route List",));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff007FC5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 18,
                                  width: 18,
                                  child:
                                      Image.asset(AppImages.readyToScanButon)),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                AppText.viewRouteList,
                                style: TextStyle(
                                  fontFamily: FontFamily.neueLight,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  setData(Map<String, dynamic> rawData) async {
    final nfcId = '${sp!.getString(SpUtil.nfcId)}';

    Map<String, String> body = {
      "nfc_id": nfcId,
      "route_name": nfcId,
      "address": nfcId,
      "image": nfcId,
    };

    print('rawData-- >${rawData}');
    print("Login Api hit 1::--->  ${body} rawData-- >${rawData}");
    var response = await ApiBaseHelper().postApiCall(true, nfcRouteCreate, rawData);

    // print('response ---  > ${response}');
    // NFCRouteScanModel model = NFCRouteScanModel.fromJson(response);
    // print('model ---  > ${model}');
//     // GoX.goPush(const DashboardScreen());
//     if (model.status == true)
//     {
//       showToastMessage('Successfully Scan');
//       // saveUserDetails();
//       sp?.putString(SpUtil.ACCESS_TOKEN, model.data?.token.toString() ?? "");
//       sp?.putString(SpUtil.userId, model.data?.id.toString() ?? "");
//       sp?.putString(SpUtil.nfcId, model.data?.nfcid.toString() ?? "");
//
//       loginEmailController.clear();
//       loginPassController.clear();
// // Stop Session
//       NfcManager.instance.stopSession();
//       GoX.goPushRemoveUntil(const ReadyToScan());
//     }
  }
}
