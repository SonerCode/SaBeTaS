import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/firebase_provider.dart';
import 'dchat_messages.dart';
import 'widget/dchat_textfiles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.musteriuid});
  final String musteriuid;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getmusteribyid(widget.musteriuid)
      ..getMesajlarD(widget.musteriuid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ChatMessages(
              alanid: widget.musteriuid,
            ),
            ChatTexfield(
              alanid: widget.musteriuid,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: Consumer<FirebaseProvider>(builder: (context, value, child) {
          return value.musteri != null
              ? Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(value.musteri!.resim),
                      radius: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          value.musteri!.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : const Text(
                  "KGSDFHKLSHDFLKSDJFLSKDFJSDLKFŞ",
                  style: TextStyle(color: Colors.amber),
                );
        }));
  }
}
