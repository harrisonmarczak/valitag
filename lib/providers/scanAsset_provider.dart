

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valitag/main.dart';
import 'package:valitag/ui/loginScreen/login_screen.dart';
import 'package:valitag/utils/gox.dart';
import 'package:valitag/utils/shared_preferences.dart';
import 'package:valitag/utils/show_dialog.dart';

import '../api_services/api_base_helper.dart';
import '../api_services/api_config.dart';
import '../constants/text/app_text.dart';
import '../model/productSave_model.dart';

class ScanAssetProvider with ChangeNotifier {

  XFile? image;
  List<XFile?>? allImages = [];

  TextEditingController notesCont = TextEditingController();
  String notesText = AppText.notesText;
  String notesHeading = "Note: ";


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
    if(notesCont.text.isNotEmpty) {
      if(notesCont.text.toString().trim().isNotEmpty) {
        notesText = notesCont.text;
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
    if(checkVal){
      sp?.clearImportantKeys();
    }else{
      sp?.clear();
    }

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
          "product_id" : "1",
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

          // GoX.goPushRemoveUntil(const ReadyToScan());
        }
      }
  }

  Future<dynamic>uploadInspectionApi(int routeId,int assetId,String note) async {
    final response = await ApiBaseHelper().postApiCall(true,uploadInspection(routeId,assetId,note),null);
    print("Route details Api hit 2:: ");
    return response;
  }

}