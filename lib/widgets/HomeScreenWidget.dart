import 'package:flutter/material.dart';
import 'package:store_app/constants/API_URLS.dart';
import 'package:store_app/models/CategoriesM.dart';
import 'package:store_app/models/ProductM.dart';
import 'package:store_app/models/VendorsM.dart'; // Import your models file or wherever your Category class is defined

class HomeWidget extends StatelessWidget {
  final List<CategoryModel> categories;

  const HomeWidget({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'By Categories',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: 140,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          '${ApiUrls.fullUrl}/media/${categories[index].image}',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Text(
                            categories[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
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
