import 'package:cash_register_app/provider/standby_num_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StandbyNumList extends HookConsumerWidget {
  const StandbyNumList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final standbyNumListStream = ref.watch(standbyNumListProvider);

    return standbyNumListStream.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString()),
      data: (standbyNumList) {
        return ListView.builder(
          itemCount: standbyNumList.length,
          itemBuilder: (context, index) {
            return Text(
              standbyNumList[index].toString(),
              style: const TextStyle(
                fontSize: 50,
              ),
            );
          },
        );
      }
    );
  }
}
