import 'package:flutter/material.dart';
import 'package:valitag/utils/navigator_service.dart';



class GoX {

  static Future<T?> goPush<T extends Object?>(Widget page) {
    var context = NavigationService.navigatorKey.currentContext;
    return Navigator.push(context!, MaterialPageRoute(builder: (context) => page));
  }

  static void goReplace(Widget page) {
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.pushReplacement(
        context!, MaterialPageRoute(builder: (context) => page));
  }

  static void goPushRemoveUntil(Widget page) {
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.pushAndRemoveUntil(context!,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }
  static void goPushRemoveUntilRoute(Widget page) {
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.pushAndRemoveUntil(context!,
        MaterialPageRoute(builder: (context) => page), (route) => route.isFirst);
  }

  static void goPushRemoveUntilRoute2(Widget page) {
    var context = NavigationService.navigatorKey.currentContext;
  //  Navigator.;
  }

  static void goPop() {
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.pop(context!);
  }

  static void popWith<T extends Object?>([ T? result ]) {
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.pop(context!, result);
  }

/*static void goPopUntil(Widget page){
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.popUntil(context!, (route) => true);
  }*/
}
