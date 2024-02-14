// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatNewPromptEvent extends ChatEvent {
 final String prompt;
  ChatNewPromptEvent({
    required this.prompt,
  });
}

final class ChatNewContentGeneratedEvent extends ChatEvent {
  final String content;

  ChatNewContentGeneratedEvent({required this.content});
}