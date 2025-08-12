import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import '../view_model/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("home Page"),
        actions: [
          IconButton(
  onPressed: () async {
    final storeVm = Provider.of<SelectedStoreViewModel>(context, listen: false);
    await storeVm.clearStoreId();

    await Provider.of<AuthViewModel>(context, listen: false).signOut();
    Navigator.pushReplacementNamed(context, AppRouter.splash);
  },
  icon: Icon(Icons.logout),
),

        ],
      ),
      body: Center(
        child: Text("HomePage"),
      ),
    );
  }
}
