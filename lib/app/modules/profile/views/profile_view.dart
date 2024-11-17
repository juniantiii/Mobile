import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:myapp/app/modules/alamat_saya/views/alamat_saya_view.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image; // Untuk menyimpan gambar yang dipilih
  File? _video; // Untuk menyimpan video yang dipilih
  VideoPlayerController? _videoPlayerController;

  Future<void> _pickMedia() async {
    final picker = ImagePicker();
    // Menampilkan opsi modal bawah
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Ambil Gambar dari Kamera'),
              onTap: () async {
                Navigator.pop(context); // Tutup modal
                final pickedFile =
                    await picker.getImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                    _video = null; // Reset video jika ada
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Pilih Gambar dari Galeri'),
              onTap: () async {
                Navigator.pop(context); // Tutup modal
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                    _video = null; // Reset video jika ada
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Ambil Video dari Kamera'),
              onTap: () async {
                Navigator.pop(context); // Tutup modal
                final pickedFile =
                    await picker.getVideo(source: ImageSource.camera);
                if (pickedFile != null) {
                  _loadVideo(File(pickedFile.path));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text('Pilih Video dari Galeri'),
              onTap: () async {
                Navigator.pop(context); // Tutup modal
                final pickedFile =
                    await picker.getVideo(source: ImageSource.gallery);
                if (pickedFile != null) {
                  _loadVideo(File(pickedFile.path));
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _loadVideo(File videoFile) {
    setState(() {
      _video = videoFile;
      _image = null; // Reset gambar jika ada
      _videoPlayerController
          ?.dispose(); // Dispose jika ada controller sebelumnya
      _videoPlayerController = VideoPlayerController.file(_video!)
        ..initialize().then((_) {
          setState(() {}); // Untuk memastikan video ter-update
          _videoPlayerController!.setLooping(true);
          _videoPlayerController!.play(); // Mulai memutar video
        });
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose(); // Membersihkan controller video
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Akun Saya',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: _pickMedia, // Trigger media picker on tap
            child: ClipOval(
              child: Container(
                width: 80, // Diameter lingkaran
                height: 80,
                color: Colors.grey[300],
                child: _video != null
                    ? (_videoPlayerController != null &&
                            _videoPlayerController!.value.isInitialized
                        ? AspectRatio(
                            aspectRatio:
                                _videoPlayerController!.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController!),
                          )
                        : CircularProgressIndicator()) // Jika video belum siap
                    : (_image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          )),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('U & I', style: TextStyle(fontSize: 18)),
          SizedBox(height: 30),
          ListTile(
            title: Text('Pesanan Saya'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Ganti dengan halaman Pesanan Anda
            },
          ),
          Divider(),
          ListTile(
            title: Text('Voucher'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Ganti dengan halaman Voucher Anda
            },
          ),
          Divider(),
          ListTile(
            title: Text('Alamat Saya'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(() => AlamatsayaPage());
            },
          ),
          Divider(),
          ListTile(
            title: Text('FAQ'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Ganti dengan halaman FAQ Anda
            },
          ),
          Divider(),
          ListTile(
            title: Text('Pengaturan'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Ganti dengan halaman Pengaturan Anda
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        backgroundColor: Color(0xFF8B4513), // Warna coklat
        selectedItemColor: Colors.black54, // Warna item yang dipilih
        unselectedItemColor: Colors.white, // Warna item yang tidak dipilih
        onTap: (index) {
          // Handle navigation on tap
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
      ),
    );
  }
}
