import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cat_facts_api.g.dart';

@RestApi(baseUrl: 'https://cat-fact.herokuapp.com/')
abstract class CatFactsApi {
  factory CatFactsApi(Dio dio, {String? baseUrl}) = _CatFactsApi;

  @GET('/facts/random')
  Future<CatFact> getRandomFact();
}

@JsonSerializable()
class CatFact {
  final String text;
  final String createdAt;

  CatFact({required this.text, required this.createdAt});

  factory CatFact.fromJson(Map<String, dynamic> json) =>
      _$CatFactFromJson(json);

  Map<String, dynamic> toJson() => _$CatFactToJson(this);
}
