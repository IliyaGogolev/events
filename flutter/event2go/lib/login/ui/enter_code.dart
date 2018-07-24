import 'package:event2go/login/data/countries.dart';
import 'package:event2go/login/domain/SendPhoneNumberUseCase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/gestures.dart';
//https://medium.com/@boldijar.paul/comboboxes-in-flutter-cabc9178cc95

class EnterSmsCodeWidget extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final SendPhoneNumberUseCase domain = new SendPhoneNumberUseCase();

  EnterSmsCodeWidget({Key key, this.phoneNumber, this.verificationId})
      : super(key: key);

  @override
  EnterSmsCodeState createState() => new EnterSmsCodeState();
}

class EnterSmsCodeState extends State<EnterSmsCodeWidget> {
  String _selectedCountryCode;

  var domain = new SendPhoneNumberUseCase();

  TextEditingController _controllerCode = new TextEditingController();
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
//    _dropDownMenuItems = getDropDownMenuItems();
//    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var titleRichText = new RichText(
      textAlign: TextAlign.center,
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: new TextStyle(
          fontSize: 16.0,
          color: Colors.black,

        ),
        children: <TextSpan>[
          new TextSpan(text: 'We just sent you activation code to \n'),
          new TextSpan(text: '${widget.phoneNumber}', style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: ' Wrong Number? ', style: new TextStyle(color: Colors.blue),
              recognizer: new TapGestureRecognizer()
              ..onTap = () => _handleWrongNumberTap(context),

          ),
        ],
      ),
    );

    var title = new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        titleRichText
      ],
    );

    int codeMaxLength = 6;
    String codeText;

    final codeTextField = TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: _controllerCode,
        onChanged: (String newVal) {
          if(newVal.length > codeMaxLength){
            _controllerCode.value = new TextEditingValue(
                text: codeText,
                selection: new TextSelection(
                    baseOffset: codeMaxLength,
                    extentOffset: codeMaxLength,
                    affinity: TextAffinity.downstream,
                    isDirectional: false
                ),
                composing: new TextRange(
                    start: 0, end: codeMaxLength
                )
            );
          } else {
            codeText = newVal;
          }

        },
        autofocus: false,
        decoration: InputDecoration(
          hintText: '',
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
//        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          border: UnderlineInputBorder(),
        ),
        style: new TextStyle(
          fontSize: 30.0,
          fontFamily: 'Roboto',
          color: new Color(0xFF26C6DA),
        )


//        inputFormatters: [
//          LengthLimitingTextInputFormatter.digitsOnly,
//        ]
    );
//    _controllerCode.text = "123456";

    var codeTextHint = new RichText(
      textAlign: TextAlign.center,
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
        ),
        children: <TextSpan>[
          new TextSpan(text: 'Enter 6-digit code')
        ],
      ),
    );


    final codeTextContainer = Container(
      width: 130.0,
      child: codeTextField,
    );


    var verifyButton = new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new OutlineButton(
//          borderSide: BorderSide(width: 2.0),
            child: Text('Verifye Me'),
            color: Colors.blue,
            borderSide: new BorderSide(color: Colors.indigo, width: 2.0),
            onPressed: (() {
              onVerifyCodeButtonClicked();
            }))
      ],
    );


    var resendCodeButton = new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new MaterialButton(
//          borderSide: BorderSide(width: 2.0),
            child: Text('Resend SMS'),
//            color: Colors.blue,
            textColor: Colors.green,
//            borderSide: new BorderSide(color: Colors.green, width: 2.0),
            onPressed: (() {
              print("Resend sms / code");
              onResendSmsButtonClicked();
            })),

      ],
    );

// todo    https://stackoverflow.com/questions/47065098/how-work-with-progress-indicator-in-flutter

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              shrinkWrap: true,
              children: <Widget>[
                   title,
                  SizedBox(height: 18.0),
                   Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        codeTextContainer,
                        SizedBox(height: 10.0),
                        codeTextHint
                      ]
                   ),
                  SizedBox(height: 17.0),
                   verifyButton,
                   SizedBox(height: 28.0),
                  resendCodeButton,
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _controllerCode.dispose();
    super.dispose();
  }

  void onResendSmsButtonClicked() {
    var phoneNumber = widget.phoneNumber;
    phoneNumber = phoneNumber.replaceAll("(", "");
    phoneNumber = phoneNumber.replaceAll(")", "");
    phoneNumber = phoneNumber.replaceAll("-", "");
    phoneNumber = phoneNumber.replaceAll(" ", "");
    print("phone number: $phoneNumber");
    domain.testVerifyPhoneNumber(phoneNumber);
  }

  _handleWrongNumberTap(BuildContext context) {
      Navigator.of(context).pop();
  }

  void onCodeEntered() {
    domain.sendCode(widget.verificationId, _controllerCode.text);
  }

  void onVerifyCodeButtonClicked() {
    domain.sendCode(widget.verificationId, _controllerCode.text);
  }


}
