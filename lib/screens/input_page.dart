import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmiflutter/components/icon_content.dart';
import 'package:bmiflutter/components/reusable_card.dart';
import 'package:bmiflutter/constants.dart';
import 'package:bmiflutter/components/round_icon_button.dart';
import 'package:bmiflutter/components/bottom_button.dart';
import 'package:bmiflutter/screens/results_page.dart';
import 'package:bmiflutter/calculator.dart';

enum Gender { Male, Female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 180;
  int weight = 60;
  int age = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: ReusableCard(
                        color: selectedGender == Gender.Male
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: IconContent(
                            icon: FontAwesomeIcons.mars, text: "MALE"),
                        onTapCallback: () {
                          setState(() {
                            selectedGender = Gender.Male;
                          });
                        })),
                Expanded(
                    child: ReusableCard(
                        color: selectedGender == Gender.Female
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: IconContent(
                            icon: FontAwesomeIcons.venus, text: "FEMALE"),
                        onTapCallback: () {
                          setState(() {
                            selectedGender = Gender.Female;
                          });
                        }))
              ],
            ),
          ),
          Expanded(
              child: ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Height",
                  style: kLabelTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(height.toString(), style: kNumberTextStyle),
                    Text(
                      "cm",
                      style: kLabelTextStyle,
                    )
                  ],
                ),
                Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    activeColor: Color(0xFFEB1555),
                    inactiveColor: Color(0xFF8D8E98),
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    })
              ],
            ),
          )),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: ReusableCard(
                        color: kActiveCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "WEIGHT",
                              style: kLabelTextStyle,
                            ),
                            Text(weight.toString(), style: kNumberTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  cb: () {
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIconButton(
                                    icon: FontAwesomeIcons.plus,
                                    cb: () {
                                      setState(() {
                                        weight++;
                                      });
                                    })
                              ],
                            )
                          ],
                        ))),
                Expanded(
                    child: ReusableCard(
                        color: kActiveCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "AGE",
                              style: kLabelTextStyle,
                            ),
                            Text(age.toString(), style: kNumberTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  cb: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIconButton(
                                    icon: FontAwesomeIcons.plus,
                                    cb: () {
                                      setState(() {
                                        age++;
                                      });
                                    })
                              ],
                            )
                          ],
                        )))
              ],
            ),
          ),
          BottomButton(
              text: "CALCULATE",
              onTap: () {
                var calc = Calculator(height: height, weight: weight);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ResultsPage(
                      bmiResult: calc.calculateBMI(),
                      resultText: calc.getResult(),
                      interpretation: calc.getInterpretation());
                }));
              })
        ],
      ),
    );
  }
}
