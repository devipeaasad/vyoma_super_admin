import 'package:flutter/material.dart';

class BannerManagerPage extends StatefulWidget {
  const BannerManagerPage({super.key});

  @override
  State<BannerManagerPage> createState() => _BannerManagerPageState();
}

class _BannerManagerPageState extends State<BannerManagerPage> {
  final TextEditingController titleController = TextEditingController();
  List<String> banners = [];

  void addBanner() {
    if (titleController.text.isNotEmpty) {
      setState(() {
        banners.add(titleController.text);
        titleController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banner Manager"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Banner Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: addBanner,
              child: const Text("Add Banner"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(banners[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            banners.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
