
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valitag/utils/connectivity.dart';
import '../main.dart';

import '../ui/loginScreen/login_screen.dart';
import '../utils/gox.dart';
import '../utils/navigator_service.dart';
import '../utils/shared_preferences.dart';
import '../utils/show_dialog.dart';
import 'api_config.dart';
import 'package:http/http.dart' as http;

import 'app_exception.dart';

class ApiBaseHelper {
  http.Client? client = http.Client();

  Future<dynamic> getApiCall(String url, {bool? isShow = false, bool? isPopup = true}) async {
    bool isNetActive = await ConnectionStatus.getInstance().checkConnection();
    var context = NavigationService.navigatorKey.currentContext;

    if (isNetActive) {
      var responseJson;
      if (isShow == true) {
        showLoader(context);
      }

      var apiHeader = {
        authorization: "Bearer ${sp!.getString(SpUtil.ACCESS_TOKEN)}",
        accept: 'application/json',
        contentType: 'application/json',
      };
      try {
        final response = await http.get(Uri.parse(BASE_URL + url), headers: apiHeader);
        if (isShow == true) {
          Navigator.pop(context!);
        }
        // print("apiHeader=========>>>> $apiHeader");
        print("ApiUrl=========>>>> ${BASE_URL + url}");
        print("apiHeader=========>>>> $apiHeader");
        print("statusCode=========>>>> ${response.statusCode}");
        log("response=========>>>> ${response.body}");


        if (response.statusCode == 401) {
          var res = jsonDecode(response.body);
          // redirectDialog(context!, res['message'] ?? res['error'], "session");
          return;
        } else {
          try {
            responseJson = _returnResponse(response);
            if (isPopup!) {
              if (!responseJson['status']) {
                // showSnackBar(responseJson['message']);
                // errorDialog(context!, title: responseJson['message']);
              }
            }
          } catch (e) {
            // errorDialog(context!, title: "Something went wrong");
          }
        }
      } on SocketException {
        //  showToastMessage("No Internet connection");
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
    } else {
      // checkAndShowDialog();
    }
  }


  Future<dynamic> postApiCall(bool isShow, String url, Map<String, dynamic>? jsonData,
      {bool? isPopup = true}) async {
    var context = NavigationService.navigatorKey.currentContext;

    bool isNetActive = await ConnectionStatus.getInstance().checkConnection();
    // bool isNetActive = await checkConnection2();
    if (isNetActive) {
      if (isShow) {
        showLoader(context);
      }
      dynamic responseJson;
      var apiHeader = {
        authorization: "Bearer ${sp?.getString(SpUtil.ACCESS_TOKEN) ?? ""}",
        accept: 'application/json',
        contentType: 'application/json',
      };
      if (kDebugMode) {
        print("ApiUrl=========>>>> ${BASE_URL + url}");
        print("apiHeader=========>>>> ${apiHeader}");
        // print("apiHeader=========>>>> $apiHeader");
         print("request=========>>>> ${jsonEncode(jsonData)}");
      }


      client = http.Client();
      try {
        final http.Response response = await client!.post(
          Uri.parse(BASE_URL + url),
          headers: apiHeader,
          body: jsonData != null ? jsonEncode(jsonData) : null,
        );
        if (isShow) {
          Navigator.pop(context!);
        }

        if (kDebugMode) {
          print("statusCode=========>>>> ${response.statusCode}");
          log('response=========>>>> ${response.body}');
        }

        if (response.statusCode == 401) {
          // print("Status Code is 1 :: ${response.statusCode}");
          var res = jsonDecode(response.body);
          GoX.goPushRemoveUntil(const LoginScreen());
          showSnackBar(res['message'] ?? res['error']);
          // redirectDialog(context!, res['message'] ?? res['error'], "session");
        }
        else {
          try {
            // print("Status Code is 2:: ${response.statusCode}");
            responseJson = _returnResponse(response);

            if (isPopup!) {
              if (!responseJson['status']) {
                showSnackBar(responseJson['message'], duration: 3);
                // errorDialog(context!, title: responseJson['message']);
              }
            }
          } catch (e) {
            showSnackBar(e.toString());
            // errorDialog(context!, title: "Something went wrong");
          }
        }
      } on SocketException {
        showSnackBar("No Internet connection");
        // showToastMessage("No Internet connection");
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
    } else {
      internetConnectionDialog();
      checkAndShowDialog();
    }
  }

  Future<dynamic> postWithMultipartApi(File? file, String url,
      Map<String,String> jsonData, {String? params}) async
  {
    var context = NavigationService.navigatorKey.currentContext;
    dynamic responseJson;
    bool isNetActive = await ConnectionStatus.getInstance().checkConnection();
    if(isNetActive)
      {
        showLoader(context);
        var apiHeader = {
          authorization : "Bearer ",
          // authorization : "Bearer ${sp?.getString(SpUtil.ACCESS_TOKEN) ?? ""}",
          accept : "*/*",
          contentType: 'application/json',
        };

        if (kDebugMode) {
           print("ApiUrl=========>>>> ${BASE_URL + url}");
           print("apiHeader=========>>>> $apiHeader");
           print("file=========>>>> $file");
           print("request=========>>>> ${jsonEncode(jsonData)}");
        }

        http.ByteStream? stream;
        int? length;

        if(file != null)
        {
           stream = http.ByteStream(file.openRead());
           length = await file.length();
        }
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(BASE_URL + url),
        );

        request.headers.addAll(apiHeader);
        file != null
         ? request.files.add(http.MultipartFile(params ?? "image", stream!, length ?? 0, filename: file.path))
         : null;
        request.fields.addAll(jsonData);

        var response = await request.send();
        var responded = await http.Response.fromStream(response);

        Navigator.pop(context!);
        if (kDebugMode) {
          print("statusCode=========>>>> ${response.statusCode}");
          log("response=========>>>> ${responded.body}");
        }

        if(response.statusCode == 200)
          {
            responseJson = _returnResponse(responded);
          }
        else
          {
            responseJson = _returnResponse(responded);
            errorDialog(context,
                title: responseJson != null
                    ? responseJson['message']
                    : response.statusCode.toString());
          }

      }
    else {
      checkAndShowDialog();
    }
    return responseJson;
  }

  var context = NavigationService.navigatorKey.currentContext;
  Future<dynamic> postWithMultipartListApi(List<Files?>? files, String url,
      Map<String,String> jsonData, {String? params}) async
  {

    dynamic responseJson;
    bool isNetActive = await ConnectionStatus.getInstance().checkConnection();
    if(isNetActive)
    {

      try {
        showLoader(context);
        var apiHeader = {
                authorization : "Bearer ${sp?.getString(SpUtil.ACCESS_TOKEN) ?? ""}",
                accept : "*/*",
                contentType: 'application/json',
              };

        if (kDebugMode) {
                print("ApiUrl=========>>>> ${BASE_URL + url}");
                print("apiHeader=========>>>> $apiHeader");
                print("file=========>>>> $files");
                print("request=========>>>> ${jsonEncode(jsonData)}");
              }

        var request = http.MultipartRequest(
                'POST',
                Uri.parse(BASE_URL + url),
              );
        request.headers.addAll(apiHeader);
        if((files ?? []).isNotEmpty) {
                for (var file in files ?? []) {
                  if (kDebugMode) {
                    print("file=========>>>> ${file!.file}");
                    print("type=========>>>> ${file!.type}");
                  }
                  String fileName = file.file!.path
                      .split("/")
                      .last;
                  var stream = http.ByteStream(file.file!.openRead())..cast();

                  // get file length
                  var length = await file.file!.length(); //imageFile is your image file

                  // multipart that takes file
                  var multipartFileSign = http.MultipartFile(params ?? "image",
                      /*file.type,*/ stream, length, filename: fileName);

                  request.files.add(multipartFileSign);
                }
              }
        request.fields.addAll(jsonData);

        var response = await request.send();
        var responded = await http.Response.fromStream(response);

        Navigator.pop(context!);
        if (kDebugMode) {
                print("statusCode=========>>>> ${response.statusCode}");
                log("response=========>>>> ${responded.body}");
              }

        try {
          if(response.statusCode == 200)
            {
                          responseJson = _returnResponse(responded);}
                        else
                        {
                          responseJson = _returnResponse(responded);
                          errorDialog(context!,
                              title: responseJson != null
                                  ? responseJson['message']
                                  : response.statusCode.toString());
                        }
        } catch (e) {
          showSnackBar(e.toString());
        }
      } on SocketException {
        Navigator.pop(context!);
        //showSnackBar("No Internet connection");
        // showToastMessage("No Internet connection");
        throw FetchDataException('No Internet connection');
      }

    }
    else {
      checkAndShowDialog();
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200 || 422:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}

class Files{
  Files(this.type, this.file);
  String? type;
  File? file;
}