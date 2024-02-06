import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/routes/router_delegate.dart';
import 'app/routes/router_info_parser.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  final FDRouterDelegate _routerDelegate = FDRouterDelegate.instance;
  final FDRouteInformationParser _parser = FDRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Dictionary',
      color: Colors.black,
      routeInformationParser: _parser,
      routerDelegate: _routerDelegate,
      /// use EasyLoading when waiting api data
      builder: EasyLoading.init(),
    );
  }
}
