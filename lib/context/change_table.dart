import 'package:cash_register_app/provider/change_money_count_family.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../object/denominations.dart';

class ChangeTable extends HookConsumerWidget {
  const ChangeTable({Key? key}) : super(key: key);

  ///動的にお釣りの枚数データを設置する
  List<DataRow> _getChangeCountRows(WidgetRef ref) {
    return denominationInfoList.reversed
        .where((info) => ref.read(changeMoneyCountFamily(info.denominationType)) != 0) //0枚をリストから除外
        .map((info) {
          final int changeCount = ref.read(changeMoneyCountFamily(info.denominationType));
          return DataRow(
              cells: [
                DataCell(Text(info.name, style: const TextStyle(fontSize: 20))), //金種
                DataCell(
                  Container(
                    margin: const EdgeInsets.all(3),
                    width: 70,
                    child: Image.asset(info.imagePath),
                  )
                ), //image
                DataCell(Text(changeCount.toString(), style: const TextStyle(fontSize: 20))), //枚数
              ]
          );
        })
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (denominationInfoList.any((info) => ref.read(changeMoneyCountFamily(info.denominationType)) != 0))
      ? SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: DataTable(
          columns: const [
            DataColumn(label: Text("金種")),
            DataColumn(label: Text("image")),
            DataColumn(label: Text("枚数")),
          ],
          rows: _getChangeCountRows(ref)
      ),
    ) : Container();
  }
}
