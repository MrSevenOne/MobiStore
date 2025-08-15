import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/user_provider.dart';

class EditUserinfoWidget extends StatefulWidget {
  const EditUserinfoWidget({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const EditUserinfoWidget(),
    );
  }

  @override
  State<EditUserinfoWidget> createState() => _EditUserinfoWidgetState();
}

class _EditUserinfoWidgetState extends State<EditUserinfoWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserViewModel>().user;
    _nameController = TextEditingController(text: user?.name ?? "");
    _emailController = TextEditingController(text: user?.email ?? "");
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final userViewModel = context.read<UserViewModel>();
    final currentUser = userViewModel.user;
    if (currentUser == null) return;

    currentUser.copyWith(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
    );


    if (userViewModel.error == null) {
      if (mounted) Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ User info updated successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: ${userViewModel.error}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((UserViewModel vm) => vm.isLoading);

    return AlertDialog(
      title: const Text(
        "Edit Account",
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Enter name'),
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter name" : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Enter email'),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Enter email";
                  final emailRegex =
                      RegExp(r'^[\w\.\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z]{2,}$');
                  if (!emailRegex.hasMatch(v.trim())) {
                    return "Invalid email format";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter new password (optional)',
                ),
                obscureText: true,
                validator: (v) {
                  if (v != null && v.isNotEmpty && v.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : _save,
          child: isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Save"),
        ),
      ],
    );
  }
}
