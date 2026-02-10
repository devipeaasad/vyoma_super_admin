import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ManageBannersPage extends StatefulWidget {
  const ManageBannersPage({super.key});

  @override
  State<ManageBannersPage> createState() => _ManageBannersPageState();
}

class _ManageBannersPageState extends State<ManageBannersPage> {
  final List<File> _banners = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _addBanner() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _banners.add(File(image.path));
      });
    }
  }

  void _removeBanner(int index) {
    setState(() {
      _banners.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Banners"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBanner,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: _banners.isEmpty
            ? const Center(
                child: Text(
                  "No banners added yet",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : GridView.builder(
                itemCount: _banners.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _banners[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 18,
                            ),
                            onPressed: () => _removeBanner(index),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
