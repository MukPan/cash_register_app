import 'package:cash_register_app/object/denomination_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../object/denominations.dart';
import '../provider/cash_count_family.dart';
import '../provider/sales_count_family.dart';

class CashCountTable extends HookConsumerWidget {
  const CashCountTable({Key? key}) : super(key: key);

  ///金額にカンマを挿入するメソッド
  String _amountFormat(num amount) {
    return NumberFormat("#,###").format(amount);
  }

  ///金額を判定して色を付けるメソッド
  TextStyle _getAmountColor(num amount) {
    if (amount < 0) return const TextStyle(color: Colors.red);
    if (amount == 0) return const TextStyle(color: Colors.black);
    return const TextStyle(color: Colors.blue);
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
        final int count = ref.read(cashCountFamily(info.denominationType));
        final int salesCount = ref.read(salesCountFamily(info.denominationType));
        return DataRow(
            cells: [
              DataCell(Text(info.name)), //金種
              DataCell(Text(count.toString())), //枚数
              DataCell(Text(_amountFormat(info.amount*count))), //金額
              DataCell(Text(salesCount.toString(), style: _getAmountColor(salesCount))), //売上枚数
              DataCell(Text(_amountFormat(info.amount*salesCount), style: _getAmountColor(info.amount*salesCount))), //売上額
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
          DataCell(Text(_amountFormat(totalSalesAmount), style: _getAmountColor(totalSalesAmount))),
        ]));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: DataTable(
        columns: const [
          DataColumn(label: Text("金種")),
          DataColumn(label: Text("枚数")),
          DataColumn(label: Text("金額")),
          DataColumn(label: Text("売上枚数")),
          DataColumn(label: Text("売上額")),
        ],
        rows: _getCashCountDataRows(ref),
      )
    );
  }
}
