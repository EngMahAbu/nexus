import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:nexus/modules/other/chats_screen/chat_screen.dart';
import 'package:nexus/shared/components/components.dart';
import 'package:nexus/shared/styles/colors.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.allUsersList.isNotEmpty,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
            padding: EdgeInsetsGeometry.only(top: 20),
            itemBuilder: (context, index) =>
                userCardBuilder(context, cubit.allUsersList[index]),
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: cubit.allUsersList.length,
          ),
        );
      },
    );
  }

  Widget userCardBuilder(BuildContext context, UserProfile userProfile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(
              image: (userProfile.photoUrl != null)
                  ? NetworkImage(userProfile.photoUrl!)
                  : AssetImage('lib/assets/avatar.png'),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            userProfile.displayName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            userProfile.bio,
            style: TextStyle(fontSize: 16, color: neutralColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '15.2K',
                    style: TextStyle(
                      fontSize: 20,
                      color: neutralColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('FOLLOWERS', style: TextStyle(color: neutralColor)),
                ],
              ),
              SizedBox(width: 20),
              verticalDivider(),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1.2K',
                    style: TextStyle(
                      fontSize: 20,
                      color: neutralColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('MUTUAL', style: TextStyle(color: neutralColor)),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          button(
            onPressed: () {
              navigateTo(context, ChatScreen(otherUser: userProfile));
            },
            label: 'Message',
            radius: 10,
          ),
        ],
      ),
    );
  }
}
