import 'package:cash_register_app/object/denomination_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/cash_count_family.dart';

class CashCountTable extends HookConsumerWidget {
  const CashCountTable({Key? key}) : super(key: key);

  ///動的にキャッシュカウントデータを設置する
  List<DataRow> _getCashCountDataRows(WidgetRef ref) {
    return denominationInfoList.map((infoObj) {
        final int count = ref.watch(cashCountFamily(infoObj.denominationType));
        return DataRow(
            cells: [
              DataCell(Text(infoObj.name)), //金種
              DataCell(Text(count.toString())), //枚数
              DataCell(Text((infoObj.amount*count).toString())), //金額
            ]
        );
      })
      .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width / 2, //画面の半分
      margin: const EdgeInsets.all(30),
      child: DataTable(
        columns: const [
          DataColumn(label: Text("金種")),
          DataColumn(label: Text("枚数")),
          DataColumn(label: Text("金額")),
        ],
        rows: _getCashCountDataRows(ref),
      )
    );
  }
}
