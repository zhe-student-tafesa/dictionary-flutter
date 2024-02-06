import 'package:dictionary_flutter/app/modules/login/controllers/auth_controller.dart';
import 'package:dictionary_flutter/app/modules/login/views/login_page.dart';
import 'package:dictionary_flutter/common/values/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const String email = 'qwe@qq.com';
const String password = 'A1234567';

void main() {
  setUp(() {});
  final mockAuthStateProvider = StateNotifierProvider<Auth, bool>((ref) {
    return Auth();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        /// use overrideWithProvider
        authProvider.overrideWithProvider(mockAuthStateProvider),
      ],
      child: const MaterialApp(
        home: LoginPage(),
      ),
    );
  }

  group('Login screen test', () {
    testWidgets('initial page is displayed normally', (WidgetTester tester) async {
      // Arrange  Act  Assert
      await tester.pumpWidget(createWidgetUnderTest()); //put NotificationPage to widget tree
      await tester.pumpAndSettle();
      expect(find.text(DictionaryStrings.loginPage), findsNWidgets(1));
    });
  });
}
