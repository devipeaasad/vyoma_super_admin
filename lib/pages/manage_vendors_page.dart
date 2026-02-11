import 'package:flutter/material.dart';

class VendorModel {
  String shopName;
  String ownerName;
  String phone;
  String email;
  String status; // approved, pending, blocked

  VendorModel({
    required this.shopName,
    required this.ownerName,
    required this.phone,
    required this.email,
    required this.status,
  });
}

class ManageVendorsPage extends StatefulWidget {
  const ManageVendorsPage({super.key});

  @override
  State<ManageVendorsPage> createState() => _ManageVendorsPageState();
}

class _ManageVendorsPageState extends State<ManageVendorsPage> {
  final List<VendorModel> vendors = [
    VendorModel(
        shopName: "Fresh Mart",
        ownerName: "Rahul",
        phone: "9876543210",
        email: "rahul@gmail.com",
        status: "pending"),
    VendorModel(
        shopName: "Veggie Shop",
        ownerName: "Amit",
        phone: "9876541111",
        email: "amit@gmail.com",
        status: "approved"),
    VendorModel(
        shopName: "Meat Hub",
        ownerName: "Imran",
        phone: "9998887777",
        email: "imran@gmail.com",
        status: "blocked"),
  ];

  String selectedFilter = "all";
  String searchText = "";

  List<VendorModel> get filteredVendors {
    return vendors.where((vendor) {
      final matchesFilter =
          selectedFilter == "all" || vendor.status == selectedFilter;

      final matchesSearch = vendor.shopName
          .toLowerCase()
          .contains(searchText.toLowerCase());

      return matchesFilter && matchesSearch;
    }).toList();
  }

  void updateStatus(int index, String newStatus) {
    setState(() {
      vendors[index].status = newStatus;
    });
  }

  void deleteVendor(int index) {
    setState(() {
      vendors.removeAt(index);
    });
  }

  Color statusColor(String status) {
    switch (status) {
      case "approved":
        return Colors.green;
      case "blocked":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Vendors"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// SEARCH BAR
            TextField(
              decoration: InputDecoration(
                hintText: "Search vendor...",
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

            /// FILTER TABS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                filterButton("All", "all"),
                filterButton("Approved", "approved"),
                filterButton("Pending", "pending"),
                filterButton("Blocked", "blocked"),
              ],
            ),

            const SizedBox(height: 15),

            /// VENDOR LIST
            Expanded(
              child: filteredVendors.isEmpty
                  ? const Center(child: Text("No Vendors Found"))
                  : ListView.builder(
                      itemCount: filteredVendors.length,
                      itemBuilder: (context, index) {
                        final vendor = filteredVendors[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [

                                /// SHOP NAME + STATUS
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      vendor.shopName,
                                      style: const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4),
                                      decoration: BoxDecoration(
                                        color:
                                            statusColor(vendor.status),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        vendor.status.toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),
                                Text("Owner: ${vendor.ownerName}"),
                                Text("Phone: ${vendor.phone}"),
                                Text("Email: ${vendor.email}"),

                                const SizedBox(height: 10),

                                /// ACTION BUTTONS
                                Row(
                                  children: [
                                    if (vendor.status == "pending")
                                      ElevatedButton(
                                        onPressed: () =>
                                            updateStatus(index,
                                                "approved"),
                                        child: const Text("Approve"),
                                      ),
                                    const SizedBox(width: 8),
                                    if (vendor.status != "blocked")
                                      ElevatedButton(
                                        style:
                                            ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.orange,
                                        ),
                                        onPressed: () =>
                                            updateStatus(index,
                                                "blocked"),
                                        child: const Text("Block"),
                                      ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red),
                                      onPressed: () =>
                                          deleteVendor(index),
                                    )
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
