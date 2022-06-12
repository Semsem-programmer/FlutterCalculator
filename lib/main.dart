import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:calculator/claculation_model.dart';
import 'package:calculator/widgets/calculator_button.dart';
import 'package:calculator/widgets/calculator_input.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculationModel(),
      child: const CalculationPage(),
    );
  }
}

class CalculationPage extends StatelessWidget {
  const CalculationPage();

  @override
  Widget build(BuildContext context) {
    final calculate = Provider.of<CalculationModel>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CalculatorInput(
              equation: calculate.equation, 
              result: calculate.currentResult
            ),           
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => calculate.clearAllClickEvent(),
                      child: const CalculatorBtn(content: "AC"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.undoClickEvent(),
                      child: const CalculatorBtn(content: "c"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.prevClickEvent(),
                      child: const CalculatorBtn(content: "<"),
                    ),                 
                    GestureDetector(
                      onTap: () => calculate.nextClickEvent(),
                      child: const CalculatorBtn(content: ">"),
                    ),                 
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("1"),
                      child: const CalculatorBtn(content: "1"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("2"),
                      child: const CalculatorBtn(content: "2"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("3"),
                      child: const CalculatorBtn(content: "3"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("."),
                      child: const CalculatorBtn(content: "."),
                    ),                 
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("4"),
                      child: const CalculatorBtn(content: "4"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("5"),
                      child: const CalculatorBtn(content: "5"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("6"),
                      child: const CalculatorBtn(content: "6"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.symbolClickEvent("+"),
                      child: const CalculatorBtn(content: "+"),
                    ),                  
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("7"),
                      child: const CalculatorBtn(content: "7"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("8"),
                      child: const CalculatorBtn(content: "8"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("9"),
                      child: const CalculatorBtn(content: "9"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.symbolClickEvent("-"),
                      child: const CalculatorBtn(content: "-"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => calculate.symbolClickEvent("*"),
                      child: const CalculatorBtn(content: "*"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.numberClickEvent("0"),
                      child: const CalculatorBtn(content: "0"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.symbolClickEvent("/"),
                      child: const CalculatorBtn(content: "/"),
                    ),
                    GestureDetector(
                      onTap: () => calculate.equalityClickEvent(),
                      child: const CalculatorBtn(content: "="),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    );   
  }
}
