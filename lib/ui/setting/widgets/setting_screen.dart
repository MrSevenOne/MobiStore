
  import 'package:flutter/material.dart';
  import '../view_model/setting_view_model.dart';

  
  class SettingScreen extends StatelessWidget {
	final SettingViewModel viewModel;
  
	const SettingScreen({super.key, required this.viewModel});
  
	@override
	Widget build(BuildContext context) {
	  return Scaffold(
      appBar: AppBar(
        title: Text("setting"),
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
	  }
  }
  