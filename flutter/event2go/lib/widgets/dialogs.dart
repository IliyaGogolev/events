import 'package:event2go/utils/extensions.dart';
import 'package:flutter/material.dart';

Future<bool> showDialogAsync(BuildContext context,
    String? title,
    String content,
    String positiveButtonText,
    String? negativeButtonText) async {
  return await showDialog<bool>(
      context: context,
      builder: (context) {
        return showAlertDialog(context,
            title,
            content,
            positiveButtonText,
            negativeButtonText);
      }) ?? false;
}

AlertDialog showAlertDialog(BuildContext context,
    String? title,
    String content,
    String positiveButtonText,
    String? negativeButtonText,
    ) {
  return AlertDialog(
    title: createTextViewIfNotNull(title),
    content: Text(content),
    actions: [
      createTextButtonIfNotNull(context, positiveButtonText, true),
      createTextButtonIfNotNull(context, negativeButtonText, false),
    ].notNulls().cast<Widget>(),
  );
}

createTextButtonIfNotNull(BuildContext context, String? negativeButtonText, bool popResult) {
  if(negativeButtonText == null) {
    return null;
  }
  return TextButton(
      onPressed: () {
        Navigator.of(context).pop(popResult);
      },
      child: Text(negativeButtonText),
    );
}

createTextViewIfNotNull(String? title) {
  if (title != null) {
    return Text(title);
  } else {
    return null;
  }
}