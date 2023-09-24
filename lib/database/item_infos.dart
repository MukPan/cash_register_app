import 'package:firebase_database/firebase_database.dart';

//グローバル変数に設定
final ItemInfos itemInfos = ItemInfos();

//インスタンス初期化
final db2 = FirebaseDatabase.instance;

///DBからの読込や
///商品の参照用オブジェクトをリストを保持する役割を担うクラス
class ItemInfos {
  ///商品参照用オブジェクトのリスト
  final List<ItemInfo> _itemInfoList = [];
  ///DBからの読込が完了しているか
  bool _isFetched = false;

  ///DBから初期データを1回読み込む
  Future<void> fetchData() async {
    //オプションデータの読込を先に行う
    //オプション名とオプションインスタンスを結びつける
    final Map<String, OptInfo> optNameToOptInfo = {};
    final optListEvent = await db2.ref("options/").once();
    final optListSnap = optListEvent.snapshot.children; //{焼きチーズ: {}, ソース: {}...

    for (final optSnap in optListSnap) {
      final String optName = optSnap.key ?? ""; //焼きチーズ
      final int optPrice = (optSnap.value as Map<String, dynamic>)["price"]; //100
      optNameToOptInfo.addAll({optName: OptInfo(
          optName: optName,
          optPrice: optPrice
      )});
    }

    //次に商品データの読込
    final itemListEvent = await db2.ref("items/").once();
    final itemListSnap = itemListEvent.snapshot.children; //{たこ焼き: {}, ポテト: {}...

    for (final itemSnap in itemListSnap) {
      final String itemName = itemSnap.key ?? ""; //たこ焼き
      final int itemPrice = (itemSnap.value as Map<String, dynamic>)["price"]; //300
      final String category = (itemSnap.value as Map<String, dynamic>)["category"]; //food
      //TODO: 配列が0のときの挙動を確かめる
      final List<String> optNameList = (((itemSnap.value as Map<String, dynamic>)["options"] ?? [])  //["焼きチーズ","ソース",...]
      as List<dynamic>)
          .map((e) => e.toString())
          .toList();

      final List<OptInfo> optInfoList = optNameList
          .map((optName) => optNameToOptInfo[optName] ?? OptInfo(optName: "", optPrice: 0))
          .toList();

      _itemInfoList.add(ItemInfo(
          itemName: itemName,
          itemPrice: itemPrice,
          category: category,
          optInfoList: optInfoList
      ));
    }


    //読み取り可能に
    _isFetched = true;
    print("itemInfos初期化完了");
  }

  ///参照用リストを返す
  List<ItemInfo> getList() {
    //フェッチ未完了の場合を弾く
    if (!_isFetched) return [];

    return _itemInfoList;
  }
}


///商品参照用オブジェクト
class ItemInfo {
  ItemInfo({
    required this.itemName,
    required this.itemPrice,
    required this.category,
    required this.optInfoList
  });

  ///商品名
  final String itemName;
  ///カテゴリ
  final String category;
  ///(オプションなしの)価格
  final int itemPrice;
  ///選択可能なオプションのリスト
  final List<OptInfo> optInfoList;
}

///オプション参照用オブジェクト
class OptInfo {
  OptInfo({required this.optName, required this.optPrice});
  ///オプション名
  final String optName;
  ///オプション価格
  final int optPrice;
}