import 'package:flutter/material.dart';
import '../../widgets/message_bubble.dart'; // MessageBubbleクラスをインポート
import '../../services/girl1_service.dart'; // Girl1Serviceクラスをインポート
import '../../services/girl2_service.dart'; // Girl2Serviceクラスをインポート
import '../../services/girl3_service.dart'; // Girl3Serviceクラスをインポート
import '../../services/girl4_service.dart'; // Girl4Serviceクラスをインポート
import '../../services/girl5_service.dart'; // Girl5Serviceクラスをインポート

class ChatScreen extends StatefulWidget {
  final String imagePath; // 画像パスを受け取る
  final int currentIndex; // 現在のインデックスを受け取る

  const ChatScreen(
      {Key? key, required this.imagePath, required this.currentIndex})
      : super(key: key); // コンストラクタに追加

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  dynamic chatService; // 動的なchatServiceを宣言
  List<MessageBubble> messages = [];

  @override
  void initState() {
    super.initState();
    // currentIndexの値に応じて、使用するサービスを変更
    switch (widget.currentIndex) {
      case 0:
        chatService = Girl1Service();
        break;
      case 1:
        chatService = Girl2Service();
        break;
      case 2:
        chatService = Girl3Service();
        break;
      case 3:
        chatService = Girl4Service();
        break;
      case 4:
        chatService = Girl5Service();
        break;
      default:
        chatService = Girl1Service(); // デフォルトのサービス
    }
  }

  void sendMessage() async {
    final String userMessage = messageController.text;
    if (userMessage.trim().isNotEmpty) {
      try {
        // メッセージ送信の処理をawaitで待ち、レスポンスメッセージを取得
        final String responseMessage =
            await chatService.sendMessage(userMessage);

        setState(() {
          // ユーザーメッセージを追加
          messages.insert(
            0,
            MessageBubble(
              sender: "あなた",
              text: userMessage,
              isMe: true,
            ),
          );
          // ChatGPTのレスポンスを追加
          messages.insert(
            0,
            MessageBubble(
              sender: "AI彼女",
              text: responseMessage,
              isMe: false,
            ),
          );
        });

        messageController.clear();
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('エラー'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(widget.imagePath, width: 40, height: 40),
            const SizedBox(width: 10), // 画像とテキストの間隔
            Expanded(
              // このウィジェットを追加
              child: const Text('チャット'),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // 通話機能などをここに実装
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) => messages[index],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      hintText: 'メッセージを入力...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: sendMessage,
                  child: const Text(
                    '送信',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
