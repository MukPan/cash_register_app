import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/amount_per_item_provider.dart';
import '../provider/item_count_provider.dart';

class SubtotalInEditting extends HookConsumerWidget {
  const SubtotalInEditting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qty = ref.watch(itemCountProvider);
    final amountPerItem = ref.watch(amountPerItemProvider);
    final subtotal = qty * amountPerItem;
    return Text(
      "$subtotal円",
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }
}
