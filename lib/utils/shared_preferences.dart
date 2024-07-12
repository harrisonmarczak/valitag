import 'dart:async';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigator_service.dart';



class SpUtil {
  //pref- value
  static const String ACCESS_TOKEN = "access_token";
  static const String REMEBER_ME = "remeber_me";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";
  static const String userId = "userId";
  static const String nfcId = "nfcId";



  static SpUtil? _instance;

  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  static SharedPreferences? _spf;

  SpUtil._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
    //_spf?.reload();
  }



  static Future<SpUtil> getInstance() async {
    _instance ??=  SpUtil._();
    if (_spf == null) {
      await _instance!._init();
    }
    return _instance!;
  }


  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    return _spf!.getKeys();
  }

  get(String key) {
    return _spf!.get(key);
  }

  getString(String key) {

    return _spf!.getString(key);
  }

  Future<bool> putString(String key, String value) {
    return _spf!.setString(key, value);
  }

  // Future<bool> putStringList(String key, List<String> image) {
  //   return _spf!.setStringList(key, image);
  // }

  bool? getBool(String key) {

    return _spf!.getBool(key);
  }

  Future<bool> putBool(String key, bool value) {

    return _spf!.setBool(key, value);
  }

  int? getInt(String key) {

    return _spf!.getInt(key);
  }

  Future<bool> putInt(String key, int value) {

    return _spf!.setInt(key, value);
  }

  double? getDouble(String key) {

    return _spf!.getDouble(key);
  }

  Future<bool> putDouble(String key, double value) {

    return _spf!.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    return _spf!.getStringList(key);
  }

  Future<bool> putStringList(String key, List<String> value) {

    return _spf!.setStringList(key, value);
  }

  // Future<List<String>> getsStringList(String key) {
  //   List<String>? items  = _spf!.getStringList(key) ;
  //   return items;
  // }

  dynamic getDynamic(String key) {

    return _spf!.get(key);
  }

  Future<bool> remove(String key) {
    return _spf!.remove(key);
  }

  Future<bool> clear() {
    return _spf!.clear();
  }

  clearImportantKeys() {
    remove(ACCESS_TOKEN);
    clearAllProviderData();
  }

  clearAllProviderData(){
    var context = NavigationService.navigatorKey.currentContext;
    Future.microtask(() => {
      // context?.read<AuthProvider>().clean(),
    });
  }
}
