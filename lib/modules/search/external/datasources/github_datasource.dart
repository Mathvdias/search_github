import 'package:dio/dio.dart';
import 'package:search_github/modules/search/infra/datasources/search_datasource.dart';
import 'package:search_github/modules/search/infra/models/result_search_model.dart';

class GithubDatasource implements SearchDataSource {
  final Dio dio;

  GithubDatasource(this.dio);
  @override
  Future<List<ResultSearchModel>> searchText(String textSearch) async {
    var url =
        "https://api.github.com/search/users?q=${textSearch.trim().replaceAll(' ', '+')}";
    var result = await dio.get(url);
    if (result.statusCode == 200) {
      var jsonList = result.data['items'] as List;
      var list = jsonList
          .map((item) => ResultSearchModel(
              url: item['url'],
              avatarUrl: item['avatar_url'],
              login: item['login']))
          .toList();
      return list;
    } else {
      return throw Exception();
    }
  }
}
