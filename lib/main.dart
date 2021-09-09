import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_list_dynamic/home_page.dart';
import 'package:flutter_provider_list_dynamic/provider/list_provider.dart';

//https://www.youtube.com/watch?v=NOrUazt9vNI&t=2s
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String title = 'Dynamic ListView with Provider';
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<ListProvider>(
        create: (context) => ListProvider(),
        child: MyHomePage(
          title: title,
        ),
      ),
    );
  }
}
//https://www.youtube.com/watch?v=NOrUazt9vNI&t=2s