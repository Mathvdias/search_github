import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:search_github/app_widget.dart';
import 'package:search_github/modules/search/domain/usecases/search_by_text.dart';
import 'package:search_github/modules/search/external/datasources/github_datasource.dart';
import 'package:search_github/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:search_github/modules/search/presenter/search/search_bloc.dart';
import 'package:search_github/modules/search/presenter/search/search_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GithubDatasource(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
       ChildRoute('/', child: (_, __) => const SearchPage()),
      ];

  Widget get bootstrap => const AppWidget();
}
