// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'GetVpoint.dart';

void showErrorDialog(String error, BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('title'),
        content: Text(error),
        actions: <Widget>[
          TextButton(
            child: Text('Done'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  );
}

GetVpoint getVpoint = GetVpoint();
Future showSuccessDialog(
    BuildContext context, String success, set_id_user) async {
  await getVpoint.get_count(set_id_user);

  return AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.info,
      showCloseIcon: false,
      title: "You paid successfuly",
      autoHide: Duration(seconds: 5),
      btnOkOnPress: () {
        Navigator.pop(context);
      },
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      onDismissCallback: (type) {
        Navigator.pop(context);
      }).show();
}
