
import 'package:flutter/widgets.dart';

class CalculationModel with ChangeNotifier {

  List<String> _equationString = <String>[];
  final List<String> _proccessStack = <String>[];
  final List<String> _resultHistory = <String>[];
  String internalEquation = "";
  String errorMsg = "";

  int _lastIndex = 0;
  int _currentIndex = 0;
  int _selectedHistory = 0;

  double _result = 0;
  bool _resultFlag = true;
  bool _historyFlag = false;

  String get currentResult => errorMsg + _result.toString();
  String get equation => _equationString.join();

  void _addToEquationString(String item) {
    _equationString.add(item);
  }
  
  void _removeFromEquationStringAt(int index) {
    _equationString.removeAt(index);
  }

  void _addToProccessStack(String item) {
    _proccessStack.add(item);
  }

  void _addToHistory(String item) {
    _resultHistory.add(item);
  }

  bool _isCorrectEquationSyntax(String equation) {
    RegExp exp = RegExp(r"(\-{0,1}[\.\d]+[\+\-\*\/])+[0-9]+");
    if (exp.hasMatch(equation)) {
      return true;
    }
    return false;
  }

  bool checkLastSymbol() {
    if (_equationString.isEmpty) {
      return false;
    }
    String symbol = _equationString.last;
    switch (symbol) {
      case '+':
      case '*':
      case '/':
      case '=':
        _equationString.remove(_equationString.last);
        return true;

      default:
        return true;
    }
  }
  
  String getLastNumber() {
    if (_currentIndex == _lastIndex) {
      return _equationString[_currentIndex];
    }
    _currentIndex = _equationString.length - 2;
    String lastNumber = _equationString.sublist(
      _lastIndex , _currentIndex
    ).join();
    return lastNumber;
  }

  double findResult() {
      int priority = 5;
      while (listContainValues(_proccessStack, ['+', '-', '*', '/'])) {
        int index = _proccessStack.indexWhere((elemet) => 
          Operation(elemet).priority == priority
        );
        if (index == -1) {
          priority--;
        } else {
          double subResult = calc(_proccessStack[index-1], _proccessStack[index+1], _proccessStack[index]);
          putSubResultInStack(subResult, index);
      }
    }  
    return double.parse(_proccessStack.join());
  }

  bool listContainValues(List<String> list, List<String> values) {
    for  (var value in values) {
      if (list.contains(value)) {
        return true;
      }
    }
    return false;
  }

  double calc(String no1, String no2, String op) {
    double num1 = double.parse(no1);
    double num2 = double.parse(no2);

    switch (op) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '*':
        return num1 * num2;
      case '/':
        if (num2 != 0) {
          return num1 / num2;
        }
        return 0.0;
      default:
        return 0.0;
    }
  }

  void _extractNumber() {
    RegExp exp = RegExp(r"\-{0,1}[\.\d]+(?=[\+\-\*\/])");
    var match = exp.firstMatch(equation);
    String stackItem = "";
    if (match != null) {
      stackItem = match.group(0).toString();
      _addToProccessStack(stackItem);
      internalEquation = internalEquation.replaceFirst(exp , "");
    }
  }

  void _extractSymbol() {
    _addToProccessStack(_equationString[0]);
    _equationString.removeAt(0);
  }

  void _fillStackProccess() {
    _proccessStack.clear();
    internalEquation = _equationString.join();
    while( listContainValues(_equationString, ['+', '-', '*', '/']) ) {
      _extractNumber();
      _equationString = internalEquation.split('');
      _extractSymbol();
      internalEquation = _equationString.join();
    }
    _addToProccessStack(internalEquation);
    _equationString.clear();
  }

  void putSubResultInStack(double subResult, int index) {
    _proccessStack.removeAt(index + 1);
    _proccessStack[index] = subResult.toString();
    _proccessStack.removeAt(index - 1);
  }

  //Response Provider

  void numberClickEvent(String number) {
    _historyFlag = false;
    if (_resultFlag) {
      clear();
      _resultFlag = false;
    }
    _addToEquationString(number);
    notifyListeners();
  }

  void equalityClickEvent() {
    _historyFlag = false;
    if (!_resultFlag) {
      if (_isCorrectEquationSyntax(equation)) {
        errorMsg = "";
        _fillStackProccess();
        _result = findResult();
        final String _tempStringResult = _result.toString();
        _addToEquationString(_tempStringResult);
        _addToHistory(_tempStringResult);
        _selectedHistory = _resultHistory.length - 1;
      } else {
        print("error");
        errorMsg = "Syntax Error..";
        _result = 0;
      } 
      notifyListeners();
      _resultFlag = true;     
    } 
  }

  void symbolClickEvent(String symbol) {
    _historyFlag = false;
    if (_resultFlag) {
      _resultFlag = false;
      clear();
      _addToEquationString(_result.toString());
    }
    if (checkLastSymbol()) {
      _addToEquationString(symbol);
      _lastIndex = _equationString.length;
    } else if (symbol == '-') {
      _addToEquationString(symbol);
    }
    notifyListeners();
  }

  void undoClickEvent() {
    _historyFlag = false;
    if (_equationString.isNotEmpty) {
      _removeFromEquationStringAt(_equationString.length - 1);
      notifyListeners();
    }
  }

  void nextClickEvent() {
    if (_resultFlag) {
      clear();
      _resultFlag = false;
    }
    if (_resultHistory.isNotEmpty) {
      _selectedHistory = (_selectedHistory + 1) % _resultHistory.length;
      if (_historyFlag) {
        _removeFromEquationStringAt(_equationString.length - 1);
      }
      _addToEquationString(_resultHistory[_selectedHistory]);
      print(_resultHistory);
      print(_historyFlag);
      _historyFlag = true;
      notifyListeners();
    }
  }

  void prevClickEvent() {
    if (_resultFlag) {
      clear();
      _resultFlag = false;
    }
    if (_resultHistory.isNotEmpty) {
      _selectedHistory = _selectedHistory - 1;
      if (_selectedHistory < 0) {
        _selectedHistory = _resultHistory.length - 1;         
      }
      if (_historyFlag) {
        _removeFromEquationStringAt(_equationString.length - 1);
      }
      _addToEquationString(_resultHistory[_selectedHistory]);
      _historyFlag = true;
      notifyListeners();
    }
  }

  void clearAllClickEvent() {
    clear();
    _result = 0;
    notifyListeners();
  }

  void clear() {
    _equationString.clear();
    _proccessStack.clear();
    _lastIndex = 0;
    _currentIndex = 0;
  }
}


class Operation {
  String symbol = "";
  int priority = 0;
  Operation(this.symbol) {
    switch (symbol) {
      case '+':
      case '-':
        priority = 4;
        break;
      case '*':
      case '/':
        priority = 5;
        break; 
      default:
        priority = 0;       
    }
  }
}