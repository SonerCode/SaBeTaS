import 'package:flutter/material.dart';

import '../../../../provider/firebase_provider.dart';
import '../../../ortak/chat/widget/custom_text_form_field.dart';

class ChatTexfield extends StatefulWidget {
  const ChatTexfield({super.key, required this.alanid});
  final String alanid;

  @override
  State<ChatTexfield> createState() => _ChatTexfieldState();
}

class _ChatTexfieldState extends State<ChatTexfield> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextFormField(
          controller: controller,
          hintText: "Add Messages",
        )),
        const SizedBox(width: 5),
        CircleAvatar(
          backgroundColor: const Color(0xff703efe),
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () => _sendText(context),
          ),
        ),
      ],
    );
  }

  Future<void> _sendText(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      await FirebaseFirestoreService.mesajiyollaM(
        alanid: widget.alanid,
        mesaj: controller.text,
      );

      controller.clear();
      // ignore: use_build_context_synchronously
      FocusScope.of(context).unfocus();
    }
    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
  }
}
