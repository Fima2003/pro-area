import 'package:hive/hive.dart';
import '../api/cat_facts_api.dart';

part 'cat_fact_hive.g.dart';

@HiveType(typeId: 0)
class CatFactHive extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  String createdAt;

  CatFactHive({required this.text, required this.createdAt});

  static CatFactHive fromApi(CatFact catFact) {
    return CatFactHive(
      text: catFact.text,
      createdAt: catFact.createdAt,
    );
  }
}
