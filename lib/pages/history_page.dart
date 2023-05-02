import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/cat_fact_hive.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fact History'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<CatFactHive>('catFacts').listenable(),
        builder: (context, Box<CatFactHive> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text('No facts saved yet.'),
            );
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              CatFactHive catFact = box.getAt(index)!;
              DateFormat dateFormat =
                  DateFormat.yMMMMd(Localizations.localeOf(context).toString());
              String formattedDate =
                  dateFormat.format(DateTime.parse(catFact.createdAt));

              return ListTile(
                title: Text(catFact.text),
                subtitle: Text('Fact created on: $formattedDate'),
              );
            },
          );
        },
      ),
    );
  }
}
