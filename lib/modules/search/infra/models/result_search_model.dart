import 'dart:convert';

import 'package:search_github/modules/search/domain/entities/result_search.dart';

class ResultSearchModel implements ResultSearch {
  @override
  final String avatarUrl;
  @override
  final String login;
  @override
  final String url;

  ResultSearchModel({
    required this.avatarUrl,
    required this.login,
    required this.url,
  });

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      avatarUrl: map['avatar_url'] ?? '',
      login: map['login'] ?? '',
      url: map['url'] ?? '',
    );
  }

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
