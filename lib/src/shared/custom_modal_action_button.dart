import 'package:firebase_authentication_with_flutter/src/shared/custom_button.dart';
import 'package:flutter/material.dart';

class CustomModalActionButton extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSave;

  const CustomModalActionButton({
    Key key,
    @required this.onClose,
    @required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomButton(
          onPressed: onClose,
          buttonText: 'Close',
        ),
        CustomButton(
          onPressed: onSave,
          buttonText: 'Save',
          textColor: Colors.white,
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}
