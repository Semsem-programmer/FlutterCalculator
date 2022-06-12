
import 'package:test/test.dart';
import 'package:calculator/claculation_model.dart';

void main() {
  final CalculationModel calculate = CalculationModel();
  group("Calculator Testing", () {
    test('2+3= should be 5', () {

      calculate.numberClickEvent("2");
      calculate.symbolClickEvent("+");
      calculate.numberClickEvent("3");
      calculate.equalityClickEvent();

      expect(calculate.currentResult , "5.0");
    });

    test('2+3*7= should be 26.0', () {

      calculate.numberClickEvent("2");
      calculate.symbolClickEvent("+");
      calculate.numberClickEvent("3");
      calculate.symbolClickEvent("*");
      calculate.numberClickEvent("7");
      calculate.equalityClickEvent();

      expect(calculate.currentResult , "23.0");
    });

    test('9---3= should be error', () {

      calculate.numberClickEvent("9");
      calculate.symbolClickEvent("-");
      calculate.symbolClickEvent("-");
      calculate.symbolClickEvent("-");
      calculate.numberClickEvent("3");
      calculate.equalityClickEvent();
      expect(calculate.currentResult , "Syntax Error");
    });

    test('2+3*= should be error', () {

      calculate.numberClickEvent("2");
      calculate.symbolClickEvent("+");
      calculate.numberClickEvent("3");
      calculate.symbolClickEvent("*");
       calculate.equalityClickEvent();
      expect(calculate.currentResult , "Syntax Error");
    });

  });

}