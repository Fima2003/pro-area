import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'api/cat_facts_api.dart';
import 'logic/bloc/cat_fact_bloc.dart';
import 'models/cat_fact_hive.dart';
import 'pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CatFactHiveAdapter());
  await Hive.openBox<CatFactHive>('catFacts');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CatFactsApi api = CatFactsApi(Dio());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Facts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => CatFactBloc(api),
        child: HomePage(),
      ),
    );
  }
}
