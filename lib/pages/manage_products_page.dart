import 'package:flutter/material.dart';

class ProductModel {
  String name;
  String vendorName;
  String price;
  String category;
  String status;
  String imagePath;

  ProductModel({
    required this.name,
    required this.vendorName,
    required this.price,
    required this.category,
    required this.status,
    required this.imagePath,
  });
}

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({super.key});

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  List<ProductModel> products = [
    ProductModel(
      name: "Tomatoes",
      vendorName: "Fresh Mart",
      price: "₹40/kg",
      category: "Vegetables",
      status: "pending",
      imagePath: "assets/banners/banner1.jpg",
    ),
    ProductModel(
      name: "Chicken",
      vendorName: "Meat Hub",
      price: "₹250/kg",
      category: "Meat",
      status: "approved",
      imagePath: "assets/banners/banner2.jpg",
    ),
    ProductModel(
      name: "Chicken",
      vendorName: "Meat Hub",
      price: "₹250/kg",
      category: "Meat",
      status: "approved",
      imagePath: "assets/banners/banner2.jpg",
    ),
    ProductModel(
      name: "Chicken",
      vendorName: "Meat Hub",
      price: "₹250/kg",
      category: "Meat",
      status: "approved",
      imagePath: "assets/banners/banner2.jpg",
    ),
    ProductModel(
      name: "Chicken",
      vendorName: "Meat Hub",
      price: "₹250/kg",
      category: "Meat",
      status: "approved",
      imagePath: "assets/banners/banner2.jpg",
    ),
  ];

  String selectedFilter = "all";
  String searchText = "";

  List<ProductModel> get filteredProducts {
    return products.where((product) {
      final matchesFilter =
          selectedFilter == "all" || product.status == selectedFilter;

      final matchesSearch =
          product.name.toLowerCase().contains(searchText.toLowerCase());

      return matchesFilter && matchesSearch;
    }).toList();
  }

  void updateStatus(int index, String newStatus) {
    setState(() {
      products[index].status = newStatus;
    });
  }

  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  Color statusColor(String status) {
    switch (status) {
      case "approved":
        return Colors.green;
      case "rejected":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// SEARCH
            TextField(
              decoration: InputDecoration(
                hintText: "Search product...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),

            const SizedBox(height: 15),

            /// FILTERS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                filterButton("All", "all"),
                filterButton("Approved", "approved"),
                filterButton("Pending", "pending"),
                filterButton("Rejected", "rejected"),
              ],
            ),

            const SizedBox(height: 15),

            /// PRODUCT LIST
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(child: Text("No Products Found"))
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [

                                /// PRODUCT IMAGE
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  child: Image.asset(
                                    product.imagePath,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                /// PRODUCT DETAILS
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(product.name,
                                          style: const TextStyle(
                                              fontWeight:
                                                  FontWeight.bold)),
                                      Text("Vendor: ${product.vendorName}"),
                                      Text("Price: ${product.price}"),
                                      Text("Category: ${product.category}"),
                                    ],
                                  ),
                                ),

                                /// STATUS + ACTIONS
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4),
                                      decoration: BoxDecoration(
                                        color: statusColor(
                                            product.status),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        product.status.toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10),
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    if (product.status == "pending")
                                      IconButton(
                                        icon: const Icon(
                                            Icons.check,
                                            color: Colors.green),
                                        onPressed: () =>
                                            updateStatus(index,
                                                "approved"),
                                      ),

                                    IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.orange),
                                      onPressed: () =>
                                          updateStatus(index,
                                              "rejected"),
                                    ),

                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () =>
                                          deleteProduct(index),
                                    ),
                                  ],
                                )
                              ],
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

  Widget filterButton(String text, String value) {
    final isSelected = selectedFilter == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
