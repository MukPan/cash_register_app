import 'package:cash_register_app/database/paid_num_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StandbyNumList extends HookConsumerWidget {
  const StandbyNumList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paidNumListAsyVal = ref.watch(paidNumListProvider);


    return paidNumListAsyVal.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString()),
      data: (event) {
        //データベースから注文番号リストの取得
        final List<int> paidOrderNums = event.snapshot.children //親：orderNums
            .map((childSnapshot) => int.parse(childSnapshot.key ?? "0")) //132, 134...
            .toList();



        return Column(
          children: [
            //見出し
            Container(
              width: double.infinity,
              color: Colors.grey,
              child: const Text(
                "お作り中の番号",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 55,
                  color: Colors.white,
                ),
              ),
            ),
            //注文番号一覧
            Expanded(
              child: ListView.separated(
                itemCount: paidOrderNums.length + 1,
                separatorBuilder: (context, index) => const Divider(height: 0),
                itemBuilder: (context, index) {
                  if (index == paidOrderNums.length) return Container();
                  return Center(
                    child: Text(
                      paidOrderNums[index].toString(),
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      }
    );

    // return standbyNumListStream.when(
    //   loading: () => const CircularProgressIndicator(),
    //   error: (error, stackTrace) => Text(error.toString()),
    //   data: (standbyNumList) {
    //     return ListView.separated(
    //       itemCount: standbyNumList.length + 2,
    //       separatorBuilder: (context, index) => const Divider(height: 0),
    //       itemBuilder: (context, index) {
    //         if (index == standbyNumList.length + 1) return Container();
    //         if (index == 0) {
    //           return Container(
    //             width: double.infinity,
    //             color: Colors.grey,
    //             child: const Text(
    //               "お作り中の番号",
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 fontSize: 55,
    //                 color: Colors.white,
    //               ),
    //             ),
    //           );
    //         }
    //         index--; //タイトルの分
    //         return Center(
    //           child: Text(
    //             standbyNumList[index].toString(),
    //             style: const TextStyle(
    //                 fontSize: 45,
    //                 fontWeight: FontWeight.bold
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   }
    // );
  }
}
