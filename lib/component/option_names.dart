import 'package:cash_register_app/object/option_object.dart';
import 'package:flutter/cupertino.dart';

import '../database/opt_infos.dart';


class OptionNames extends StatelessWidget {
  const OptionNames({Key? key, required this.optNameList}) : super(key: key);

  ///オプション名前リスト
  final List<String> optNameList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, //TODO: いる？
      physics: const NeverScrollableScrollPhysics(),
      itemCount: optNameList.length,
      //Widget返却
      itemBuilder: (BuildContext context, int index) {
        final String optName = optNameList[index];
        // final int optPrice = optInfos.optPriceMap[optName] ?? 0;
        return Text(
          optName,
          style: const TextStyle(
              fontSize: 15.0,
              color: CupertinoColors.systemGrey
          ),
        );
      },
    );
  }
}
