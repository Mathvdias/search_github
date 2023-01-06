import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_github/modules/search/external/datasources/github_datasource.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = Dio();
  final datasource = GithubDatasource(dio);
  test('deve retornar uma lista de ResultSearchModel...', () async {
    final future = await datasource.searchText("matheus");
    //expect(future, isA<List<ResultSearchModel>>());
    expect(future[1].login, "matheusbattisti");
  });
}
