import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/api_dataModel.dart';

class api_one extends StatefulWidget {
  @override
  State<api_one> createState() => _api_example_screenState();
}

class _api_example_screenState extends State<api_one> {
  late Future<List<api_dataModel>> apiData;
  String url = 'https://jsonplaceholder.typicode.com/posts';

  @override
  void initState() {
    super.initState();
    // Fetch API data when the widget is first created.
    apiData = get_api_data();
  }

  Future<List<api_dataModel>> get_api_data() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      List<api_dataModel> results = [];
      for (Map i in data) {
        results.add(api_dataModel.fromJson(i));
      }
      return results;
    } else {
      throw Exception('Failed to load data');
    }
  }

  int currentPage = 1;
  int itemsPerPage = 10;

  List<api_dataModel> currentPageItems(List<api_dataModel> allData) {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return allData.sublist(
      startIndex,
      endIndex < allData.length ? endIndex : allData.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Api 1 example"),
        ),
        body: FutureBuilder<List<api_dataModel>>(
          future: apiData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                  child: Text(
                      'Error loading data. Make sure you have Internet connection'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              final allData = snapshot.data!;
              final currentPageItemsList = currentPageItems(allData);

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentPageItemsList.length,
                      itemBuilder: (context, index) {
                        var item = currentPageItemsList[index];
                        return Card(
                          color: Colors.white,
                          elevation: 2,
                          shadowColor: Colors.black,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              item.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 19),
                            ),
                            subtitle: Text(
                              item.body!,
                              maxLines: 3,
                            ),
                            leading: Text(
                              item.id.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Page $currentPage'),
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: currentPage > 1
                            ? () {
                                setState(() {
                                  currentPage--;
                                });
                              }
                            : null,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed:
                            currentPage < (allData.length / itemsPerPage).ceil()
                                ? () {
                                    setState(() {
                                      currentPage++;
                                    });
                                  }
                                : null,
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ));
  }
}
