import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloseDialogBtn extends StatelessWidget {
  const CloseDialogBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(CupertinoIcons.xmark),
      ),
    );
  }
}
