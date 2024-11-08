import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Data List with Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff70a9fe),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: ApiDataScreen(),
    );
  }
}

class ApiDataScreen extends StatefulWidget {
  @override
  _ApiDataScreenState createState() => _ApiDataScreenState();
}

class _ApiDataScreenState extends State<ApiDataScreen> {
  List<dynamic> _data = [];

  List<dynamic> _filteredData = [];

  bool _isLoading = true;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _fetchData();

    _searchController.addListener(_filterData);
  }

  Future<void> _fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> fetchedData = json.decode(response.body);

      setState(() {
        _data = fetchedData;

        _filteredData = fetchedData;

        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });

      throw Exception('Failed to load data');
    }
  }

  void _filterData() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredData = _data.where((item) {
        final title = item['title'].toString().toLowerCase();

        return title.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fetching API Data List & Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Type to search...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredData.isEmpty
                    ? Center(
                        child: Text("No results found",
                            style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: _filteredData.length,
                        itemBuilder: (context, index) {
                          final item = _filteredData[index];

                          return Card(
                            margin: EdgeInsets.only(bottom: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(12.0),
                              title: Text(
                                item['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  item['body'],
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
