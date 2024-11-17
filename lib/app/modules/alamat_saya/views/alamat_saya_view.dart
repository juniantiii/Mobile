import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MaterialApp(
    home: AlamatsayaPage(),
  ));
}

class AlamatsayaPage extends StatefulWidget {
  @override
  _AlamatsayaPageState createState() => _AlamatsayaPageState();
}

class _AlamatsayaPageState extends State<AlamatsayaPage> {
  final CollectionReference addressesCollection =
      FirebaseFirestore.instance.collection('addresses');

  List<Map<String, dynamic>> addresses = [];

  @override
  void initState() {
    super.initState();
    fetchAddresses(); // Fetch addresses from Firestore
  }

  // Fetch addresses with document ID
  void fetchAddresses() async {
    QuerySnapshot snapshot = await addressesCollection.get();
    setState(() {
      addresses = snapshot.docs.map((doc) {
        return {
          'id': doc.id, // Store document ID
          ...doc.data() as Map<String, dynamic>
        };
      }).toList();
    });
  }

  Future<void> addAddress(String name, String phone, String address) async {
    Map<String, dynamic> newAddress = {
      'name': name,
      'phone': phone,
      'address': address,
      'label': 'Lainnya',
    };
    await addressesCollection.add(newAddress); // Send to Firestore
    fetchAddresses(); // Refresh addresses
  }

  Future<void> editAddress(String id, String name, String phone, String address) async {
    Map<String, dynamic> updatedAddress = {
      'name': name,
      'phone': phone,
      'address': address,
      'label': 'Lainnya',
    };
    await addressesCollection.doc(id).update(updatedAddress); // Update Firestore
    fetchAddresses(); // Refresh addresses
  }

  Future<void> deleteAddress(String id) async {
    await addressesCollection.doc(id).delete(); // Delete from Firestore
    fetchAddresses(); // Refresh addresses
  }

  void showAddressDialog({int? index}) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    String? currentId;

    if (index != null) {
      nameController.text = addresses[index]['name']!;
      phoneController.text = addresses[index]['phone']!;
      addressController.text = addresses[index]['address']!;
      currentId = addresses[index]['id']; // Get the document ID
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Tambah Alamat' : 'Edit Alamat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'No. Telepon'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              if (index == null) {
                addAddress(nameController.text, phoneController.text, addressController.text);
              } else {
                editAddress(currentId!, nameController.text, phoneController.text, addressController.text);
              }
              Navigator.pop(context);
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Alamat Saya'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Detail Alamat"),
                    content: Text(
                      '${address['name']} | ${address['phone']}\n${address['address']}',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Tutup"),
                      ),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${address['name']} | ${address['phone']}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      address['address']!,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF8B4513),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            address['label']!,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => showAddressDialog(index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteAddress(address['id']!), // Use document ID for deletion
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddressDialog();
          },
          backgroundColor: Color(0xFF8B4513),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
