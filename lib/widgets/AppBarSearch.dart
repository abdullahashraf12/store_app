import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:store_app/constants/API_URLS.dart';

class AppBarSearch extends StatefulWidget {
  const AppBarSearch({Key? key}) : super(key: key);

  @override
  _AppBarSearchState createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  String dropdownValue = ''; // Default dropdown value
  List<Map<String, dynamic>> dropdownItems = []; // List of dropdown items

  @override
  void initState() {
    super.initState();
    // Fetch dropdown items from service
    fetchDropdownItems();
  }

  Future<void> fetchDropdownItems() async {
    try {
      final response = await Dio().get(ApiUrls.getAllCategoriesUrl);
      if (response.statusCode == 200) {
        setState(() {
          dropdownItems = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              iconSize: 30,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: '',
                  child: Text(
                    'All Categories',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ...dropdownItems.map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item['id'].toString(),
                    child: Text(item['title'].toString()),
                  );
                }).toList(),
              ],
            ),
          ),

          Container(
            width: 100, // Adjust the width according to your need
            padding: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[200],
            ),
            child: TextField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Search Here',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          // Add some space between text field and search icon
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
    );
  }
}
