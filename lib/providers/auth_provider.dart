import 'package:flutter/cupertino.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:valitag/ui/readyToScan/ready_to_scan.dart';
import 'package:valitag/utils/show_dialog.dart';

import '../api_services/api_base_helper.dart';
import '../api_services/api_config.dart';
import '../main.dart';
import '../model/auth_model.dart';
import '../model/nfc_login_model.dart';
import '../utils/gox.dart';
import '../utils/navigator_service.dart';
import '../utils/shared_preferences.dart';

class AuthProvider with ChangeNotifier {

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();



  bool validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return false;
    }
    return true;
  }

  loginApi() async
  {
    if(loginEmailController.text.isEmpty)
      {
          showSnackBar("Please enter Email");
      }
    else if(loginPassController.text.isEmpty)
      {
        showSnackBar("Please enter Password");
      }
    else if(!validateEmail(loginEmailController.text))
      {
        showSnackBar("Please enter correct Email ");
      }
    else
      {
        print("Login Api hit 1:: ");
        Map<String, String> body = {
          "email" : loginEmailController.text,
          "password" : loginPassController.text,
        };

        var response = await ApiBaseHelper().postApiCall(true, login, body);
        print("Login Api hit 2:: ");

        AuthModel model = AuthModel.fromJson(response);
        print('model ---  > ${model}');
        // GoX.goPush(const DashboardScreen());
        if (model.status == true)
        {
          saveUserDetails();
          sp?.putString(SpUtil.ACCESS_TOKEN, model.data?.token.toString() ?? "");

          print("Token is :: ${sp?.getString(SpUtil.ACCESS_TOKEN)}");

          loginEmailController.clear();
          loginPassController.clear();

          GoX.goPushRemoveUntil(const ReadyToScan());
        }
      }
  }

  getUserDetails({checkVal}) {
    if(checkVal) {
      loginEmailController.text = sp?.getString(SpUtil.EMAIL) ?? "";
      loginPassController.text = sp?.getString(SpUtil.PASSWORD) ?? "";
      notifyListeners();
    }
  }

  saveUserDetails() {
    sp?.putString(SpUtil.EMAIL, loginEmailController.text ) ?? "";
    sp?.putString(SpUtil.PASSWORD, loginPassController.text) ?? "";

  }


  callApi(String identifierHash) async
  {
      print("Login Api hit 1:: ");
      Map<String, String> body = {
        "nfcid" : identifierHash,
      };

      var response = await ApiBaseHelper().postApiCall(true, nfclogin, body);

      NFCLoginModel model = NFCLoginModel.fromJson(response);
      print('model ---  > ${model.data?.nfcid.toString()}');
      // GoX.goPush(const DashboardScreen());
      if (model.status == true)
      {
        // saveUserDetails();
        print('Token 123--- > ${sp!.getString(SpUtil.nfcId)}');
        sp?.putString(SpUtil.ACCESS_TOKEN, model.data?.token.toString() ?? "");
        sp?.putString(SpUtil.userId, model.data?.id.toString() ?? "");
        sp?.putString(SpUtil.nfcId, model.data?.nfcid.toString() ?? "");
        print('Token 12--- > ${sp!.getString(SpUtil.nfcId)}');

        loginEmailController.clear();
        loginPassController.clear();
// Stop Session
        NfcManager.instance.stopSession();
        GoX.goPushRemoveUntil(const ReadyToScan());
      }
  }

}