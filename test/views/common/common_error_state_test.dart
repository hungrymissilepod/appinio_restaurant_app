import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_booking_app/views/common/common_error_state.dart';

void main() {
  group('CommonErrorState -', () {
    testWidgets('Widget state', (WidgetTester tester) async {
      /// Method to test [onTap]
      int counter = 0;
      void onTap() {
        counter++;
      }

      await tester.pumpWidget(CupertinoApp(
          home: CommonErrorState(
        label: 'Error',
        onTap: onTap,
      )));

      expect(find.byType(CommonErrorState), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.triangleExclamation), findsOneWidget);

      final Icon icon = tester.firstWidget(find.byType(Icon));
      expect(icon.color, CupertinoColors.destructiveRed);

      expect(find.text('Error'), findsOneWidget);

      expect(find.byType(CupertinoButton), findsOneWidget);
      final CupertinoButton button =
          tester.firstWidget(find.byType(CupertinoButton));
      expect(button.color, CupertinoColors.activeBlue);

      /// Test [onTap] method callback
      await tester.tap(find.byType(CupertinoButton));
      expect(counter, 1);
    });
  });
}
