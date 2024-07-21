import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(cal1());
}

class cal1 extends StatefulWidget {
  const cal1({super.key});

  @override
  State<cal1> createState() => _cal1State();
}

class _cal1State extends State<cal1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          // shape: BeveledRectangleBorder(
          //     borderRadius:
          //         BorderRadius.vertical(top: Radius.elliptical(160, 16))),
          centerTitle: true,
          backgroundColor: Color(0xff311d3f),
          title: Text(
            "F-Calculator",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
        body: cal2(),
      ),
    ));
  }
}

class cal2 extends StatefulWidget {
  const cal2({super.key});

  @override
  State<cal2> createState() => _cal2State();
}

class _cal2State extends State<cal2> {
  String equation = '0';
  String result = '0';
  String expression = '0';

  buttonPressed(btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
      } else if (btnText == '⌫') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (btnText == '=') {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          'error';
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else
          equation = equation + btnText;
      }
    });
  }

  Widget calButtons(
      String btnText, Color txtColor, double btnWidth, Color btnColor) {
    return InkWell(
      onTap: () {
        buttonPressed(btnText);
      },
      child: Container(
        alignment: Alignment.center,
        height: 70,
        width: btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(btnText,
            style: TextStyle(
                color: txtColor, fontSize: 30, fontWeight: FontWeight.w500)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff311d3f),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              //decoration: BoxDecoration.,
              alignment: Alignment.centerRight,
              height: 100,
              width: double.infinity,
              color: Color(0xff311d3f),

              child: SingleChildScrollView(
                child: Text(
                  equation,
                  style: TextStyle(color: Colors.white38, fontSize: 30),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              height: 80,
              width: double.infinity,
              color: Color(0xff311d3f),
              child: Text(
                result,
                style: TextStyle(color: Colors.white38, fontSize: 50),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                calButtons('AC', Colors.white, 80, Color(0xff522546)),
                calButtons('⌫', Colors.white, 80, Color(0xff522546)),
                calButtons('%', Colors.white, 80, Color(0xff522546)),
                calButtons('÷', Colors.white, 80, Color(0xff522546)),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                calButtons('7', Colors.white, 80, Color(0xff1c1d1c)),
                calButtons('8', Colors.white, 80, Color(0xff1c1d1c)),
                calButtons('9', Colors.white, 80, Color(0xff1c1d1c)),
                calButtons('×', Colors.white, 80, Color(0xff522546)),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                calButtons('4', Colors.white, 80, Color(0xff1c1d1c)),
                calButtons('5', Colors.white, 80, Color(0xff1c1d1c)),
                calButtons('6', Colors.white, 80, Color(0xff1c1d1c)),
                calButtons('-', Colors.white, 80, Color(0xff522546)),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                calButtons('1', Colors.white, 80, Color(0xff1c1d1c)),
                calButtons('2', Colors.white, 80, Color(0xff1c1d1c)),
                calButtons('3', Colors.white, 80, Color(0xff1c1d1c)),
                calButtons('+', Colors.white, 80, Color(0xff522546)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                calButtons(
                  '0',
                  Color(0xff522546),
                  100,
                  Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                calButtons(
                  '.',
                  Color(0xff522546),
                  100,
                  Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                calButtons(
                  '=',
                  Colors.white,
                  100,
                  Colors.black12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//calButtons(String s, Color white, int i, MaterialColor deepOrange) {}
}
