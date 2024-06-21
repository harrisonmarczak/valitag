
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:valitag/constants/text/app_text.dart';

import '../constants/appColors.dart';
import '../constants/fontFamily.dart';
import '../main.dart';
import '../ui/loginScreen/login_screen.dart';
import 'navigator_service.dart';


void showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      //message to show toast
      toastLength: Toast.LENGTH_LONG,
      //duration for message to show
      gravity: ToastGravity.CENTER,
      //where you want to show, top, bottom
      timeInSecForIosWeb: 1,
      //for iOS only
      backgroundColor: AppColors.blackColor,
      //background Color for message
      textColor: AppColors.whiteColor,
      //message text color
      fontSize: 16.0 //message font size
  );
}

showLoader(context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: const Color(0x00ffffff),
    context: context,
    builder: (context) {
      return const WillPopScope(
        onWillPop: null,
        child: SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.blackColor),
            ),
          ),
        ),
      );
    },
  );
}

/*showLoader(context) {
  showDialog(
    barrierDismissible: false,
    //barrierColor: AppColors.loderColor,
    context: context,
    builder: (context) {
      return const WillPopScope(
        onWillPop: null,
        child: SizedBox(
          height: 60,
            width: 60,
            child: CircularProgressIndicator()),
      );
    },
  );
}*/

Future<void> dialog(BuildContext context, String message,
    {header, onTap, onTap2}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: const Text(AppText.appTitle),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Align(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextButton(
                    onPressed: onTap ??
                            () {
                          Navigator.of(context).pop();
                        },
                    child: const Text(
                      'MESSAGE',
                      style: TextStyle(
                          color: AppColors.whiteColor ,
                          fontSize: 16,
                          fontFamily: FontFamily.neueMedium ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextButton(
                    onPressed: onTap ??
                            () {
                          Navigator.of(context).pop();
                        },
                    child: const Text('Continue',
                        style: TextStyle(
                            color: AppColors.themeColor,
                            fontSize: 16,
                            fontFamily: FontFamily.neueMedium)),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

internetConnectionDialog() {
  var context = NavigationService.navigatorKey.currentContext;
  Widget okButton = InkWell(
    onTap: () {
      Navigator.pop(context!);
    },
    child: Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text("OK",
            style: TextStyle(
                fontSize: 20,
                color: AppColors.whiteColor,
                fontFamily: FontFamily.neueMedium)),
      ),
    ),
  );
  Dialog alert = Dialog(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    insetPadding: EdgeInsets.zero,
    child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context!).cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Lottie.asset(
                'asset/no_internet.json',
                repeat: true,
                fit: BoxFit.fill,
              ),
            ),
            Text(
                "No Internet Connenction",
              style: TextStyle(
                fontFamily: FontFamily.neueMedium,
                color: Color(0xff0070C7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            okButton
          ],
        )),
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future? _dialog;

checkAndShowDialog() async {
  if (_dialog == null) {
    _dialog = internetConnectionDialog();
    await _dialog;
    _dialog = null;
  } else {
    print(">>>>>>>>>>>>");
  }

}


errorDialog(BuildContext context, {required String title, Function()? onTap}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              //  color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppText.appTitle,
                        style: TextStyle(
                            fontSize: 20, fontFamily: FontFamily.neueMedium)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16, fontFamily: FontFamily.neueMedium))),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 25),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text("OK",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: FontFamily.neueMedium)),
                  ),
                ),
              ],
            )),
      );
    },
  );
}

/*showSnackBar(BuildContext context, msg, {Function()? function}) {
  final snackBar = SnackBar(
    content: Text(msg ?? ""),
    dismissDirection: DismissDirection.up,
    action: SnackBarAction(
      label: '',
      onPressed: function ??
              () {
            // Some code to undo the change.
          },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}*/

showSnackBar(msg,
    {bool isError = true,
      bool isTop = true,
      int? duration,
      Function()? onDismiss}) {
  var context = NavigationService.navigatorKey.currentContext;
  Flushbar(
    backgroundColor: isError ? AppColors.redColor : AppColors.themeColor,
    flushbarPosition: isTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.GROUNDED,
    title: null,
    message: msg,
    messageText: Text(
      msg,
      style: TextStyle(
          fontSize: 16.0,
          color: isError ? AppColors.whiteColor : AppColors.whiteColor),
    ),
    onStatusChanged: (status) {
      if (FlushbarStatus.DISMISSED == status) {
        if (onDismiss != null) {
          onDismiss();
        }
      }
    },
    duration: Duration(seconds: duration ?? 2),
    isDismissible: true,
  ).show(context!);
}






dataRemove(BuildContext context) {
  // sp!.clearImportantKeys();
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
          (route) => false);
}
