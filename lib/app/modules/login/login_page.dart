import 'package:dictionary_flutter/app/routes/app_routes.dart';
import 'package:dictionary_flutter/app/routes/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  String? emailError;
  String? passwordError;

  GlobalKey formKey = GlobalKey();

  var emailTextEditController = TextEditingController();
  var passwordTextEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: const Text('Login page'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                controller: emailTextEditController,
              ),
              emailError == null
                  ? Container()
                  : Text(
                      emailError ?? '',
                      style: const TextStyle(color: Colors.red),
                    ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                controller: passwordTextEditController,
              ),
              passwordError == null
                  ? Container()
                  : Text(
                      passwordError ?? '',
                      style: TextStyle(color: Colors.red),
                    ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    debugPrint('Login');
                    if (emailTextEditController.text.isNotEmpty &&
                        passwordTextEditController.text.isNotEmpty) {
                      ref.read(authProvider.notifier).login();

                      FDRouterDelegate.instance.push(FlutterDicRoutePath.home());
                    } else {
                      setState(() {
                        checkInput();
                      });
                    }
                  },
                  child: const Text('Login')),
            ],
          ),
        ),
      ),
    );
  }

  void checkInput() {
    if (emailTextEditController.text.isEmpty) {
      emailError = 'Email required';
    } else {
      emailError = null;
    }
    if (passwordTextEditController.text.isEmpty) {
      passwordError = 'Password required';
    } else {
      passwordError = null;
    }
  }
}
