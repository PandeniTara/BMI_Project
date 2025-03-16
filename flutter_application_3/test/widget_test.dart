import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_3/main.dart';

void main() {
  testWidgets('BMI Calculation Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BMICalculator());

    // Masukkan berat badan
    await tester.enterText(find.byType(TextField).at(0), '70'); // kg

    // Masukkan tinggi badan
    await tester.enterText(find.byType(TextField).at(1), '170'); // cm

    // Tekan tombol "Hitung BMI"
    await tester.tap(find.text('Hitung BMI'));
    await tester.pump();

    // Periksa apakah hasil BMI muncul
    expect(find.textContaining("BMI Anda"), findsOneWidget);
  });
}
