/// define HARoutePath class: has 3 paras
/// page name, page parameters  and  widget
///
/// For each page, define a named constructor,

import 'package:dictionary_flutter/app/modules/home/home_page.dart';
import 'package:dictionary_flutter/app/modules/login/login_page.dart';
import 'package:dictionary_flutter/app/modules/login/splash_page.dart';
import 'package:dictionary_flutter/common/values/string_manager.dart';
import 'package:flutter/cupertino.dart';

class FlutterDicRoutePath {
  final String name;
  final Map<String, dynamic>? parameters;
  final Widget widget;

  FlutterDicRoutePath.splash({this.parameters})
      : name = DictionaryStrings.launchScreen,
        widget = const SplashPage();

  FlutterDicRoutePath.login({this.parameters})
      : name = DictionaryStrings.loginOrSignupScreen,
        widget = const LoginPage();
  FlutterDicRoutePath.home({this.parameters})
      : name = DictionaryStrings.homeScreen,
        widget = const HomePage();
}
