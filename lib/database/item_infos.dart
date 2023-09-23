
//インスタンス初期化
import 'package:firebase_database/firebase_database.dart';

//インスタンス初期化
final db2 = FirebaseDatabase.instance;
//グローバル変数に設定
final ItemInfos itemInfos = ItemInfos();

class ItemInfos {
  ///商品名と価格を関連付けるMap ex.{"たこ焼き": 300, ...}
  late Map<String, int> itemPriceMap; //Map<String, int>

  ///メソッドが呼び出されたタイミングで参照用データを初期化する
  void fetchData() {
    db2.ref("items/")
        .onValue
        .listen((event) {
          // final itemsListSnap =  as Map<String, dynamic>;
          final itemsListSnap = event.snapshot.children; //{たこ焼き: {}, ポテト: {}...
          //Mapの初期化
          itemPriceMap = {};
          for (final itemSnap in itemsListSnap) {
            final String itemName = itemSnap.key ?? ""; //たこ焼き
            final int itemPrice = (itemSnap.value as Map<String, dynamic>)["price"]; //300
            itemPriceMap.addAll({itemName: itemPrice});
          }
          print("itemInfos初期化完了");
          print(itemPriceMap);
        });
  }
}