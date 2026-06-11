import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/models/message.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:nexus/shared/date_time_helper.dart';
import 'package:nexus/shared/styles/colors.dart';

// TODO: this screen would be added in the future commits
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        if (cubit.messagesList.isEmpty && !cubit.messagesLoadingTriggered) {
          // cubit.getChatMessages(otherUser.uid);
          cubit.messagesLoadingTriggered = true;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Notification Center",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20,
              end: 20,
              bottom: 20,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.messagesList.isNotEmpty,
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          // Messages List Area
                          ListView.separated(
                            itemBuilder: (context, index) => messageItemBuilder(
                              cubit.messagesList[index],
                              cubit,
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15),
                            itemCount: cubit.messagesList.length,
                            shrinkWrap: true,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget messageItemBuilder(Message message, HomeCubit cubit) {
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
                  image: (cubit.userProfile!.photoUrl == null)
                      ? AssetImage('lib/assets/avatar.png')
                      : NetworkImage(cubit.userProfile!.photoUrl!),
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
