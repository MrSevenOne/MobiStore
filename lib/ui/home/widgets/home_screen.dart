import 'package:flutter/material.dart';
import 'package:mobi_store/routing/app_router.dart';
import 'package:mobi_store/ui/auth/view_model/auth_view_model.dart';
import 'package:mobi_store/ui/core/ui/drawer/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/ui/provider/store_viewmodel.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storeVm = context.watch<StoreViewModel>();

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<SelectedStoreViewModel>().clearStoreId();
              await context.read<AuthViewModel>().signOut();
              Navigator.pushReplacementNamed(context, AppRouter.splash);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (storeVm.isLoading)
              const CircularProgressIndicator()
            else if (storeVm.uploadedImageUrl != null)
              Column(
                children: [
                  Image.network(storeVm.uploadedImageUrl!, height: 200),
                  const SizedBox(height: 10),
                  const Text(
                    "Yuklangan rasm URL:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    storeVm.uploadedImageUrl!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              )
            else
              const Text("Hozircha rasm yuklanmadi"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                final storeName = 'ddd'; // yoki Provider’dan olish
                storeVm.pickAndUploadImage(storeName);
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text("Rasm yuklash (kamera)"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                final storeName = 'ddd'; // yoki Provider’dan olish
                storeVm.pickFromGalleryAndUpload(storeName);
              },
              icon: const Icon(Icons.photo_library),
              label: const Text("Rasm yuklash (galereya)"),
            ),
            if (storeVm.errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  storeVm.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
