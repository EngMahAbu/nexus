import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/assets/fonts/nexus_icons.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/models/message.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:nexus/shared/date_time_helper.dart';
import 'package:nexus/shared/styles/colors.dart';

class ChatScreen extends StatelessWidget {
  final UserProfile otherUser;

  const ChatScreen({super.key, required this.otherUser});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        if (cubit.messagesList.isEmpty) {
          cubit.getChatMessages(otherUser.uid);
        }

        TextEditingController messageFieldController = TextEditingController();
        ScrollController messagesListViewController = ScrollController();

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: BoxBorder.all(width: 2, color: primaryColor),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                      image: (otherUser.photoUrl == null)
                          ? AssetImage('lib/assets/avatar.png')
                          : NetworkImage(otherUser.photoUrl!),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  otherUser.displayName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  NexusIcons.vertical_dots,
                  size: 16,
                  color: neutralColor,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20,
              end: 20,
              bottom: 20,
            ),
            child: ConditionalBuilder(
              condition: cubit.messagesList.isNotEmpty,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => messageItemBuilder(
                          cubit.messagesList[index],
                          cubit,
                          messagesListViewController,
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15),
                        itemCount: cubit.messagesList.length,
                        shrinkWrap: true,
                        controller: messagesListViewController,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            NexusIcons.plus_circle,
                            size: 25,
                            color: neutralColor,
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: TextFormField(
                            controller: messageFieldController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: surfaceContainerHighestColor.withAlpha(
                                128,
                              ),
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hint: Text('Type a message...'),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  NexusIcons.camera_outlined,
                                  size: 20,
                                  color: neutralColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: buttonBackgroundColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (messageFieldController.text == '') return;

                              cubit.sendMessage(
                                otherUser.uid,
                                Message(
                                  senderUid: cubit.userProfile!.user.uid,
                                  textContent: messageFieldController.text,
                                  receiverUid: otherUser.uid,
                                ),
                              );
                            },
                            iconSize: 20,
                            icon: Icon(
                              NexusIcons.send_arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget messageItemBuilder(
    Message message,
    HomeCubit cubit,
    ScrollController scrollController,
  ) {
    // TODO: Scroll to end after loading
    if (message.senderUid == cubit.userProfile!.user.uid) {
      // Sent Message
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 5,
            children: [
              Container(
                width: 300,
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  color: buttonBackgroundColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    bottomEnd: Radius.circular(0),
                    bottomStart: Radius.circular(10),
                  ),
                ),
                child: Text(
                  message.textContent,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 8,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: Text(DateTimeHelper.formatTime(message.dateTime)),
              ),
            ],
          ),
        ],
      );
    } else {
      // Received Message
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(bottom: 5),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: BoxBorder.all(width: 2, color: primaryColor),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image(
                  image: (otherUser.photoUrl == null)
                      ? AssetImage('lib/assets/avatar.png')
                      : NetworkImage(otherUser.photoUrl!),
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Container(
                width: 300,
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  color: surfaceContainerHighestColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    bottomEnd: Radius.circular(10),
                    bottomStart: Radius.circular(0),
                  ),
                ),
                child: Text(
                  message.textContent,
                  style: TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 8,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: Text(DateTimeHelper.formatTime(message.dateTime)),
              ),
            ],
          ),
        ],
      );
    }
  }
}
