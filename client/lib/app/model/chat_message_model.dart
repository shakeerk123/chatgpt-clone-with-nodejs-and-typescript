// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMsgModel {
  final String role;
  final String content;

  ChatMsgModel({required this.role, required this.content});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'content': content,
    };
  }

  factory ChatMsgModel.fromMap(Map<String, dynamic> map) {
    return ChatMsgModel(
      role: map['role'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMsgModel.fromJson(String source) => ChatMsgModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
