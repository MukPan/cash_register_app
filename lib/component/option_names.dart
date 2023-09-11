import 'package:cash_register_app/object/option_object.dart';
import 'package:flutter/cupertino.dart';


class OptionNames extends StatelessWidget {
  const OptionNames({Key? key, required this.optList}) : super(key: key);

  ///オプションリスト
  final List<OptionObject> optList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, //TODO: いる？
      physics: const NeverScrollableScrollPhysics(),
      itemCount: optList.length,
      //Widget返却
      itemBuilder: (BuildContext context, int optIndex) {
        return Text(
          optList[optIndex].optionName,
          style: const TextStyle(
              fontSize: 15.0,
              color: CupertinoColors.systemGrey
          ),
        );
      },
    );
  }
}
