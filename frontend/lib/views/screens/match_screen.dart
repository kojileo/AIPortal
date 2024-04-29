import 'package:flutter/material.dart';
import 'chat_screen.dart'; // チャット画面のインポートを忘れずに

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  int currentImageIndex = 0; // 現在表示している画像のインデックス
  List<String> imagePaths = [
    'assets/images/girl1.png', // 画像のファイル名を適宜変更してください
    'assets/images/girl2.png',
    'assets/images/girl3.png',
    'assets/images/girl4.png',
    'assets/images/girl5.png',
    // 他にも画像がある場合はリストに追加
  ];

  void _nextImage() {
    setState(() {
      currentImageIndex = (currentImageIndex + 1) % imagePaths.length;
    });
  }

  void _goToChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatScreen(
              imagePath: imagePaths[currentImageIndex],
              currentIndex: currentImageIndex)), // 画像パスと現在のインデックスを渡す
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('マッチング'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Image.asset(imagePaths[currentImageIndex]),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('この女の子とマッチしますか？', textAlign: TextAlign.center),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _goToChat,
                child: Text('Yes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
              ),
              ElevatedButton(
                onPressed: _nextImage,
                child: Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
