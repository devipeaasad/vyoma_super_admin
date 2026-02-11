import 'package:flutter/material.dart';

class UserModel {
  String name;
  String phone;
  String email;
  String status;
  String joinedDate;
  int totalOrders;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    required this.joinedDate,
    required this.totalOrders,
  });
}

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  List<UserModel> users = [
    UserModel(
      name: "Chirag",
      phone: "9876543210",
      email: "chirag@gmail.com",
      status: "active",
      joinedDate: "12 Jan 2025",
      totalOrders: 5,
    ),
    UserModel(
      name: "Rahul",
      phone: "9998887777",
      email: "rahul@gmail.com",
      status: "blocked",
      joinedDate: "20 Feb 2025",
      totalOrders: 2,
    ),
    UserModel(
      name: "Rahul",
      phone: "9998887777",
      email: "rahul@gmail.com",
      status: "blocked",
      joinedDate: "20 Feb 2025",
      totalOrders: 2,
    ),
    UserModel(
      name: "parsad",
      phone: "9998887777",
      email: "rahul@gmail.com",
      status: "blocked",
      joinedDate: "20 Feb 2025",
      totalOrders: 2,
    ),
    UserModel(
      name: "devi",
      phone: "9998887777",
      email: "rahul@gmail.com",
      status: "blocked",
      joinedDate: "20 Feb 2025",
      totalOrders: 2,
    ),
  ];

  String selectedFilter = "all";
  String searchText = "";

  List<UserModel> get filteredUsers {
    return users.where((user) {
      final matchesFilter =
          selectedFilter == "all" || user.status == selectedFilter;

      final matchesSearch = user.name
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          user.phone.contains(searchText);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  void updateStatus(int index, String newStatus) {
    setState(() {
      users[index].status = newStatus;
    });
  }

  void deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  Color statusColor(String status) {
    return status == "active" ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// SEARCH
            TextField(
              decoration: InputDecoration(
                hintText: "Search user...",
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
                filterButton("Active", "active"),
                filterButton("Blocked", "blocked"),
              ],
            ),

            const SizedBox(height: 15),

            /// USER LIST
            Expanded(
              child: filteredUsers.isEmpty
                  ? const Center(child: Text("No Users Found"))
                  : ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];

                        return Card(
                          margin:
                              const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    Text(
                                      user.name,
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
                                        color: statusColor(
                                            user.status),
                                        borderRadius:
                                            BorderRadius.circular(
                                                20),
                                      ),
                                      child: Text(
                                        user.status
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            color:
                                                Colors.white,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),
                                Text("Phone: ${user.phone}"),
                                Text("Email: ${user.email}"),
                                Text(
                                    "Joined: ${user.joinedDate}"),
                                Text(
                                    "Orders: ${user.totalOrders}"),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    if (user.status ==
                                        "active")
                                      ElevatedButton(
                                        style:
                                            ElevatedButton
                                                .styleFrom(
                                          backgroundColor:
                                              Colors.orange,
                                        ),
                                        onPressed: () =>
                                            updateStatus(
                                                index,
                                                "blocked"),
                                        child:
                                            const Text("Block"),
                                      ),
                                    if (user.status ==
                                        "blocked")
                                      ElevatedButton(
                                        onPressed: () =>
                                            updateStatus(
                                                index,
                                                "active"),
                                        child:
                                            const Text(
                                                "Unblock"),
                                      ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red),
                                      onPressed: () =>
                                          deleteUser(index),
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
          color:
              isSelected ? Colors.deepPurple : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color:
                isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
