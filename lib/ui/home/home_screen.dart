import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/drawer/custom_drawer.dart';
import 'package:mobi_store/ui/home/widgets/phone_add.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("home_title".tr),
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
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => PhoneAddWidget.show(context),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
