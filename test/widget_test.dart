import 'package:flutter_test/flutter_test.dart';
import 'package:travenor/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const TravenorApp());
    await tester.pump();

    // Just verify the app builds without error
    expect(find.byType(TravenorApp), findsOneWidget);
  });
}
