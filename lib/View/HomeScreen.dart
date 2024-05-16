import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:req/Controller/cartprovider.dart';

import 'package:req/View/Customer.dart';
import 'package:req/View/cartpage.dart';
import 'package:req/View/productsscreen.dart';
import 'package:req/Widgets/navigationbar.dart';
import 'package:req/color.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  ];

  final List<String> tabTexts = [
    'Fruits',
    'Vegetables',
    'Diary',
    'Bread',
    'Spicy',
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
  late List<bool> isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = List.generate(discoveries.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34),
                    child: Image.asset(
                      'assets/hands.png',
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
                      child: Consumer<Cart>(
                        builder: (context, cart, _) {
                          int totalItemsInCart = cart.getItems.length;
                          return IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartPage()));
                            },
                            icon: Stack(
                              children: [
                                Icon(Icons.shopping_cart),
                                if (totalItemsInCart > 0)
                                  Positioned(
                                    right: -3,
                                    top: -2,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 8,
                                      child: Text(
                                        totalItemsInCart.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
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
                  )
                ],
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
                      color: Colors.grey.withOpacity(0.35),
                      spreadRadius: 1,
                      blurRadius: 30,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  onChanged: (val) {
                    searchQuery = val;
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
                height: 50.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabImages.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        height: h * 0.20,
                        width: w * 0.30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              tabImages[index],
                              width: 20.0,
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
            Padding(
              padding: EdgeInsets.only(top: 1, left: 20, right: 10, bottom: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: discoveries.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider(
                    create: (context) => LikeProvider(isLiked[index]),
                    child: DiscoveryItem(
                      image: discoveries[index],
                      productName: productnames[index],
                      productPrice: productPrices[index],
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<NavigationProvider>(
        builder: (context, provider, _) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.man_2),
                label: 'Customers',
              ),
            ],
            selectedItemColor: Colors.blue,
            currentIndex: provider.selectedIndex ?? 0,
            onTap: (int index) {
              // Navigate to corresponding pages based on index
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Product(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerListScreen(),
                    ),
                  );
                  break;
                default:
                  break;
              }
            },
          );
        },
      ),
    );
  }
}

class LikeProvider extends ChangeNotifier {
  bool _isLiked;

  LikeProvider(this._isLiked);

  bool get isLiked => _isLiked;

  void toggleLike() {
    _isLiked = !_isLiked;
    notifyListeners();
  }
}

class DiscoveryItem extends StatelessWidget {
  final String image;
  final String productName;
  final String productPrice;
  final int index;

  const DiscoveryItem({
    required this.image,
    required this.productName,
    required this.productPrice,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LikeProvider>(
      builder: (context, provider, _) {
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
                  Align(
                    alignment: Alignment.center,
                    child: Expanded(
                      child: Image.asset(
                        image,
                        height: MediaQuery.of(context).size.height * 0.09,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      onPressed: () {
                        final likeProvider =
                            Provider.of<LikeProvider>(context, listen: false);
                        likeProvider.toggleLike();
                      },
                      icon: Icon(
                        provider.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: provider.isLiked ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      productPrice,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: IconButton(
                    onPressed: () {},
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
    );
  }
}
