// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:auth/auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterfire_ui/auth.dart';
// import '../widgets/universal_button.dart';
// import '../widgets/title.dart';
//
// typedef SMSCodeRequestedCallback = void Function(
//   BuildContext context,
//   AuthAction? action,
//   Object flowKey,
//   String phoneNumber,
// );
//
// typedef PhoneNumberSubmitCallback = void Function(String phoneNumber);
//
// class PhoneInputView extends StatefulWidget {
//   final FirebaseAuth? auth;
//   final AuthAction? action;
//   final Object flowKey;
//   final SMSCodeRequestedCallback? onSMSCodeRequested;
//   final PhoneNumberSubmitCallback? onSubmit;
//   final WidgetBuilder? subtitleBuilder;
//   final WidgetBuilder? footerBuilder;
//
//   const PhoneInputView({
//     Key? key,
//     required this.flowKey,
//     this.onSMSCodeRequested,
//     this.auth,
//     this.action,
//     this.onSubmit,
//     this.subtitleBuilder,
//     this.footerBuilder,
//   }) : super(key: key);
//
//   @override
//   State<PhoneInputView> createState() => _PhoneInputViewState();
// }
//
// class _PhoneInputViewState extends State<PhoneInputView> {
//   final phoneInputKey = GlobalKey<PhoneInputState>();
//
//   PhoneNumberSubmitCallback onSubmit(PhoneAuthController ctrl) =>
//       (String phoneNumber) {
//         if (widget.onSubmit != null) {
//           widget.onSubmit!(phoneNumber);
//         } else {
//           ctrl.acceptPhoneNumber(phoneNumber);
//         }
//       };
//
//   void _next(PhoneAuthController ctrl) {
//     final number = PhoneInput.getPhoneNumber(phoneInputKey);
//     if (number != null) {
//       onSubmit(ctrl)(number);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final l = FlutterFireUILocalizations.labelsOf(context);
//     final countryCode = Localizations.localeOf(context).countryCode;
//
//     // return AuthFlowBuilder(
//     return AuthControllerProvider(
//         action: AuthAction.signIn,
//         child: Material(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Center(
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                           CustomTitle(text: l.phoneVerificationViewTitleText),
//                           const SizedBox(height: 24),
//                           if (widget.subtitleBuilder != null)
//                             widget.subtitleBuilder!(context),
//                           // if (state is AwaitingPhoneNumber || state is SMSCodeRequested)
//                           ...[
//                             PhoneInput(
//                               initialCountryCode: countryCode!,
//                               // onSubmit: onSubmit(ctrl),
//                               key: phoneInputKey,
//                             ),
//                             const SizedBox(height: 16),
//                             UniversalButton(
//                               text: l.verifyPhoneNumberButtonText,
//                               // onPressed: () => _next(ctrl),
//                             ),
//                             const Flexible(
//                                 child: FractionallySizedBox(
//                               heightFactor: 0.3,
//                             ))
//                           ],
//
//                           // if (state is AuthFailed) ...[
//                           //   const SizedBox(height: 8),
//                           //   ErrorText(exception: state.exception),
//                           //   const SizedBox(height: 8),
//                           // ],
//                           // if (widget.footerBuilder != null) widget.footerBuilder!(context),
//                         ])
//               ),
//             )
//         )
//     );
//   }
// }
