import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/models/history_model.dart';
import 'package:flutter_calculator_app/provider/calculator_provider.dart';
import 'package:flutter_calculator_app/services/services.dart';
import 'package:provider/provider.dart';

import 'history_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //ส่วน add เข้า provider
  TextEditingController tempTextController = TextEditingController();
  TextEditingController tempSumTextController = TextEditingController();

  Services services = FirebaseServices();

//ส่วนเก็บค่าไว้คำนวน
  dynamic text = '';
  double numOne = 0;
  double numTwo = 0;
  List<String> numbers = [];
  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  @override
  Widget build(BuildContext context) {
//เรียกใช้ provider
    CalculatorProvider calculatorProvider = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.date_range),
        ),
        title: Text('Calulator'),
        actions: [
          TextButton(
              onPressed: () {
                calculatorProvider.updateHistoryToFirebase(calculatorProvider.history);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryPage(),
                    ));
              },
              child: Text('History'))
        ],
        backgroundColor: Color(0xFF06121F), //395873//0xFF06020F
      ),
      body: Container(
        color: Color(0xFF06121F),
        child: Column(
          children: [
            Expanded(child: buildResult()),
            Expanded(flex: 2, child: buildButtons())
          ],
        ),
      ),
    );
  }

  Widget buildResult() => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${tempTextController.text}",
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            const SizedBox(height: 24),
            Text(
              finalResult,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ],
        ),
      );

  Widget Button({String? text, VoidCallback? onClicked}) {
    return Expanded(
      child: Container(
        color: Color(0xFF06121F),
        height: double.infinity,
        padding: EdgeInsets.all(1),
        child: ElevatedButton(
          onPressed: onClicked,
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          child: text == '<'
              ? Icon(Icons.backspace_outlined, color: Colors.white)
              : Text(text!, style: TextStyle(fontSize: 25)),
        ),
      ),
    );
  }

  Widget buildButtonRow(
    String first,
    String second,
    String third,
    String fourth,
  ) {
    final row = [first, second, third, fourth];
 CalculatorProvider calculatorProvider = Provider.of<CalculatorProvider>(context);
    return Expanded(
      child: Row(
        children: row
            .map((text) => Button(
                  text: text,
                  onClicked: () {
                    calculate(text);
                    // print(text);
                    //เอาไปเก็บผ่าน provider
                    setState(() {
                      if (tempTextController.text == '0' || text == 'CE' || text == "C") {
                        tempTextController.text = '';
                      } else if (text == "<") {
                        if ( tempTextController.text != null &&  tempTextController.text.length > 0) {
                           tempTextController.text =  tempTextController.text.substring(0,  tempTextController.text.length - 1);
                        }
                      } else if (text == '=') {
                      tempTextController.text += text;
                       calculatorProvider.addToListHistory(HistoryItemModel({'result':finalResult, 'sum':tempTextController.text}));
                      } else {
                        tempTextController.text += text;
                        print(tempTextController.text);
                      }
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget buildButtons() => Container(
        // padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF06121F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: <Widget>[
            buildButtonRow('%', 'CE', 'C', '<'),
            buildButtonRow('1/x', 'x^2', 'sqrt2', '÷'),
            buildButtonRow('7', '8', '9', '⨯'),
            buildButtonRow('4', '5', '6', '-'),
            buildButtonRow('1', '2', '3', '+'),
            buildButtonRow('+/-', '0', '.', '='),
          ],
        ),
      );

  void calculate(String btnText) {
    if (btnText == 'C' || btnText == 'CE') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
      tempTextController.text = '';
    } else if (btnText == '<') {
      if (result != null && result.length > 0) {
        result = result.substring(0, result.length - 1);
        finalResult = result;
      }
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == '⨯') {
        finalResult = mul();
      } else if (preOpr == '÷') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == '⨯' ||
        btnText == '÷' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == '⨯') {
        finalResult = mul();
      } else if (opr == '÷') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<CalculatorProvider>(context, listen: false).getHistoryFromFirebase();
    });
    getData();
  }

  Future<void> getData() async {
   var data = await services.getHistoryList();
  //  print(data[0].history[0]!.result);
  }
}
