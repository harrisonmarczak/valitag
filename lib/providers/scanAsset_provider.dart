

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:valitag/main.dart';
import 'package:valitag/ui/loginScreen/login_screen.dart';
import 'package:valitag/utils/gox.dart';
import 'package:valitag/utils/shared_preferences.dart';
import 'package:valitag/utils/show_dialog.dart';

import '../api_services/api_base_helper.dart';
import '../api_services/api_config.dart';
import '../constants/text/app_text.dart';
import '../model/productSave_model.dart';
import '../model/product_model.dart';
import '../model/routeList_model.dart';
import '../ui/readyToScan/ready_to_scan.dart';
import '../ui/startScanAsset/start_scan_asset.dart';
import '../ui/startScanAssetRouteB/startScanAssetRouteB.dart';

class ScanAssetProvider with ChangeNotifier {

  XFile? image;
  List<XFile?>? allImages = [];

  TextEditingController notesCont = TextEditingController();
  String notesText = AppText.notesText;
  String notesHeading = "Note: ";
  ProductModel? modal;
  RouteListModel? routeModal;


  // String notesText = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";

  emptyFunc() {
    notesCont.clear();
    notesText = "";
    image = null;
    allImages = [];
    notifyListeners();
  }

  Future<void> getImageData() async {
    print("Image Gallery Function :::");
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null)
    {
      print("Imagges is :: ${image}");
      print("Imagges is :: ${image!.path}");

      notifyListeners();
    }
  }

  Future<void> getImageCameraData() async {
    print("Image Gallery Function :::");
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.camera);
    if(image != null)
    {
      print("Imagges is :: ${image}");
      print("Imagges is :: ${image!.path}");

      notifyListeners();
    }
  }

  String? formatDateTime(String? timeString) {
    print("Time String is :: ${timeString}");

    if((timeString ?? '').isNotEmpty)
    {
      DateTime dateTime = DateTime.parse(timeString!);
      String formattedTime = DateFormat.Hm().format(dateTime);
      print("Format time is :: ${formattedTime}");
      return formattedTime;
    }
    return "";
  }

  saveImages() {
    if(image == null) return;
    allImages?.add(image);
    image = null;
    print("Images lenght :: ${allImages?.length ?? 0}");
    notifyListeners();
  }

  deleteImage(int index) {
    allImages?.removeAt(index);
    notifyListeners();
  }


  saveNotes() {
    if(notesCont.text.isNotEmpty)
    {
      if(notesCont.text.toString().trim().isNotEmpty)
      {
        notesText = notesCont.text;
        // notesCont.clear();
        notifyListeners();
      }
      else
      {
        notesCont.clear();
        notesText = "";
        notifyListeners();
      }

    }
    else
    {
      notesCont.clear();
      notesText = "";
      notifyListeners();
    }
  }

  logout() {
    var checkVal = sp?.getBool(SpUtil.REMEBER_ME) ?? false;
    sp?.clear();
    // if(checkVal){
    //   sp?.clearImportantKeys();
    // }else{
    //   sp?.clear();
    // }
    NfcManager.instance.stopSession();
    GoX.goPushRemoveUntil(LoginScreen());
  }

  assetApi() async {

    Map<String, String> body = {
      "product_id" : "1",
      "description" : notesCont.text,
    };
   var response = await ApiBaseHelper().postApiCall(true, login, body);

    // AssetsModel model = AssetsModel.fromJson(response);

    // if (model.status == true)
    // {
    //   notifyListeners();
    // }

  }

  selectedRouteList(String? routeId, String? address ,String inspectedTime) async {
    String meridiemTime = "am";
    String hours = inspectedTime.split(":")[0];

    if(int.parse(hours) > 12)
    {
      meridiemTime = "pm";
    }
    print("Select Route List API:: --->  $routeId");
    var response = await ApiBaseHelper().getApiCall("$product?route_id=$routeId");
    print("Select Route List API:: ---> $response");

    modal = ProductModel.fromJson(response);

    if(modal?.status == true)
    {
      GoX.goPush(const StartScanAsset());
      // mDialog(context, CommonImageDialogB(title: address,
      //  inspectedTime: inspectedTime, modal: modal, meridiemTime: meridiemTime,));
    }
    // mDialog(context, CommonImageDialogB(title: "457 Next Avenue",));
  }

  productSaveApi() async {

    if(notesCont.text.isEmpty)
      {
        showSnackBar("Please add Notes");
      }
    else if((allImages ?? []).isEmpty) {
        showSnackBar("Please select image");
     }
    else
      {
        Map<String, String> jsonData = {
          "route_id" : "${modal?.data?.route?.id ?? 1}",
          "description" : notesCont.text,
        };

        // var response = await ApiBaseHelper().postApiCall(true, login, body);
        List<Files?> allFiles = [];
        allImages?.forEach((e) {
          // File fileA = File(e!.path);
          allFiles.add(Files(e!.path, File(e.path)));

        });

        var response = await ApiBaseHelper().postWithMultipartListApi(allFiles, productSave, jsonData, params: "image");
        print("Login Api hit 2:: ");

        ProductSaveModel model = ProductSaveModel.fromJson(response);
        // GoX.goPush(const DashboardScreen());
        if (model.status == true)
        {

          print("Enter inside model check :: ");
          notesCont.clear();
          notesText = "";
          allImages = [];
          notifyListeners();
          showSnackBar("Submitted Succesfully");
          // GoX.goPush(const StartScanAssetRouteB());
          //
          GoX.goPushRemoveUntil(ReadyToScan(address: modal?.data?.route?.address ?? '',));
        }
      }
  }

  String amPm(inspectedTime){
    String meridiemTime = "am";
    String hours = inspectedTime.split(":")[0];

    if(int.parse(hours) > 12)
    {
      meridiemTime = "pm";
    }
    return meridiemTime;
  }

}