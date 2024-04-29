import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'views/screens/home_screen.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // keyを追加して、constコンストラクタを使います。
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Matching App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: Size(360, 640), // ここでスマホの画面サイズを指定します。
          ),
          child: widget!,
        );
      },
    );
  }
}
