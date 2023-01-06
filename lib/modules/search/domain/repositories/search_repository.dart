import 'package:multiple_result/multiple_result.dart';

import '../entities/result_search.dart';
import '../errors/errors.dart';

abstract class SearchRepository {
  Future<Result<List<ResultSearch>, Failure>> search(String searchText);
}
