// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rescue_now/main.dart';

void main() {
  testWidgets('RescueNow app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RescueNowApp());

    // Verify that the app logo is displayed
    expect(find.byType(Image), findsOneWidget);

    // Verify that the language dropdown is present
    expect(find.byType(DropdownButton<String>), findsOneWidget);

    // Verify that the "Are you a user?" button is present
    expect(find.text('Are you a user?'), findsOneWidget);

    // Verify that the stakeholder buttons are present
    expect(find.text('Police'), findsOneWidget);
    expect(find.text('Hospital'), findsOneWidget);
    expect(find.text('NGO'), findsOneWidget);
    expect(find.text('Insurance Company'), findsOneWidget);
  });
}
