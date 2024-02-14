import 'package:client/app/controller/bloc/chat_bloc.dart';
import 'package:client/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatBloc chatBloc = ChatBloc();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ChatGPT",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
           
            child: Column(
              children: [
                Expanded(child: ListView.builder(
                  padding: const EdgeInsets.only(top: 12),
                  itemCount: chatBloc.chachedMessages.length,
                  itemBuilder: (context,index){
                    return Container(
                      decoration: BoxDecoration(
                        color: chatBloc.chachedMessages[index].role == "assistant" ? AppColors.messageBgColor : Colors.transparent
                      ),
                       margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 8),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        chatBloc.chachedMessages[index].role == "assistant" ? Container(margin: const EdgeInsets.only(left: 10,top: 10),
                          height: 30,
                        width: 30,
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/chatgpt.jpg",),fit: BoxFit.cover)
                          ),
                          
                        ) : Container(height: 30,
                        width:30,
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/user.jpg"),fit: BoxFit.cover)
                          ),
                        ),

                         const SizedBox(width: 20,),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(chatBloc.chachedMessages[index].content,style: TextStyle(fontSize: 18),),
                          )),
                        ],
                      ),);
                })),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      promptContainer(
                          ("Can you recommend me a dish that's easy to cook?")),
                      promptContainer(
                          ("Tell me a random fun fact about the Golden State Warriors")),
                      promptContainer(
                          ("Design a database schema for an online merch store.")),
                      promptContainer(("Tell me something about Harry Potter")),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6)),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 6),
                  child:  Row(
                    children: [
                      Expanded(
                          child: TextField(controller: controller,
                        decoration: const InputDecoration(
                            hintText: "Ask Anything...",
                            filled: false,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: (){
                          if(controller.text.isNotEmpty){
                            String text = controller.text;
                            controller.clear();
                            chatBloc.add(ChatNewPromptEvent(prompt:text));
                          }
                        },
                          child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.send_rounded),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        "ChatGPT March 2024",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      SizedBox(width: 10),
                      Text("Free Research Preview")
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget promptContainer(String text) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    width: 200,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.5),
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8)),
    child: Text(text),
  );
}
