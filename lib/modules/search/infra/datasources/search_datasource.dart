import 'package:search_github/modules/search/infra/models/result_search_model.dart';

abstract class SearchDataSource {
  Future<List<ResultSearchModel>>searchText(String textSearch);
}
