import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:req/Controller/Api%20Service.dart';
import 'package:req/color.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductListView extends StatelessWidget {
  final List<String> images = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/images3.jpeg',
    'assets/images4.jpeg',
    'assets/images5.jpeg',
  ];
  final List<String> tabImages = [
    'assets/tab1.jpg',
    'assets/tab2.jpg',
    'assets/tab3.jpeg',
    'assets/tab4.jpeg',
    'assets/tab5.jpg',
    //'assets/tab_image6.jpg',
  ];

  final List<String> tabTexts = [
    'Fruits',
    'Vegetables',
    'Diary',
    'Bread',
    'Spicy',
    //'',
  ];
  final List<String> productPrices = [
    '\$2.00',
    '\$1.00',
    '\$3.00',
    '\$1.50',
    '\$5.00',
  ];
  final List<String> discoveries = [
    'assets/chicken.jpg',
    'assets/beef.jpg',
  ];
  final List<String> productnames = ['Chicken Broiler', 'Beef  Tendorion'];
  String searchQuery = '';

  ProductListView({super.key});
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    // Fetch products if not already loaded

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40, left: 10),
                      child: Text(
                        "Good day!",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ),
                    // Add image here
                    Padding(
                      padding: const EdgeInsets.only(top: 34),
                      child: Image.asset(
                        'assets/hands.png', // Provide the path to your image asset
                        height: h * 0.04,
                        width: w * 0.09,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: w * 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.black, // Change icon color if needed
                          ),
                        ),
                      ),
                    )
                  ],

                  // child: Expanded(
                  //   child: productProvider.products.isEmpty
                  //       ? CircularProgressIndicator()
                  //       : GridView.builder(
                  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2, // Number of columns in the grid
                  //             crossAxisSpacing: 10.0, // Spacing between columns
                  //             mainAxisSpacing: 10.0, // Spacing between rows
                  //             childAspectRatio:
                  //                 0.75, // Aspect ratio (width / height) of each item
                  //           ),
                  //           itemCount: productProvider.products.length,
                  //           itemBuilder: (context, index) {
                  //             return GridTile(
                  //               child: Card(
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Image.network(
                  //                         productProvider.products[index].image,
                  //                         fit: BoxFit.cover,
                  //                         errorBuilder: (context, error, stackTrace) {
                  //                           return Placeholder(); // Placeholder widget or error message
                  //                         },
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         productProvider.products[index].name,
                  //                         style: TextStyle(fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding:
                  //                           const EdgeInsets.symmetric(horizontal: 8.0),
                  //                       child: Text(
                  //                         'Price: \$${productProvider.products[index].price}',
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  // ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Container(
                  height: h * 0.067,
                  width: w * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.35), // Shadow color
                        spreadRadius: 1, // Spread radius
                        blurRadius: 30, // Blur radius
                        offset: const Offset(0, 2), // Offset of the shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    onChanged: (val) {
                      // setState(() {
                      searchQuery = val;
                      //
                      //});
                    },
                    style: TextStyle(
                      fontSize: w * 0.045,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.secondarytextColor,
                      ),

                      hintText: 'Search grocery',
                      hintStyle: TextStyle(
                          color: AppColors.secondarytextColor,
                          height: h * 0.0019,
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w300),
                      border: InputBorder.none,
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: AppColors.cardColor),
                      //   borderRadius: BorderRadius.circular(100.0),
                      // ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                          ));
                    },
                  );
                }).toList(),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 40, left: 20),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50.0, // Adjust height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle tab selection
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          height: h * 0.20,
                          width: w * 0.30, // Adjust width as needed
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                tabImages[index],
                                width: 20.0, // Adjust image size as needed
                                height: 30.0,
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                tabTexts[index],
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 20),
                  child: Text(
                    "Discoveries",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              // Container boxes section
              Padding(
                padding:
                    EdgeInsets.only(top: 1, left: 20, right: 10, bottom: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 2, // Number of container boxes
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              // Image
                              Align(
                                alignment: Alignment.center,
                                child: Expanded(
                                  child: Image.asset(
                                    discoveries[index],
                                    height: h * 0.09,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Heart icon
                              const Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name
                                Text(
                                  productnames[index],
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),

                                // Price
                                Text(
                                  productPrices[index],
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Plus button
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: h * 0.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  // Handle plus button tap
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Consumer<ProductProvider>(
          builder: (context, provider, _) {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Customers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.production_quantity_limits_sharp),
                  label: 'Products',
                ),
              ],
              currentIndex: provider.selectedIndex ??
                  0, // Provide a default value if selectedIndex is null
              selectedItemColor: Colors.blue,
              onTap: (int index) {
                provider.changeSelectedIndex(index);
              },
            );
          },
        ),
      ),
    );
  }
}
