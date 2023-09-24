
//インスタンス初期化
import 'package:firebase_database/firebase_database.dart';

//インスタンス初期化
final db2 = FirebaseDatabase.instance;
//グローバル変数に設定
final OptInfos optInfos = OptInfos();

///オプション群単体のデータベースからのデータ
class OptInfos {
  ///オプション名と価格を関連付ける
  late Map<String, int> optPriceMap; //Map<String, int>

  ///メソッドが呼び出されたタイミングで参照用データを初期化する
  void fetchData() async {
    db2.ref("options/")
        .onValue
        .listen((event) {
      // final optsListSnap =  as Map<String, dynamic>;
      final optsListSnap = event.snapshot.children; //{たこ焼き: {}, ポテト: {}...
      //Mapの初期化
      optPriceMap = {};
      for (final optSnap in optsListSnap) {
        final String optName = optSnap.key ?? ""; //たこ焼き
        final int optPrice = (optSnap.value as Map<String, dynamic>)["price"]; //300
        optPriceMap.addAll({optName: optPrice});
      }
      print("optInfos初期化完了");
      print(optPriceMap);
    });
  }
}