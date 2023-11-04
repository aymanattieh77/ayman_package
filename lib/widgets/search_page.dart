import 'package:ayman_package/logs/logs.dart';
import 'package:flutter/material.dart';

class SearchPage extends SearchDelegate {
  SearchPage()
      : super(
          searchFieldLabel: "Sea",
        );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return query.isEmpty
        ? [const SizedBox()]
        : [
            IconButton(
                onPressed: () {
                  query = "";
                },
                icon: const Icon(Icons.close))
          ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.red,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  void showResults(BuildContext context) {
    logSuccess("msg");
  }

  @override
  void showSuggestions(BuildContext context) {
    logSuccess("showSuggestions");
  }
}
