import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({Key? key, required this.title, this.showBackBtn = true}) : super(key: key);

  ///上部のページタイトル
  final String title;
  ///戻るボタン表示
  final bool showBackBtn;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: showBackBtn,
      shape: const Border(
          bottom: BorderSide(color: Colors.grey)
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}