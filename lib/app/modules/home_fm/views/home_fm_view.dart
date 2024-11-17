import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/brandfm1/views/brandfm1_view.dart';
import 'package:myapp/app/modules/brandfm2/views/brandfm2_view.dart';
import 'package:myapp/app/modules/brandhm1/views/brandhm1_view.dart';
import 'package:myapp/app/modules/brandms1/views/brandms1_view.dart';
import 'package:myapp/app/modules/brandvindys1/views/brandvindys1_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/profile/views/profile_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';

class HomeFmView extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    // Sample products
    {
      'image': 'assets/ForMen AF 101 Sepatu Loafers Kulit.png',
      'name': 'ForMen AF 101 Sepatu Loafers Kulit',
      'price': 'Rp. 301.175',
      'rating': 5.0
    },
    {
      'image': 'assets/ForMen AF 104 Sepatu Loafers Kulit.png',
      'name': 'ForMen AF 104 Sepatu Loafers Kulit',
      'price': 'Rp. 450.000',
      'rating': 4.8
    },
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/Logo.png', height: 60),
            SizedBox(width: 0),
            Text(
              'rajasepatukulit',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
  Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: GestureDetector(
      child: Icon(
        Icons.account_circle,
        color: Colors.purple,
        size: 40,
      ),
      onTap: () {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(100, 80, 0, 0),
          items: [
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Log out'),
                ],
              ),
            ),
          ],
          elevation: 8.0,
        ).then((value) {
          if (value == 'logout') {
            SystemNavigator.pop();
          }
        });
      },
    ),
  ),
],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Section
            buildBannerSection(),
            SizedBox(height: 16),
            // Brand Title
            buildBrandTitle('Brand ForMen'),
            // Brand Logos Section
            buildBrandLogoSection(),
            SizedBox(height: 16),
            // Product Grid Section
            buildProductGrid(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBannerSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildBanner('New Brand Men Style ForMen', 'assets/ForMen AF 101 Sepatu Loafers Kulit.png', 'Beli Sekarang'),
            SizedBox(width: 20),
            buildBanner('New Brand Women Style Mr.Show', 'assets/Mr.Show 501 Sepatu Formal Kulit.png', 'Beli Sekarang'),
            SizedBox(width: 20),
            buildBanner('New Brand Men Style HandyMen', 'assets/Handymen 204 Sepatu Formal Kulit.png', 'Beli Sekarang'),
            SizedBox(width: 20),
            buildBanner('New Brand Women Style Vindys', 'assets/Vindys Lawender 502 Mid Heels Formal Shoes.png', 'Beli Sekarang'),
          ],
        ),
      ),
    );
  }

  Widget buildBrandTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildBrandLogoSection() {
    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          brandLogo('All', 'assets/Logo All Brand.png', logoSize: 20),
          brandLogo('Hm', 'assets/Logo Brand Hm.png', logoSize: 20),
          brandLogo('Fm', 'assets/Logo Brand Fm.png', logoSize: 20),
          brandLogo('Mr.Show', 'assets/Logo Brand Ms.png', logoSize: 20),
          brandLogo('Vindys', 'assets/Logo Brand Vs.png', logoSize: 20),
        ],
      ),
    );
  }

  Widget buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return productCard(
            products[index]['image'],
            products[index]['name'],
            products[index]['price'],
            products[index]['rating'],
          );
        },
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      backgroundColor: Color(0xFF8B4513),
      selectedItemColor: Colors.black54,
      unselectedItemColor: Colors.white,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.to(AllbrandView());
            break;
          case 1:
            Get.to(PencarianView());
            break;
          case 2:
            Get.to(KeranjangView());
            break;
          case 3:
            Get.to(WishlistView());
            break;
          case 4:
            Get.to(ProfileView());
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget productCard(String imagePath, String name, String price, double rating) {
    return GestureDetector(
      onTap: () {
        if (name == 'ForMen AF 101 Sepatu Loafers Kulit') {
          Get.to(Brandfm1View());
        } else if (name == 'ForMen AF 104 Sepatu Loafers Kulit') {
          Get.to(Brandfm2View());
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(imagePath, height: 100, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(price, style: TextStyle(color: Colors.grey)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 14),
                Text(rating.toString(), style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build brand banner
Widget buildBanner(String title, String imagePath, String buttonText) {
  return Expanded(
    child: Container(
      height: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF8B4513),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 80, width: 80),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the corresponding product detail page
                  if (title.contains('ForMen')) {
                    Get.to(Brandfm1View());
                  } else if (title.contains('Mr.Show')) {
                    Get.to(Brandms1View());
                  } else if (title.contains('HandyMen')) {
                    Get.to(Brandhm1View());
                  } else if (title.contains('Vindys')) {
                    Get.to(Brandvindys1View());
                  }
                },
                child: Text(buttonText), // Tombol "Beli Sekarang" di sini
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


  Widget brandLogo(String name, String imagePath, {double logoSize = 30}) {
    return GestureDetector(
      onTap: () {
        if (name == 'All') {
          Get.to(AllbrandView());
        } else if (name == 'Hm') {
          Get.to(Brandhm1View());
        } else if (name == 'Fm') {
          Get.to(Brandfm1View());
        } else if (name == 'Mr.Show') {
          Get.to(Brandms1View());
        } else if (name == 'Vindys') {
          Get.to(Brandvindys1View());
        }
      },
     child: Center(
        // Centering the entire brand logo widget
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center, // Center the logo inside the container
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Circular shape
              border: Border.all(
                  color: Color(0xFF8B4513), width: 2), // Thinner border
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: logoSize * 1.0, // Ensure logo size
            ),
          ),
        ),
      ),
    );
  }
}
