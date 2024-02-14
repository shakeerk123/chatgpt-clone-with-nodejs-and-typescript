part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatMsgLoadingState extends ChatState {}
final class ChatMsgErrorState extends ChatState {}
final class ChatNewMsgGeneratedState extends ChatState {}

