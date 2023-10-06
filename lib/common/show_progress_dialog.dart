import 'package:flutter/material.dart';

import '../component/default_circular_progress_indicator.dart';

///ローディングを表示するメソッド
void showProgressDialog(context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 500), // これを入れると遅延を入れなくて
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const DefaultCircularProgressIndicator();
    },
  );
}

///ローディングを閉じるメソッド
void closeProgressDialog(context) {
  //ローディング終了
  if (context.mounted) {
    Navigator.of(context).pop();
  }
}