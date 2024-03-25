import 'package:flutter/material.dart';
import 'package:store_app/constants/API_URLS.dart';
import 'package:store_app/models/ProductM.dart';
import 'package:store_app/models/VendorsM.dart';
import 'package:store_app/services/GetProducts.dart';
import 'package:store_app/services/GetVendors.dart';
import 'package:store_app/services/WebSocketNotification.dart';
import 'package:store_app/widgets/AllProducts.dart';
import 'package:store_app/widgets/AppBarSearch.dart';
import 'package:store_app/widgets/HomeScreenWidget.dart';
import 'package:store_app/services/GetCategories.dart';
import 'package:store_app/models/CategoriesM.dart';
import 'package:store_app/widgets/VendorHome.dart';

class HomeScreen extends StatelessWidget {
  final WebSocketNotificationService notificationService =
      WebSocketNotificationService();

  Future<void> _initializeNotifications() async {
    await notificationService.connect(); // Connect to WebSocket
  }

  @override
  Widget build(BuildContext context) {
    _initializeNotifications();
    return Scaffold(
      appBar: AppBar(
        title: AppBarSearch(),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: CategotyService().getAllCategories(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CategoryModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                      ),
                    );
                  } else {
                    final categories = snapshot.data;
                    return HomeWidget(categories: categories!);
                  }
                },
              ),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: VendorService().GetAllVendors(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<VendorModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                      ),
                    );
                  } else {
                    final vendor = snapshot.data;
                    return VendorHomeWidget(vendor: vendor!);
                  }
                },
              ),
            ),
          ];
        },
        body: FutureBuilder<List<ProductsModel>>(
          future: ProductService().getAllProducts(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductsModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                ),
              );
            } else {
              final product = snapshot.data;
              return ProductHomeWidget(product: product!);
            }
          },
        ),
      ),
    );
  }
}
