import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({Key? key, required this.title}) : super(key: key);

  ///上部のページタイトル
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      surfaceTintColor: Colors.white,
      shape: const Border(
          bottom: BorderSide(color: Colors.grey)
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}