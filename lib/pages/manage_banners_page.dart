import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BannerModel {
  File image;
  String title;

  BannerModel({required this.image, required this.title});
}

class ManageBannersPage extends StatefulWidget {
  const ManageBannersPage({super.key});

  @override
  State<ManageBannersPage> createState() => _ManageBannersPageState();
}

class _ManageBannersPageState extends State<ManageBannersPage> {
  final List<BannerModel> banners = [];
  final ImagePicker picker = ImagePicker();

  File? selectedImage;
  final TextEditingController titleController = TextEditingController();

  /// Pick Image
  Future<void> pickBanner() async {
    final picked =
        await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  /// Add Banner
  void addBanner() {
    if (selectedImage == null || titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Add image and title")),
      );
      return;
    }

    setState(() {
      banners.add(
        BannerModel(
          image: selectedImage!,
          title: titleController.text,
        ),
      );

      selectedImage = null;
      titleController.clear();
    });
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
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Manage Banners"),
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Upload Box
            GestureDetector(
              onTap: pickBanner,
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.image,
                              size: 45, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            "Tap to upload banner",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey),
                          )
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            /// Title Field
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Banner Title",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Add Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: addBanner,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 156, 114, 230),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Add Banner",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Banner List
            Expanded(
              child: banners.isEmpty
                  ? const Center(
                      child: Text(
                        "No Banners Added",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        final banner = banners[index];

                        return Card(
                          margin: const EdgeInsets.only(
                              bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
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
            ),
          ],
        ),
      ),
    );
  }
}
