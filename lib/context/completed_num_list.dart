import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/completed_num_list_provider.dart';

class CompletedNumList extends HookConsumerWidget {
  const CompletedNumList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedNumListStream = ref.watch(completedNumListProvider);

    return completedNumListStream.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text(error.toString()),
        data: (completedNumList) {
          return ListView.separated(
            itemCount: completedNumList.length + 2,
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemBuilder: (context, index) {
              if (index == completedNumList.length + 1) return Container();
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
              print(completedNumList[index]);
              return Center(
                child: Text(
                  completedNumList[index].toString(),
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
  }
}
