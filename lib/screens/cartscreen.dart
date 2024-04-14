import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend background behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove app bar elevation
      ),
      body: Container(
        // Use a BoxDecoration with an image as the background
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/comingsoon.jpg'), // Replace 'your_image_path_here.jpg' with the path to your image asset
            fit: BoxFit.cover, // Cover the entire container
          ),
        ),
      ),
    );
  }
}
