/// run this in terminal::::  flutter test integration_test/app_test.dart
///
/// test how individual pieces work together as a whole,
/// capture the performance of an application running on a real device
import 'package:dictionary_flutter/app/modules/login/views/splash_page.dart';
import 'package:dictionary_flutter/common/values/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dictionary_flutter/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the  button, verify navi to MainTabPage', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await pumpUntil(
        tester: tester,
        condition: find.byType(SplashPage),
        check: findsOneWidget,
      );
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      // To login page
      final Finder emailTextFormField = find.byKey(
        Key(DictionaryStrings.emailTextFormFieldKey),
      );
      await tester.enterText(emailTextFormField, 'Hello Frank');
      await tester.pumpAndSettle();

      final Finder passwordTextFormField = find.byKey(
        Key(DictionaryStrings.passwordTextFormFieldKey),
      );
      await tester.enterText(passwordTextFormField, 'Hello password');
      await tester.pumpAndSettle();

      final Finder loginButton = find.byKey(
        Key(DictionaryStrings.loginButtonKey),
      );
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(loginButton);

      // Trigger a frame.
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      // Home page
      final Finder homeSearchBar = find.byKey(Key(DictionaryStrings.homeSearchBarKey));
      await tester.enterText(homeSearchBar, 'Hello');
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      await tester.testTextInput.receiveAction(TextInputAction.search);
      await Future.delayed(const Duration(seconds: 4));
      await tester.pump();
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    });
  });
}

pumpUntil({
  required WidgetTester tester,
  Finder? condition,
  Matcher? check,
  int interval = 1,
  int maxRetries = 20,
  List<Finder?>? conditions,
  bool ensureVisible = false,
}) async {
  assert(interval > 0);
  conditions = conditions ?? [condition];
  int awaited = 0;
  while (awaited <= maxRetries) {
    await tester.pumpAndSettle();
    if (check != null && conditions.first != null) {
      for (var c in conditions) {
        try {
          expect(c, check);
          await tester.pumpAndSettle();
          if (ensureVisible) await tester.ensureVisible(c!);
          return;
        } on Exception catch (_) {}
      }
    }
    await Future.delayed(Duration(seconds: interval));
    awaited += interval;
  }
  if (check != null && conditions.first != null) {
    for (var c in conditions) {
      expect(c, check);
    }
  }
}
