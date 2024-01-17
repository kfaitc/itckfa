import 'package:flutter/material.dart';
import 'package:itckfa/screen/components/search/detail_searching.dart';

class verbal_Search extends SearchDelegate {
  verbal_Search({required this.name, required this.type});

  List name;
  List type;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close),)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),);
  }

  @override
  Widget buildResults(BuildContext context) {
    return detail_searching(
      set_data_verbal: query.toString(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List result = name.where((element) {
      return element.contains(query.toString());
    }).toList();
    return ListView.builder(
      itemCount: query == "" ? name.length : result.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            query = query == "" ? name[i].toString() : result[i].toString();
            // print(query);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => detail_searching(
                  set_data_verbal: query.toString(),
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 5, color: Colors.grey),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: query == ""
                ? Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(name[i].toString()),
                      trailing: Text(type[i].toString()),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(result[i].toString()),
                      trailing: Text(type[i].toString()),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
