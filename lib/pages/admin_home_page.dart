import 'package:flutter/material.dart';
import 'manage_banners_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Super Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [

            _adminCard(
              context: context,
              icon: Icons.people,
              label: "Manage Vendors",
              onTap: () {
                // Navigate to vendor page later
              },
            ),

            _adminCard(
              context: context,
              icon: Icons.inventory,
              label: "Manage Products",
              onTap: () {
                // Navigate to product page later
              },
            ),

            _adminCard(
              context: context,
              icon: Icons.image,
              label: "Manage Banners",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageBannersPage(),
                  ),
                );
              },
            ),

            _adminCard(
              context: context,
              icon: Icons.person,
              label: "Manage Users",
              onTap: () {
                // Navigate to user page later
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _adminCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 42, color: Colors.blue),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
