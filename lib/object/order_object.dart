import 'option_object.dart';

class OrderObject {
  OrderObject({
    this.itemName = "",
    this.itemPrice = 0,
    this.itemQty = 1,
    this.optionList = const <OptionObject>[],
  });

  ///商品名
  final String itemName;
  ///値段
  final int itemPrice;
  ///個数
  final int itemQty;
  ///オプションリスト
  final List<OptionObject> optionList;
}
