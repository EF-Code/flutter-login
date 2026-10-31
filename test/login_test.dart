import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_login/main.dart';

void main() {
  testWidgets('Invalid inputs show errors and valid inputs clear them', (
    tester,
  ) async {
    await tester.pumpWidget(const LoginApp());
    final fields = find.byType(TextFormField);
    final button = find.widgetWithText(FilledButton, 'Sign in');

    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(find.text('Use at least 6 characters.'), findsOneWidget);

    await tester.enterText(fields.first, 'invalid-email');
    await tester.enterText(fields.last, '123');
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(find.text('Use at least 6 characters.'), findsOneWidget);

    await tester.enterText(fields.first, 'learner@example.com');
    await tester.enterText(fields.last, 'secret123');
    expect(
      tester.widget<EditableText>(find.byType(EditableText).last).obscureText,
      isTrue,
    );
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email address.'), findsNothing);
    expect(find.text('Use at least 6 characters.'), findsNothing);
    expect(
      tester
          .widget<EditableText>(find.byType(EditableText).last)
          .focusNode
          .hasFocus,
      isFalse,
    );
  });

  testWidgets('The form remains usable on a small screen with a keyboard', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    tester.view.viewInsets = const FakeViewPadding(bottom: 260);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const LoginApp());
    await tester.pumpAndSettle();

    final button = find.widgetWithText(FilledButton, 'Sign in');
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.text('Use at least 6 characters.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Password visibility can be toggled without changing its value', (
    tester,
  ) async {
    await tester.pumpWidget(const LoginApp());
    final password = find.byType(TextFormField).last;
    await tester.enterText(password, 'example-password');
    await tester.ensureVisible(find.byTooltip('Show password'));
    await tester.tap(find.byTooltip('Show password'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<EditableText>(find.byType(EditableText).last).obscureText,
      isFalse,
    );
    expect(find.text('example-password'), findsOneWidget);
    await tester.tap(find.byTooltip('Hide password'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<EditableText>(find.byType(EditableText).last).obscureText,
      isTrue,
    );
  });

  testWidgets('Keyboard submission validates the form', (tester) async {
    await tester.pumpWidget(const LoginApp());
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.first, 'person@example.com');
    await tester.enterText(fields.last, 'example-password');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email address.'), findsNothing);
    expect(find.text('Use at least 6 characters.'), findsNothing);
    expect(
      tester
          .widget<EditableText>(find.byType(EditableText).last)
          .focusNode
          .hasFocus,
      isFalse,
    );
  });

  testWidgets('The layout supports larger text', (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const LoginApp());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
