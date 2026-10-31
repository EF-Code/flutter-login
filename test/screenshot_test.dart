import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_login/main.dart';

void main() {
  testWidgets('Capture the login page for the README', (tester) async {
    // Load the same fonts as the app instead of Flutter's square test glyphs.
    final fonts = FontLoader('AppRoboto');
    for (final weight in ['Regular', 'Bold']) {
      fonts.addFont(rootBundle.load('assets/fonts/Roboto-$weight.ttf'));
    }
    await fonts.load();
    final icons = FontLoader('MaterialIcons');
    icons.addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const RepaintBoundary(child: LoginApp()));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(LoginApp),
      matchesGoldenFile('../screenshots/login.png'),
    );
  });
}
