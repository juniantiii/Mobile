import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/brandfm1/views/brandfm1_view.dart';
import 'package:myapp/app/modules/brandfm2/views/brandfm2_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/profile/views/profile_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';
import 'package:myapp/app/modules/pencarian/controllers/pencarian_controller.dart';

class PencarianView extends StatefulWidget {
  const PencarianView({Key? key}) : super(key: key);

  @override
  _PencarianViewState createState() => _PencarianViewState();
}

class _PencarianViewState extends State<PencarianView> {
  final PencarianController controller = Get.put(PencarianController());
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(
      onError: (error) => debugPrint('Speech Error: $error'),
      onStatus: (status) => debugPrint('Speech Status: $status'),
    );
    if (!available) {
      debugPrint('Speech recognition not available');
    }
  }

  void _startListening() async {
    if (!_isListening) {
      await _speech.listen(
        localeId: 'id_ID', // Bahasa Indonesia
        onResult: (result) {
          setState(() {
            controller.searchTextController.text = result.recognizedWords;
          });
        },
      );
      setState(() {
        _isListening = true;
      });
    }
  }

  void _stopListening() async {
    if (_isListening) {
      await _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchTextController,
                    decoration: InputDecoration(
                      hintText: 'Search ForMen AF',
                      hintStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fillColor: const Color(0xFF8B4513), // Warna coklat
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.brown,
                  ),
                  onPressed: _isListening ? _stopListening : _startListening,
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Hasil Pencarian',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildProductItem(
                    'ForMen AF 101 Sepatu Loafers Kulit',
                    'Rp. 302.175',
                    '5.0',
                    'assets/ForMen AF 101 Sepatu Loafers Kulit.png', () {
                  Get.to(Brandfm1View());
                }),
                _buildProductItem(
                    'ForMen AF 104 Sepatu Loafers Kulit',
                    'Rp. 302.175',
                    '5.0',
                    'assets/ForMen AF 104 Sepatu Loafers Kulit.png', () {
                  Get.to(Brandfm2View());
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1, // Mengatur indeks pada Search
        backgroundColor: const Color(0xFF8B4513), // Warna coklat
        selectedItemColor: Colors.black54, // Warna item yang dipilih
        unselectedItemColor: Colors.white, // Warna item yang tidak dipilih
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
        items: const [
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
      ),
    );
  }

  Widget _buildProductItem(String title, String price, String rating,
      String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 80,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(price, style: const TextStyle(color: Colors.brown)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 14),
                Text(rating),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
