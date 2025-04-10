enum Sender { user, bot }

class Conversation {
  List<Message> messages;
  Conversation({
    required this.messages,
  });
}

class Message {
  String text;
  DateTime time;
  bool isBot;
  Message({
    required this.text,
    required this.time,
    required this.isBot,
  });
}
