import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _heightcontroller = TextEditingController();
  final TextEditingController _weightcontroller = TextEditingController();
  double a = 0.0, b = 0.0, c = 0.0, result = 0.0, calories = 0.0;
  String bmr, caloriesDay;

  List<DropdownMenuItem<String>> listGender = [];
  List<String> gender = ['Male', 'Female'];
  String selectedGender = 'Male';
  List<DropdownMenuItem<String>> listEquation = [];
  List<String> equation = ['Miffin -St Jeor (Default)', 'Harris-Benedict'];
  String selectedEquation = 'Miffin -St Jeor (Default)';
  List<DropdownMenuItem<String>> listSelectActvity = [];
  List<String> actvityLevel = [
    'Little or no exercise',
    'Light exercise or sports 1-3 days per week',
    'Moderate exercise or sports 3-5 days per week',
    'Hard exercise or sports 6-7 days per week',
    'Very hard exercise or sports and a physical job'
  ];
  String selectedActivityLevel = 'Little or no exercise';
  String img = "assets/images/bmr.png";

  void loadData() {
    listGender = [];
    listGender = gender
        .map((val) => new DropdownMenuItem<String>(
              child: Text(val),
              value: val,
            ))
        .toList();

    listEquation = [];
    listEquation = equation
        .map((val) => new DropdownMenuItem<String>(
              child: Text(val),
              value: val,
            ))
        .toList();

    listSelectActvity = [];
    listSelectActvity = actvityLevel
        .map((val) => new DropdownMenuItem<String>(
              child: Text(val),
              value: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('BMR Calculator'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(img, height: 150.0, width: 170.0),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Gender :',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: DropdownButton<String>(
                      items: gender.map((String val) {
                        return new DropdownMenuItem<String>(
                          value: val,
                          child: new Text(val),
                        );
                      }).toList(),
                      hint: Text('Male'),
                      iconSize: 40.0,
                      elevation: 16,
                      onChanged: (String newVal) {
                        setState(() {
                        selectedGender = newVal;
                        });
                      },
                      value: selectedGender,
                    )),
              ],
            )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'BMR Equation :',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: DropdownButton<String>(
                      items: equation.map((String val) {
                        return new DropdownMenuItem<String>(
                          value: val,
                          child: new Text(val),
                        );
                      }).toList(),
                      hint: Text('Miffin -St Jeor (Default)'),
                      iconSize: 40.0,
                      elevation: 16,
                      onChanged: (String newVal) {
                        setState(() {
                        selectedEquation= newVal;
                        });
                      },
                      value: selectedEquation,
                    )),
              ],
            )),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  hintText: 'Please enter your age:',
                  labelText: 'Age'),
              keyboardType: TextInputType.numberWithOptions(),
              controller: _agecontroller,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  hintText: 'Please enter your Height(cm):',
                  labelText: 'Height(cm)'),
              keyboardType: TextInputType.numberWithOptions(),
              controller: _heightcontroller,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  hintText: 'Please enter your Weight(kg):',
                  labelText: 'Weight(kg):'),
              keyboardType: TextInputType.numberWithOptions(),
              controller: _weightcontroller,
            ),
            Center(
                child: new ListTile(
              title: Text('Please select your activity level:'),
            )),
            Padding(
                padding: EdgeInsets.all(5),
                child: DropdownButton<String>(
                      items: actvityLevel.map((String val) {
                        return new DropdownMenuItem<String>(
                          value: val,
                          child: new Text(val),
                        );
                      }).toList(),
                      hint: Text('Little or no exercise'),
                  iconSize: 40.0,
                  elevation: 16,
                  onChanged: (String newVal) {
                        setState(() {
                        selectedActivityLevel= newVal;
                        });
                      },
                      value: selectedActivityLevel,
                )),
            Padding(
              padding: EdgeInsets.all(5),
              child: RaisedButton(
                child: Text("Calculate BMR"),
                onPressed: _onPress,
              ),
            ),
            Text("BMR Result: $bmr, Calories Per Day:$calories"),
          ],
        ),
      ),
    );
  }

  void _onPress() {
    setState(() {
      a = double.parse(_agecontroller.text);
      b = double.parse(_heightcontroller.text);
      c = double.parse(_weightcontroller.text);
      if ((selectedGender == 'Male') &&
          (selectedEquation == 'Miffin -St Jeor (Default)')) {
        result = (10 * c) + (6.25 * b) - (5 * a) + 5;
        if (selectedActivityLevel == 'Little or no exercise') {
          calories = result * 1.2;
        } else if (selectedActivityLevel ==
            'Light exercise or sports 1-3 days per week') {
          calories = result * 1.375;
        } else if (selectedActivityLevel ==
            'Moderate exercise or sports 3-5 days per week') {
          calories = result * 1.55;
        } else if (selectedActivityLevel ==
            'Hard exercise or sports 6-7 days per week') {
          calories = result * 1.725;
        } else if (selectedActivityLevel ==
            'Very hard exercise or sports and a physical job') {
          calories = result * 1.9;
        }
      } else if ((selectedGender == 'Female') &&
          (selectedEquation == 'Miffin -St Jeor (Default)')) {
        result = (10 * c) + (6.25 * b) - (5 * a) - 161;
        if (selectedActivityLevel == 'Little or no exercise') {
          calories = result * 1.2;
        } else if (selectedActivityLevel ==
            'Light exercise or sports 1-3 days per week') {
          calories = result * 1.375;
        } else if (selectedActivityLevel ==
            'Moderate exercise or sports 3-5 days per week') {
          calories = result * 1.55;
        } else if (selectedActivityLevel ==
            'Hard exercise or sports 6-7 days per week') {
          calories = result * 1.725;
        } else if (selectedActivityLevel ==
            'Very hard exercise or sports and a physical job') {
          calories = result * 1.9;
        }
      } else if ((selectedGender == 'Male') &&
          (selectedEquation == 'Harris-Benedict')) {
        result = 66.47 + (13.75 * c) + (5.003 * b) - (6.755 * a);
        if (selectedActivityLevel == 'Little or no exercise') {
          calories = result * 1.2;
        } else if (selectedActivityLevel ==
            'Light exercise or sports 1-3 days per week') {
          calories = result * 1.375;
        } else if (selectedActivityLevel ==
            'Moderate exercise or sports 3-5 days per week') {
          calories = result * 1.55;
        } else if (selectedActivityLevel ==
            'Hard exercise or sports 6-7 days per week') {
          calories = result * 1.725;
        } else if (selectedActivityLevel ==
            'Very hard exercise or sports and a physical job') {
          calories = result * 1.9;
        }
      } else if ((selectedGender == 'Female') &&
          (selectedEquation == 'Harris-Benedict')) {
        result = 655.1 + (9.563 * c) + (1.85 * b) - (4.676 * a);
        if (selectedActivityLevel == 'Little or no exercise') {
          calories = result * 1.2;
        } else if (selectedActivityLevel ==
            'Light exercise or sports 1-3 days per week') {
          calories = result * 1.375;
        } else if (selectedActivityLevel ==
            'Moderate exercise or sports 3-5 days per week') {
          calories = result * 1.55;
        } else if (selectedActivityLevel ==
            'Hard exercise or sports 6-7 days per week') {
          calories = result * 1.725;
        } else if (selectedActivityLevel ==
            'Very hard exercise or sports and a physical job') {
          calories = result * 1.9;
        }
      }
    });
    bmr = result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 0);
    caloriesDay =
        calories.toStringAsFixed(calories.truncateToDouble() == calories ? 0 : 0);
  }
}
