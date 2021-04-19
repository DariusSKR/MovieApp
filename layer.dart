import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

class LayerCalculator extends StatefulWidget {
  @override
  _LayerState createState() => _LayerState();
}

class _LayerState extends State<LayerCalculator> {
double delta =0, x=0, reynold=0;

final TextEditingController  t1 = TextEditingController(text: "0");
final TextEditingController  t2= TextEditingController(text: "0");

  void doCalculation(){
    setState(() {
      x=double.parse(t1.text);
      reynold=double.parse(t2.text);
      delta =  (0.382*x)/(pow(reynold, 0.2));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Boundary layer calculator",)),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Enter x"),
                controller: t1,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Enter reynold"),
                controller: t2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(child: Text("Calculate!"),
                      color: Colors.green,
                      onPressed: doCalculation)
                ],
              ),
              Column( children: [
                Text("Output : $delta "  )]
              ),
            ],
          ),
        ));
  }

  // calculateThickness(double xValue, double reynold) {
  //   double delta = 0;
  //
  //   if (delta < 0 || delta.toString().isEmpty || _delta == null) {
  //     print("Error");
  //   } else {
  //     delta = (0.382 * xValue) / (pow(reynold, 0.2));
  //   }
  //   return delta;
 // }
}
