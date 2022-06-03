# event2go

A new Flutter application.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).


Issues I met: <br/>
<ul>
     <li>
        Routes didn't work - two MaterialApp used, had to remove one. 
     </li>
</ul>

Resources:
https://github.com/felangel/bloc/tree/master/packages/bloc
https://medium.com/flutter-community/flutter-bloc-for-beginners-839e22adb9f5

Modular:
https://github.com/Flutterando/modular
https://medium.com/flutter-community/mastering-flutter-modularization-in-several-ways-f5bced19101a

### Create Module
flutter create --template=package home
export `module.dart`
/Applications/flutter/bin/flutter pub get

# Firebase auth
https://stackoverflow.com/questions/65040615/firebase-authentication-phone-invalid-cert-hash
add sha1 & sha5 to
https://console.firebase.google.com/u/0/project/event2go-1234/settings/general/android:com.event2go.android


Issues:
Open issue - Exception `PhoneAuthFlow.verifySMSCode`:
https://github.com/firebase/flutterfire/issues/8016
