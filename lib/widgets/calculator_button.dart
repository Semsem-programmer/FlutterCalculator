
import 'package:flutter/material.dart';

class CalculatorBtn extends StatelessWidget {

  final String content;
  const CalculatorBtn({ required this.content  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 60,
          width: 60,
          alignment: Alignment.center,
          child: Text(
            content,
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.grey,
              fontSize: 28,
              fontWeight: FontWeight.normal,
            ),
            ),
          decoration: BoxDecoration(        
            color: const Color.fromRGBO(0, 0, 102, 1),
            border: Border.all(
              color: Colors.grey,
              width: 1,
              style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      );
  }
}