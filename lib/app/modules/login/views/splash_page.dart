/// The first page loaded when the app is running
///
import 'package:dictionary_flutter/app/routes/app_routes.dart';
import 'package:dictionary_flutter/app/routes/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../controllers/auth_controller.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _await1SAndNavToLogin();
    super.initState();
  }

  _await1SAndNavToLogin() {
    Future.delayed(const Duration(seconds: 1), () {
      final alreadyLoggedIn = ref.read(authProvider.notifier).state;
      if (alreadyLoggedIn) {
        FDRouterDelegate.instance.push(FlutterDicRoutePath.home());
      } else {
        FDRouterDelegate.instance.push(FlutterDicRoutePath.login());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: Text('Splash page'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
