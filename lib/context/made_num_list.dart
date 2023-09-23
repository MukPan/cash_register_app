import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../database/made_num_list_provider.dart';

class MadeNumList extends HookConsumerWidget {
  const MadeNumList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final madeNumListStream = ref.watch(madeNumListProvider);

    return madeNumListStream.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString()),
      data: (event) {
        //データベースから注文番号リストの取得
        final List<int> madeOrderNums = event.snapshot.children //親：orderNums
            .map((childSnapshot) => int.parse(childSnapshot.key ?? "0")) //132, 134...
            .toList();

        return ListView.separated(
          itemCount: madeOrderNums.length + 2,
          separatorBuilder: (context, index) => const Divider(height: 0),
          itemBuilder: (context, index) {
            if (index == madeOrderNums.length + 1) return Container();
            if (index == 0) {
              return Container(
                width: double.infinity,
                color: Colors.indigo,
                child: const Text(
                  "受取待ち番号",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 55,
                    color: Colors.white,
                  ),
                ),
              );
            }
            index--; //タイトルの分
            print(madeOrderNums[index]);
            return Center(
              child: Text(
                madeOrderNums[index].toString(),
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        );
      }
    );

    // return completedNumListStream.when(
    //     loading: () => const CircularProgressIndicator(),
    //     error: (error, stackTrace) => Text(error.toString()),
    //     data: (completedNumList) {
    //       return ListView.separated(
    //         itemCount: completedNumList.length + 2,
    //         separatorBuilder: (context, index) => const Divider(height: 0),
    //         itemBuilder: (context, index) {
    //           if (index == completedNumList.length + 1) return Container();
    //           if (index == 0) {
    //             return Container(
    //               width: double.infinity,
    //               color: Colors.indigo,
    //               child: const Text(
    //                 "受取待ち番号",
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   fontSize: 55,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             );
    //           }
    //           index--; //タイトルの分
    //           print(completedNumList[index]);
    //           return Center(
    //             child: Text(
    //               completedNumList[index].toString(),
    //               style: const TextStyle(
    //                   fontSize: 45,
    //                   fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     }
    // );
  }
}
