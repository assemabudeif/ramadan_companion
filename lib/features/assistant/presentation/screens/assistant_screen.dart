import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text':
          'السلام عليكم ورحمة الله وبركاته، أنا مساعدك الرمضاني الذكي. كيف يمكنني مساعدتك اليوم؟',
      'time': '١٠:٠٠ ص',
    },
  ];

  final _textController = TextEditingController();

  void _sendMessage() {
    if (_textController.text.isEmpty) return;

    setState(() {
      _messages.add({
        'isUser': true,
        'text': _textController.text,
        'time': '١٠:٠١ ص',
      });
      _textController.clear();

      // Simulate AI response
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        setState(() {
          _messages.add({
            'isUser': false,
            'text':
                'جزاك الله خيراً على سؤالك. وفقنا الله جميعاً لصيام رمضان وقيامه.',
            'time': '١٠:٠١ ص',
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.smart_toy_outlined, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'المساعد الذكي',
              style: GoogleFonts.cairo(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(
                  msg['text'],
                  msg['isUser'],
                  msg['time'],
                );
              },
            ),
          ),
          _buildActionSuggestions(),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser, String time) {
    return Column(
      crossAxisAlignment: isUser
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: isUser ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(isUser ? 20 : 0),
              bottomRight: Radius.circular(isUser ? 0 : 20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            text,
            style: GoogleFonts.cairo(
              color: isUser ? Colors.white : Colors.black87,
              fontSize: 14,
              height: 1.6,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        Text(
          time,
          style: GoogleFonts.manrope(fontSize: 10, color: Colors.grey),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildActionSuggestions() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSuggestionChip('ما فضل صيام الست من شوال؟'),
          _buildSuggestionChip('كيف أحسب زكاة مالي؟'),
          _buildSuggestionChip('أدعية مستجابة بإذن الله'),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 12,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'اسأل عن أي شيء شرعي...',
                hintStyle: GoogleFonts.cairo(color: Colors.grey, fontSize: 13),
                fillColor: AppColors.background,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: AppColors.primary,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
