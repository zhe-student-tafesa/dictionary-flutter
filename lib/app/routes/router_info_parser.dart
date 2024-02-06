/// Passed in as a parameter of MaterialApp.router
import 'package:dictionary_flutter/common/values/string_manager.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class FDRouteInformationParser extends RouteInformationParser<FlutterDicRoutePath> {
  @override
  Future<FlutterDicRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    return FlutterDicRoutePath.splash();
  }

  @override
  RouteInformation restoreRouteInformation(FlutterDicRoutePath configuration) {
    switch (configuration.name) {
      case DictionaryStrings.launchScreen:
        return const RouteInformation(location: '/');
    }
    return const RouteInformation(location: '/');
  }
}
