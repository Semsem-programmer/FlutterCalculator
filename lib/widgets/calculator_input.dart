import 'package:flutter/material.dart';

class CalculatorInput extends StatelessWidget {

  final String equation;
  final String result;
  const CalculatorInput({ required this.equation, required this.result  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 150,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  equation,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromRGBO(0, 0, 102, 1),
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  result,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromRGBO(0, 0, 102, 1),
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          
          decoration: BoxDecoration(        
            //color: const Color.fromRGBO(179, 217, 255, 1),
            border: Border.all(
              color: const Color.fromRGBO(0, 0, 102, 1),
              width: 1,
              style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(179, 217, 255, 1),
                Colors.white,
                Color.fromRGBO(179, 217, 255, 1),
              ],
            )
          ),
        ),
      );
  }
}