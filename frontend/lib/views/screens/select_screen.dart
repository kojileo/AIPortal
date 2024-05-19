import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  List<String> imagePaths = [
    'assets/images/web.png',
    'assets/images/youtube.png',
    'assets/images/pdf.png',
  ];

  // 各画像に対応するエンドポイントURL
  List<String> serviceEndpoints = [
    'https://api.example.com/web-service',
    'https://api.example.com/youtube-service',
    'https://api.example.com/pdf-service',
  ];

  // 各サービスのタイトル
  List<String> serviceTitles = [
    'web要約サービス',
    'youtube要約サービス',
    'pdfについての質問サービス',
  ];

  void _goToChat(int index) async {
    final url = serviceEndpoints[index];
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('生成AIサービス選択'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'AIがあなたの課題に最適なアプリを提案します',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '課題を入力してください',
              ),
              onSubmitted: (value) {
                // ここでユーザーの入力に基づいて提案を行うロジックを追加できます
                // 現在はUIのみの実装です
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3列に変更
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _goToChat(index),
                  child: Card(
                    elevation: 4.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            imagePaths[index],
                            fit: BoxFit.contain, // 画像のサイズを調整
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            serviceTitles[index],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
