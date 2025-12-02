import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thuyettrinh/main.dart';

void main() {
  testWidgets('Renders Home Page and menu items', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final GlobalKey<NavigatorState> testNavigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(MyApp(navigatorKey: testNavigatorKey));

    // Verify that the home page title is displayed.
    expect(find.text('Trang chủ'), findsOneWidget);

    // Verify that the menu items are present.
    expect(find.text('Khuyến mãi'), findsOneWidget);
    expect(find.text('Trợ giúp'), findsOneWidget);
    expect(find.text('Ví'), findsOneWidget);
  });
}
