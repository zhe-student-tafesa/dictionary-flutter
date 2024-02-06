import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<Auth, bool>((ref) {
  return Auth();
});

class Auth extends StateNotifier<bool> {
  Auth() : super(false);

  void login() {
    state = true;
  }

  void logout() {
    state = false;
  }
}
