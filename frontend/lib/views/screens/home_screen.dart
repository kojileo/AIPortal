import 'package:flutter/material.dart';
import '/views/screens/select_screen.dart'; // SelectScreenのインポート

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // 画面のサイズを取得

    return Scaffold(
      appBar: AppBar(
        title: Text('生成AIポータルアプリ'),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ai_title.png',
                    width: screenWidth, // 画面幅の1/2のサイズで画像を表示
                  ),
                  SizedBox(height: 20),
                  _loginButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SelectScreen()),
        );
      },
      child: Text('ログイン'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }
}
