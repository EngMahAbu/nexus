import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/assets/fonts/nexus_icons.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:nexus/modules/other/chats_screen/chat_screen.dart';
import 'package:nexus/shared/components/components.dart';
import 'package:nexus/shared/styles/colors.dart';

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context)..getChatProfiles();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: cubit.userProfile != null,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) => Container(
          margin: EdgeInsetsDirectional.only(top: 20, bottom: 5),
          child: ListView.separated(
            itemBuilder: (context, index) =>
                chatProfileBuilder(cubit.chatUserProfilesList[index], context),
            separatorBuilder: (context, index) => SizedBox(height: 25),
            itemCount: cubit.chatUserProfilesList.length,
          ),
        ),
      ),
    );
  }

  Widget chatProfileBuilder(UserProfile userProfile, BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ChatScreen(otherUser: userProfile));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 20),
        child:
            // Avatar & Name Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
                        image: (userProfile.photoUrl == null)
                            ? AssetImage('lib/assets/avatar.png')
                            : NetworkImage(userProfile.photoUrl!),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProfile.displayName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      NexusIcons.horizontal_dots,
                      size: 5,
                      color: neutralColor,
                    ),
                    alignment: AlignmentGeometry.centerStart,
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
