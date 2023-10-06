import 'package:cash_register_app/provider/navigation_selected_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../context/category_grid.dart';
import '../context/category_navigation_rail.dart';


///注文追加(メニュー)ダイアログ
void addOrderMenuDialog(BuildContext context, WidgetRef ref) {
  //画面サイズ取得
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("商品の追加"), //商品名
        content: SizedBox(
          width: screenWidth * 0.9, //9割のサイズ
          height: screenHeight * 0.7, //7割のサイズ
          child: Row(
            children: [
              //商品カテゴリ選択ナビゲーション
              const CategoryNavigationRail(),
              //メニューリスト
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: CategoryGrid(),
                )
              )
            ],
          ),
        ),
        actions: [
          //閉じるボタンいる？
        ],
      );
    },
  );
}


// import 'package:cash_register_app/provider/navigation_selected_index_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../context/category_grid.dart';
// import '../context/category_navigation_rail.dart';
//
//
// ///注文編集ダイアログ
// void addEditOrderDialog(BuildContext context, WidgetRef ref) {
//   //画面サイズ取得
//   final screenWidth = MediaQuery.of(context).size.width;
//   final screenHeight = MediaQuery.of(context).size.height;
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       //選択されているindex
//       final int selectedCategoryIndex = ref.watch(navigationSelectedIndexProvider);
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         title: const Text("商品の追加"), //商品名
//         content: SizedBox(
//           width: screenWidth * 0.7, //7割のサイズ
//           height: screenHeight * 0.7, //7割のサイズ
//           child: Row(
//             children: [
//               //商品カテゴリ選択ナビゲーション
//               const CategoryNavigationRail(),
//               //メニューリスト
//               Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.all(20),
//                     child: CategoryGrid(),
//                   )
//               )
//             ],
//           ),
//         ),
//         actions: [
//           // OrderUpdateBtn(
//           //   columnIndex: columnIndex,
//           //   targetOptInfoList: targetOptInfoList,
//           //
//           // ),
//         ],
//       );
//     },
//   );
// }