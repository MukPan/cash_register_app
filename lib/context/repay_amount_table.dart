import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RepayAmountTable extends HookConsumerWidget {
  const RepayAmountTable({Key? key}) : super(key: key);

  ///動的にお釣りの枚数データを設置する
  // List<DataRow> _getRepayCountRows(WidgetRef ref) {
  //   return denominationInfoList.reversed
  //       .where((info) => ref.read(changeMoneyCountFamily(info.denominationType)) != 0) //0枚をリストから除外
  //       .map((info) {
  //     final int changeCount = ref.read(changeMoneyCountFamily(info.denominationType));
  //     return DataRow(
  //         cells: [
  //           DataCell(Text(info.name, style: const TextStyle(fontSize: 20))), //金種
  //           DataCell(
  //               Container(
  //                 margin: const EdgeInsets.all(3),
  //                 width: 70,
  //                 child: Image.asset(info.imagePath),
  //               )
  //           ), //image
  //           DataCell(Text(changeCount.toString(), style: const TextStyle(fontSize: 20))), //枚数
  //         ]
  //     );
  //   })
  //       .toList();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text("nu");
      // SizedBox(
      //   width: double.infinity,
      //   height: double.infinity,
      //   child: DataTable(
      //     headingRowHeight: 30,
      //     columns: const [
      //       DataColumn(label: Text("金種")),
      //       DataColumn(label: Text("")),
      //       DataColumn(label: Text("枚数")),
      //     ],
      //     rows: _getRepayCountRows(ref)
      // )
    // );
  }
}
