import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/main.dart';

import '../common/test_case.dart';

class SampleTest implements TestCase {
  @override
  execute(WidgetTester tester) async {
    await _login(tester);
  }

  _login(WidgetTester tester) async {
    // Create variables for finders that are used multiple times.
    final itemFinder = find.byKey(const ValueKey('text_25'));

    // Scroll until the item to be found appears.
    await tester.scrollUntilVisible(
      itemFinder,
      500.0,
    );

    // Check if the item contains the correct text.
    expect(tester.widget<Text>(itemFinder).data, 'Item 25');

    await _addNewSession(tester);
  }

  _addNewSession(WidgetTester tester) async {
    // Wait 1 second for the SnackBar to be displayed
    await tester.pumpWidget(const TestingApp());

    // Create a finder for the icon.
    final iconFinder = find.byKey(const ValueKey('icon_0'));

    // Tap on the icon.
    await tester.tap(iconFinder);

    // Wait 1 second for the SnackBar to be displayed
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify if appropriate message appears.
    expect(find.text('Added to favorites.'), findsOneWidget);

    // Tap on the icon again.
    await tester.tap(iconFinder);

    // Wait 1 second for the SnackBar to be displayed
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify if appropriate message appears.
    expect(find.text('Removed from favorites.'), findsOneWidget);

    // Add item to favorites.
    await tester.tap(find.byKey(const ValueKey('icon_5')));
    await tester.pumpAndSettle();

    // Tap on the favorites button on the AppBar.
    // The Favorites List should appear.
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();

    // Check if the added item has appeared in the list.
    expect(
      tester
          .widget<Text>(find.byKey(const ValueKey('favorites_text_5')))
          .data,
      equals('Item 5'),
    );

    // Add item to favorites.
    await tester.tap(find.byKey(const ValueKey('icon_5')));
    await tester.pumpAndSettle();

    // Navigate to Favorites screen.
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();

    // Tap on the remove icon.
    await tester.tap(find.byKey(const ValueKey('remove_icon_5')));

    // Wait 1 second for the SnackBar to be displayed
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify if it disappears.
    expect(find.text('Item 5'), findsNothing);

    // Verify if appropriate message appears.
    expect(find.text('Removed from favorites.'), findsOneWidget);
  }
}
