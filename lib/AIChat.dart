import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'gemini_service.dart';

class AIChat extends StatefulWidget {
  const AIChat({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<AIChat> {
  final TextEditingController _controller = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  List<Map<String, String>> messages = [];

  void sendMessage() async {
    String userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "message": userMessage});
      _controller.clear();
    });

    String botResponse = await _geminiService.getResponse(userMessage);

    setState(() {
      messages.add({"role": "bot", "message": botResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]["role"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(messages[index]["message"] ?? ""),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 75,
            decoration: const BoxDecoration(color: Color(0xffE8DFCA),borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: "Type a message...",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.5),),
                    border: const OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                IconButton(
                  icon: const Icon(Boxicons.bxs_send,color: Color(0xff4F6F52),),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
