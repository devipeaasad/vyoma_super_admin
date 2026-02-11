import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BannerModel {
  File image;
  String title;

  BannerModel({
    required this.image,
    required this.title,
  });
}

class ManageBannersPage extends StatefulWidget {
  const ManageBannersPage({super.key});

  @override
  State<ManageBannersPage> createState() => _ManageBannersPageState();
}

class _ManageBannersPageState extends State<ManageBannersPage> {
  final List<BannerModel> banners = [];
  final ImagePicker picker = ImagePicker();

  /// Add Banner
  Future<void> addBanner() async {
    final titleController = TextEditingController();
    File? selectedImage;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Banner"),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return SingleChildScrollView(
                child: Column(
                  children: [

                    /// Image Picker
                    GestureDetector(
                      onTap: () async {
                        final picked = await picker.pickImage(
                            source: ImageSource.gallery);
                        if (picked != null) {
                          setDialogState(() {
                            selectedImage = File(picked.path);
                          });
                        }
                      },
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: selectedImage == null
                            ? const Icon(Icons.add_a_photo, size: 40)
                            : ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// Title Field
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Banner Title",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedImage != null &&
                    titleController.text.isNotEmpty) {
                  setState(() {
                    banners.add(
                      BannerModel(
                        image: selectedImage!,
                        title: titleController.text,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  /// Delete Banner
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
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: banners.length,
              itemBuilder: (context, index) {
                final banner = banners[index];

                return Card(
                  margin:
                      const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(8),
                      child: Image.file(
                        banner.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(banner.title),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () =>
                          deleteBanner(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
