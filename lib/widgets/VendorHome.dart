import 'package:flutter/material.dart';
import 'package:store_app/constants/API_URLS.dart';
import 'package:store_app/models/VendorsM.dart'; // Import your models file or wherever your Category class is defined

class VendorHomeWidget extends StatelessWidget {
  final List<VendorModel> vendor;

  const VendorHomeWidget({Key? key, required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'By Vendors',
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
            itemCount: vendor.length,
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
                        '${ApiUrls.fullUrl}/media/${vendor[index].image}',
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
                          vendor[index].title,
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
    );
  }
}
