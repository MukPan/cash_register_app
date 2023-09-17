import 'package:cash_register_app/object/denomination_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../object/denominations.dart';
import '../provider/cash_count_family.dart';
import '../provider/is_editting_total_family.dart';
import '../provider/sales_count_family.dart';

final db = FirebaseFirestore.instance;

class CashCountTable extends HookConsumerWidget {
  const CashCountTable({Key? key}) : super(key: key);


  ///金額にカンマを挿入するメソッド
  String _amountFormat(num amount) {
    return NumberFormat("#,###").format(amount);
  }

  ///金額を判定して色を付けるメソッド
  Color _getAmountColor(num amount) {
    if (amount < 0) return Colors.red;
    if (amount == 0) return Colors.black;
    return Colors.blue;
  }

  ///動的にキャッシュカウントデータを設置する
  List<DataRow> _getCashCountDataRows(WidgetRef ref) {
    //合計金額を算出
    num totalAmount = denominationInfoList
        .map((info) => info.amount * ref.read(cashCountFamily(info.denominationType)) )
        .reduce((sum, amount) => sum + amount);

    //合計売上額を算出
    num totalSalesAmount = denominationInfoList
        .map((info) => info.amount * ref.read(salesCountFamily(info.denominationType)))
        .reduce((sum, amount) => sum + amount);
    
    return denominationInfoList.map((info) {
        final int count = ref.watch(cashCountFamily(info.denominationType));
        final int salesCount = ref.read(salesCountFamily(info.denominationType));
        //編集中が有効か
        final bool isEdittingTotal = ref.watch(isEdittingTotalFamily(info.denominationType));
        return DataRow(
            cells: [
              DataCell(Text(info.name)), //金種
              DataCell(
                  (isEdittingTotal)
                    ? TextField(
                      controller: TextEditingController(text: count.toString()), //初期値
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, //数字のみ
                        LengthLimitingTextInputFormatter(6), //入力制限数
                      ],
                      onSubmitted: (newTotalCountStr) {
                        int newTotalCount = int.parse(newTotalCountStr);
                        //新しい値にプロバイダー更新
                        ref.read(cashCountFamily(info.denominationType).notifier)
                            .state = newTotalCount;
                        //TextFieldを閉じる
                        ref.read(isEdittingTotalFamily(info.denominationType).notifier)
                            .state = false;
                        //データベース更新
                        db.collection("moneyCountCollection")
                          .doc("moneyCountDoc")
                          .get()
                          .then((docRef) {
                            docRef.reference.update({
                              "totalCountMap.${info.name}": newTotalCount
                            });
                          });
                      }
                    )
                    : Text(count.toString()),
                  onDoubleTap: () {
                    //編集中プロバイダー更新
                    ref.read(isEdittingTotalFamily(info.denominationType).notifier)
                        .state = true;
                  }
              ), //枚数
              DataCell(Text(_amountFormat(info.amount*count))), //金額
              DataCell(Text(salesCount.toString(),
                  style: TextStyle(color: _getAmountColor(salesCount)))), //売上枚数
              DataCell(Text(_amountFormat(info.amount*salesCount),
                  style: TextStyle(color: _getAmountColor(info.amount*salesCount)))), //売上額
            ]
        );
      })
      .toList()
    ..add(DataRow(
        cells: [
          const DataCell(Text("")),
          const DataCell(Text("")),
          DataCell(Text(_amountFormat(totalAmount))),
          const DataCell(Text("")),
          DataCell(Text(_amountFormat(totalSalesAmount),
              style: TextStyle(color: _getAmountColor(totalSalesAmount)))),
        ]));
  }


  ///累計枚数を編集する

  ///売上枚数を編集する

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text("金種")),
            DataColumn(label: Text("枚数")),
            DataColumn(label: Text("金額")),
            DataColumn(label: Text("売上枚数")),
            DataColumn(label: Text("売上額")),
          ],
          rows: _getCashCountDataRows(ref),
        ),
      )
    );
  }
}
