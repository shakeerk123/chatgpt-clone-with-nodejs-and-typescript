import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:client/app/model/chat_message_model.dart';
import 'package:client/app/repository/chat_repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatNewPromptEvent>(chatNewPromptEvent);
    on<ChatNewContentGeneratedEvent>(chatNewContentGeneratedEvent);
  }



  StreamSubscription<http.Response>? _subscription;
  List<ChatMsgModel> chachedMessages = [];


  FutureOr<void> chatNewPromptEvent(ChatNewPromptEvent event, Emitter<ChatState> emit) {
    emit(ChatMsgLoadingState());
   try {
    ChatMsgModel newMsg = ChatMsgModel(role: "user", content: event.prompt);
    chachedMessages.add(newMsg); 
    emit(ChatNewMsgGeneratedState());
    chachedMessages.add(ChatMsgModel(role: "assistant", content: ""));
      _subscription?.cancel();
    _subscription = getChatGptResponse(chachedMessages).listen((response) {

      log(response.toString());
      for(String line in response.body.split("\n"))
      {
        String jsonDataString = line.replaceFirst("data:", "");
        Map<String,dynamic> data = jsonDecode(jsonDataString.trim());
        
        add(ChatNewContentGeneratedEvent(content: data["data"]));
        
      }
     }); 
   } catch (e) {
       log(e.toString());
       emit(ChatMsgErrorState());
   }

  }

  FutureOr<void> chatNewContentGeneratedEvent(ChatNewContentGeneratedEvent event, Emitter<ChatState> emit) {
    ChatMsgModel modelMsg = chachedMessages.last;
    String content = event.content;
    chachedMessages.last = ChatMsgModel(role: "assistant", content: modelMsg.content+content);
    emit(ChatNewMsgGeneratedState());
  }
}
