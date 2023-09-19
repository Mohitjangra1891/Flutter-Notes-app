import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/api_dataModel.dart';

class api_three extends StatefulWidget {
  @override
  State<api_three> createState() => _api_example_screenState();
}

class _api_example_screenState extends State<api_three> {
  List<api_three_dataModel> api_results = [];
  String url = 'https://jsonplaceholder.typicode.com/users';

  Future<List<api_three_dataModel>> get_api_data() async {
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        api_results
            .add(api_three_dataModel.fromJson(i as Map<String, dynamic>));
      }
      return api_results;
    } else {
      return api_results;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api 3 example"),
      ),
      body: FutureBuilder(
        future: get_api_data(),
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
            return ListView.builder(
              itemCount: api_results.length,
              itemBuilder: (context, index) {
                var item = api_results[index];
                return Card(
                    color: Colors.white,
                    elevation: 2,
                    shadowColor: Colors.black,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('id : ${item.id}\n'
                              'name : ${item.name}\n'
                              'username : ${item.username}\n'
                              'eamil : ${item.email}\n'
                              'phone : ${item.phone}\n'
                              'address : ${item.address?.suite},${item.address?.street},${item.address?.city},${item.address?.zipcode}'),
                        )
                      ],
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
