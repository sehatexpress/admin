import 'package:flutter/material.dart';

class AddUpdateMenuScreen extends StatelessWidget {
  const AddUpdateMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Product')),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        children: [],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Handle product creation logic here
            },
            child: Text('Create Product'),
          ),
        ),
      ),
    );
  }
}
