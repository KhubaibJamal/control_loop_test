import 'package:flutter_test/flutter_test.dart';
import 'package:control_loop_test/main.dart';

void main() {
  testWidgets('App builds home screen', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.text('What service do you need?'), findsOneWidget);
  });
}
