import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:money_magnet/widgets/pages/search/search.dart';
import 'package:money_magnet/widgets/pages/search/slidable_list_tile.dart';

import '../ViewAll/view_all.dart';

class SearchTiles extends StatelessWidget {
  const SearchTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: overViewListNotifier,
      builder: (context, newList, child) {
        return newList.isEmpty
            ? Center(
                child: Image.asset(
                'lib/assets/images/output-onlinegiftools (2).gif',
                height: 200,
                width: 200,
              ))
            : Padding(
                padding: const EdgeInsets.all(20),
                child: ValueListenableBuilder(
                  builder: (context, value, child) => ListView.separated(
                    itemBuilder: (context, index) {
                      // log("buuildd");
                      // transactionModel transaction = newList[index];
                      return SlidableTransaction(transaction: value[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                    itemCount: Showlist.value.length,
                  ),
                  valueListenable: Showlist,
                ),
              );
      },
    );
  }
}

String parseDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}
