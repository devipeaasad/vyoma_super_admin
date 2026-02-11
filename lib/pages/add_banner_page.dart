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

class AddBannerPage extends StatefulWidget {
  const AddBannerPage({super.key});

  @override
  State<AddBannerPage> createState() => _AddBannerPageState();
}

class _AddBannerPageState extends State<AddBannerPage> {
  final List<BannerModel> banners = [];
  final ImagePicker picker = ImagePicker();

  final TextEditingController titleController = TextEditingController();
  File? selectedImage;

  /// PICK IMAGE
  Future<void> pickBanner() async {
    final picked =
        await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  /// ADD BANNER
  void addBanner() {
    if (selectedImage == null || titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add image and title")),
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

      // Clear input after adding
      selectedImage = null;
      titleController.clear();
    });
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
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Manage Banners"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// IMAGE PICKER
            GestureDetector(
              onTap: pickBanner,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.image,
                              size: 40, color: Colors.grey),
                          SizedBox(height: 10),
                          Text("Tap to upload banner"),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 15),

            /// TITLE FIELD
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Banner Title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// ADD BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: addBanner,
                child: const Text("Add Banner"),
              ),
            ),

            const SizedBox(height: 20),

            /// BANNER LIST
            Expanded(
              child: banners.isEmpty
                  ? const Center(
                      child: Text("No Banners Added"),
                    )
                  : ListView.builder(
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        final banner = banners[index];

                        return Card(
                          margin:
                              const EdgeInsets.only(bottom: 12),
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
                              icon:
                                  const Icon(Icons.delete,
                                      color: Colors.red),
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
