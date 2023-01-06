import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_github/modules/search/presenter/search/search_bloc.dart';
import 'package:search_github/modules/search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Github Search"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => bloc.add(TextChanged(text: value)),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Search")),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, snapshot) {
                final state = bloc.state;

                if (state is SearchStart) {
                  return const Center(
                    child: Text("Digite um nome"),
                  );
                }
                if (state is SearchError) {
                  return const Center(
                    child: Text("Houve um erro"),
                  );
                }
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final list = (state as SearchSuccess).list;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final item = list[id];
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(item.avatarUrl)),
                        title: Text(item.login),
                        subtitle: Text(item.url),
                      );
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}
