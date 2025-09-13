import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:guideian_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Guideian App Integration Tests', () {
    testWidgets('App launches and shows home screen', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Verify the app loads without crashing
      expect(find.byType(MaterialApp), findsOneWidget);
      
      // Verify we can find key elements
      expect(find.text('Guideian'), findsAtLeastNWidgets(1));
    });

    testWidgets('Navigation works correctly', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Test navigation to different screens
      // Note: Add specific navigation tests based on your app structure
      
      // Example: Test if navigation buttons exist
      expect(find.text('Home'), findsAtLeastNWidgets(1));
      expect(find.text('About'), findsAtLeastNWidgets(1));
      expect(find.text('Services'), findsAtLeastNWidgets(1));
      expect(find.text('Contact'), findsAtLeastNWidgets(1));
    });

    testWidgets('Contact form validation', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to contact screen (adjust based on your navigation)
      // This is a placeholder - adjust based on your actual navigation
      
      // Test form validation
      // Add specific tests for your contact form
    });
  });
}
