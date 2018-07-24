import 'package:event2go/login/data/countries.dart';
import 'package:event2go/login/domain/SendPhoneNumberUseCase.dart';
import 'package:event2go/login/ui/enter_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
//https://medium.com/@boldijar.paul/comboboxes-in-flutter-cabc9178cc95

class SignupWidget extends StatefulWidget {

  static String tag = 'signup-widget';

  var domain = new SendPhoneNumberUseCase();

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

  TextEditingController _controllerCode = new TextEditingController();
  TextEditingController _controllerPhone = new MaskedTextController(mask: '(000) 000-0000');
//  TextEditingController _controllerPhone = new TextEditingController();
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

    List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];

    String _color = '';

    final cities = new DropdownButton(
      value: _currentCity,
      items: _dropDownMenuItems,
      onChanged: changedDropDownItem,
    );

    final title =
        Text('Please confirm your country code and enter your phone number.',
          style: TextStyle(fontSize: 16.0),
        );


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
              onLoginButtonClicked();

              print("Signup button clicked");
            },
            color: Colors.lightBlueAccent,
            child: Text(
              'Send',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ));

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


    String text = "";
    int maxLength = 3;

    final codeTextField = TextField(
      keyboardType: TextInputType.number,
      controller: _controllerCode,
      onChanged: (String newVal) {
          if(newVal.length <= maxLength){
            text = newVal;
          }else{
            _controllerCode.value = new TextEditingValue(
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
        style: new TextStyle(
            fontSize: 18.0,
            color: Colors.black
        ),
      autofocus: false,
//      initialValue: '1',
      textAlign: TextAlign.center,
      decoration: InputDecoration(

        hintText: '',
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
//        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        border: UnderlineInputBorder(),
      )
//        inputFormatters: [
//          LengthLimitingTextInputFormatter.digitsOnly,
//        ]
    );
    _controllerCode.text = "1";


    final numberTextField = TextField(
        controller: _controllerPhone,
        keyboardType: TextInputType.number,
        autofocus: false,
        style: new TextStyle(
          fontSize: 18.0,
          color: Colors.black
        ),
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
    _controllerPhone.text = "408-555-6969";


    final inputRowContainer = Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: new Text(
                      '+',
                      style: new TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18.0
                      )
                  )
              ),
              Container(
                width: 50.0,
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

            SizedBox(height: 18.0),
            inputRowContainer,
            SizedBox(height: 18.0),
            loginButton,
            SizedBox(height: 38.0),
          ],
        )));
  }

//  validator: _validatePhoneNumber,
  String _validatePhoneNumber(String value) {
//    _formWasEdited = true;
//    final RegExp phoneExp = new RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
//    if (!phoneExp.hasMatch(value))
//      return '(###) ###-#### - Enter a US phone number.';

    final RegExp phoneExp = new RegExp("(\\+[0-9]+[\\- \\.]*)?"        // +<digits><sdd>*
        + "(\\([0-9]+\\)[\\- \\.]*)?"   // (<digits>)<sdd>*
        + "([0-9][0-9\\- \\.]+[0-9])"); // <digit><digit|sdd>+<digit>
    if (!phoneExp.hasMatch(value) || value.length <= 7)
      return 'Enter a valid phone number.';

    return null;
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _controllerCode.dispose();
    _controllerPhone.dispose();
    super.dispose();
  }

  void onLoginButtonClicked() {
    var formattedPhoneNumber = "+" + _controllerCode.text + " " + _controllerPhone.text;
    var phoneNumber = formattedPhoneNumber;
    phoneNumber = phoneNumber.replaceAll("(", "");
    phoneNumber = phoneNumber.replaceAll(")", "");
    phoneNumber = phoneNumber.replaceAll("-", "");
    phoneNumber = phoneNumber.replaceAll(" ", "");
    print("phone number: $phoneNumber");

    var error = _validatePhoneNumber(phoneNumber);
    if (error == null) {
      widget.domain.testVerifyPhoneNumber(phoneNumber);

      var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
          new EnterSmsCodeWidget(phoneNumber: formattedPhoneNumber,
              verificationId: widget.domain.verificationId)
      );

      Navigator.of(context).push(route);
    } else {
      _openNewInputPopup(error);
    }
  }

  void _openNewInputPopup(String text) {
    print("popup will open");

    AlertDialog dialog = new AlertDialog(
        content: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Text(text,
                style: new TextStyle(fontSize: 18.0),),
            ],
          ),
        ),

        actions: <Widget> [
          new FlatButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: new Text('Ok')),

        ]
    );


    showDialog(context: context, child: dialog);
  }

}
