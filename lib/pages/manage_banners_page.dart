import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ManageBannersPage extends StatefulWidget {
  const ManageBannersPage({super.key});

  @override
  State<ManageBannersPage> createState() => _ManageBannersPageState();
}

class _ManageBannersPageState extends State<ManageBannersPage> {
  final List<File> banners = [];
  final ImagePicker picker = ImagePicker();

  /// ADD BANNER
  Future<void> addBanner() async {
    final picked =
        await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        banners.add(File(picked.path));
      });
    }
  }

  /// DELETE BANNER
  void deleteBanner(int index) {
    setState(() {
      banners.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Banners"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addBanner,
        child: const Icon(Icons.add),
      ),

      body: banners.isEmpty
          ? const Center(
              child: Text(
                "No Banners Added Yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: banners.length,
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
                        banners[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),

                    /// DELETE BUTTON
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () => deleteBanner(index),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
