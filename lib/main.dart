import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/screens/places.dart';
import 'package:location_app/utils/theme.dart';


void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location App',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const PlacesScreen(),
    );
  }
}
