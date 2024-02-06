import 'dart:async';
import 'package:dictionary_flutter/common/values/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_flutter/app/modules/login/views/splash_page.dart';
import 'app_routes.dart';

class FDRouterDelegate extends RouterDelegate<FlutterDicRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FlutterDicRoutePath> {
  static FDRouterDelegate instance = FDRouterDelegate();
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  FDRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  static FDRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is FDRouterDelegate, 'Delegate type must match');
    return delegate as FDRouterDelegate;
  }

  List<Page> _pages = <Page>[
    const MaterialPage(
      child: SplashPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        pop();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(FlutterDicRoutePath configuration) async {}

  push(FlutterDicRoutePath router, {bool? fullscreenDialog}) {
    switch (router.name) {
      // when push home, pop all pages first
      case DictionaryStrings.homeScreen:
        _pages = [
          MaterialPage(
              name: router.name, child: router.widget, fullscreenDialog: fullscreenDialog ?? false)
        ];
        break;

      case DictionaryStrings.loginOrSignupScreen:
        _pages = [
          MaterialPage(
              name: router.name, child: router.widget, fullscreenDialog: fullscreenDialog ?? false)
        ];
        break;

      default:
        _pages.add(MaterialPage(
            name: router.name, child: router.widget, fullscreenDialog: fullscreenDialog ?? false));
    }

    notifyListeners();
  }

  pop() {
    if (_pages.length > 1) {
      _pages.remove(_pages.last);
      notifyListeners();
    }
  }

}
