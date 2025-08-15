// import 'package:mobi_store/export.dart';
// import 'package:mobi_store/ui/provider/user_provider.dart';

// class EditUserPage extends StatefulWidget {
//   final UserModel user;
//   const EditUserPage({Key? key, required this.user}) : super(key: key);

//   @override
//   State<EditUserPage> createState() => _EditUserPageState();
// }

// class _EditUserPageState extends State<EditUserPage> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _emailController;
//   late TextEditingController _nameController;
//   final _passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _emailController = TextEditingController(text: widget.user.email);
//     _nameController = TextEditingController(text: widget.user.name ?? "");
//   }

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.watch<UserViewModel>();

//     return Scaffold(
//       appBar: AppBar(title: Text("Edit User")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: "Name"),
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: "Email"),
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: "New Password"),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 20),
//               if (viewModel.isLoading)
//                 const CircularProgressIndicator()
//               else
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       final updatedUser = widget.user.copyWith(
//                         name: _nameController.text,
//                         email: _emailController.text,
//                       );

//                       viewModel.updateFullUser(
//                         updatedUser,
//                         newPassword: _passwordController.text.isEmpty
//                             ? null
//                             : _passwordController.text,
//                       );
//                     }
//                   },
//                   child: const Text("Update"),
//                 ),
//               if (viewModel.error != null)
//                 Text(
//                   viewModel.error!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
