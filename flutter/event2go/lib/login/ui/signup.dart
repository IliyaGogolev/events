import 'package:event2go/login/data/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
//https://medium.com/@boldijar.paul/comboboxes-in-flutter-cabc9178cc95

class SignupWidget extends StatefulWidget {
//  List<String> _countrycodes = ["+65", "+91"];
//  List<String> _colors = ['', 'red', 'green', 'blue', 'orange'];

  String _color = '';

//  Signup({Key key}) : super (key:key);
//  final String title;
  @override
  SignupPageState createState() => new SignupPageState();
}

class SignupPageState extends State<SignupWidget> {
  String _selectedCountryCode;

//  List _cities =
//  ["US", "Canada", "Russia"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  TextEditingController _controller = new TextEditingController();
//  MaskedTextController _controllerPhone = new MaskedTextController(mask: '0.0.0.000.000-00');
  MaskedTextController _controllerPhone = new MaskedTextController(mask: '(000) 000-0000');
//  TextEditingController _controllerPhone = new MaskedTextController(mask :'(000) 000-0000');
  String _selectedCountryName;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in countries) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    List<DropdownMenuItem<String>> _dropDownMenuItems;
//    String _selectedCountryCode;

    List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];

    String _color = '';

    final cities = new DropdownButton(
      value: _currentCity,
      items: _dropDownMenuItems,
      onChanged: changedDropDownItem,
    );

//    List<DropdownMenuItem<String>> getDropDownMenuItems() {
//      List<DropdownMenuItem<String>> items = new List();
//      for (String code in _countrycodes) {
//        items.add(new DropdownMenuItem(
//            value: code,
//            child: new Text(code)
//        ));
//      }
//      return items;
//    }
    /**return new Material(
        color: Colors.blueAccent,
        child: new Scaffold(
        body: new Stack(
        children: <Widget>[
        new Container(
        decoration: new BoxDecoration(
        image: new DecorationImage(image: new AssetImage("assets/images/download.jpg"), fit: BoxFit.cover,),
        ),
        ),
        new Center(
        child: new Text("Hello LandingPage"),
        )
        ],
        )
        ));**/

    final title =
        Text('Please confirm your country code and enter your phone number.');

//    final countryNames = DropdownButton(
//      value: _selectedCountryName,
//      items: _countrycodes
//          .map((code) =>
//      new DropdownMenuItem(value: code, child: new Text(code)))
//          .toList(),
//      onChanged: null,
//    );

//      keyboardType: TextInputType.text,
//      autofocus: false,
//      initialValue: 'Please confirm your country code and enter your phone number.',
//      decoration: InputDecoration(
//        hintText: 'Email',
//        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),

//        border: OutlineInputBorder(
//
//            borderRadius: BorderRadius.circular(32.0)
//        ),

//      ),
//
//    );


    final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          elevation: 5.0,
          child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () {
              print("Signup button clicked");
            },
            color: Colors.lightBlueAccent,
            child: Text(
              'Send',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ));

//    final countryCode = DropdownButton(
//        value: _selectedCountryCode,
//        items: _dropDownMenuItems,
//        onChanged: null
//    );

//    final countryCode = DropdownButton(
//      value: _selectedCountryCode,
//      items: _countrycodes
//          .map((code) =>
//      new DropdownMenuItem(value: code, child: new Text(code)))
//          .toList(),
//      onChanged: null,
//    );

    final inputDecoratoring = InputDecorator(
      decoration: const InputDecoration(
        icon: const Icon(Icons.color_lens),
        labelText: 'Color',
      ),
      isEmpty: _color == '',
      child: new DropdownButtonHideUnderline(
        child: new DropdownButton<String>(
          value: _color,
          isDense: true,
          onChanged: (String newValue) {
            setState(() {
              _color = newValue;
            });
          },
//          items:getDropDownMenuItems(),
          items: _colors.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
        ),
      ),
    );

//    final plusTextField = Text(
//        autofocus: false,
//        initialValue: '+',
//        decoration: InputDecoration(
//          contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
////        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//          border: UnderlineInputBorder(),
//        )

//    final codeTextFieldA = TextField(
//      controller: _controller,
//      onChanged: (String newVal) {
//        if(newVal.length <= 3){
//          text = newVal;
//        }else{
//          _controller.text = text;
//        }
////
////      },
//    );


    String text = "";
    int maxLength = 3;

    final codeTextField = TextField(
      keyboardType: TextInputType.number,
      controller: _controller,
      onChanged: (String newVal) {
          if(newVal.length <= maxLength){
            text = newVal;
          }else{
            _controller.value = new TextEditingValue(
                text: text,
                selection: new TextSelection(
                    baseOffset: maxLength,
                    extentOffset: maxLength,
                    affinity: TextAffinity.downstream,
                    isDirectional: false
                ),
                composing: new TextRange(
                    start: 0, end: maxLength
                )
            );
//            _controller.text = text;
          }

        },
      autofocus: false,
//      initialValue: '1',
      decoration: InputDecoration(
        hintText: '',
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
//        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        border: UnderlineInputBorder(),
      )
//        inputFormatters: [
//          LengthLimitingTextInputFormatter.digitsOnly,
//        ]
    );
    _controller.text = "3";


    final numberTextField = TextField(
        controller: _controllerPhone,
//        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'phone number',
          contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
//        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          border: UnderlineInputBorder(),
        )
//        inputFormatters: [
//          LengthLimitingTextInputFormatter.digitsOnly,
//        ]
    );


    final test = Container(
        child: Row(
            children: <Widget>[
//              Expanded(
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//
//                      codeTextField,
//                    ],
//                  ),
//              )
//        Expanded(
//
//              child:Container(
//                width: 30.0,
//                child: codeTextField,
//              )),
//              Text("+", textAlign: TextAlign.justify, ),
              new Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: new Text(
                      '+',
                      style: new TextStyle(
                        fontFamily: 'Roboto',
                      )
                  )
              ),
              Container(
                width: 60.0,
                child: codeTextField,
              ),
              SizedBox(width: 18.0),
              Container(
                width: 200.0,
                child: numberTextField,
              ),

            ],

        )

    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          shrinkWrap: true,
          children: <Widget>[
            title,
            SizedBox(height: 18.0),
//                new Expanded(cities,
//            c,
            Center(
              child: cities,
            ),
//                email,
//                SizedBox(height: 18.0),
//                password,
//                SizedBox(height: 18.0),
//                passwordConfirmation,
//                SizedBox(height: 18.0),
//                 countryCode,
            SizedBox(height: 18.0),
//            codeTextField,
            test,
            SizedBox(height: 18.0),
            loginButton,
            SizedBox(height: 38.0),
          ],
        )));
  }

//  validator: _validatePhoneNumber,
  String _validatePhoneNumber(String value) {
//    _formWasEdited = true;
    final RegExp phoneExp = new RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '(###) ###-#### - Enter a US phone number.';
    return null;
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }
}
