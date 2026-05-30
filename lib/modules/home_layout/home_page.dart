import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_tab_bar/hybrid_tab_bar.dart';
import 'package:nexus/models/post.dart';
import 'package:nexus/modules/home/all_chat_screen/all_chat_screen.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/shared/components/components.dart';
import '../../assets/fonts/nexus_icons.dart';
import '../../shared/styles/colors.dart';
import 'cubit/home_states.dart';
import 'package:nexus/modules/home/home_screen/home_screen.dart';
import 'package:nexus/modules/home/new_post_screen/new_post_screen.dart';
import 'package:nexus/modules/home/profile_screen/profile_screen.dart';
import 'package:nexus/modules/home/users_screen/users_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Widget> bottomNavScreens = [
    HomeScreen(),
    AllChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is PostCreationSuccessState) {
            showToast(
              message: 'Post Created Successfully!',
              backgroundColor: Colors.green,
            );
          }
        },
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);

          return Scaffold(
            // TODO: test this later.
            appBar: appBar(
              leading: (cubit.bottomNavCurrentIndex == 2)
                  ? IconButton(onPressed: () {}, icon: Icon(Icons.close))
                  : null,
              actions: (cubit.bottomNavCurrentIndex == 2)
                  ? [
                      button(
                        onPressed: () {
                          Post newPost = Post.create(
                            authorUid: cubit.userProfile!.user.uid,
                            textContent: NewPostScreen.postContent,
                          );
                          cubit.createPost(newPost);
                        },
                        label: 'Post',
                        buttonColor: primaryColor,
                        width: 90,
                        height: 40,
                        radius: 20,
                      ),
                    ]
                  : [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(NexusIcons.search),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(NexusIcons.alert),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(NexusIcons.settings),
                      ),
                    ],
            ),
            body: bottomNavScreens[cubit.bottomNavCurrentIndex],
            bottomNavigationBar: Container(
              padding: EdgeInsetsDirectional.only(
                bottom: 30,
                start: 10,
                end: 10,
              ),
              margin: EdgeInsets.all(5),
              child: HybridBottomBar(
                items: [
                  HybridNavItem(icon: NexusIcons.home, label: "HOME"),
                  HybridNavItem(icon: NexusIcons.chats, label: "CHAT"),
                  HybridNavItem(
                    icon: NexusIcons.plus_circle,
                    label: "NEW POST",
                  ),
                  HybridNavItem(icon: Icons.people_outline, label: "USERS"),
                  HybridNavItem(
                    icon: NexusIcons.profile_outlined,
                    label: "PROFILE",
                  ),
                ],
                currentIndex: cubit.bottomNavCurrentIndex,
                onItemTapped: (index) => cubit.changeBottomNavBar(index),
                style: HybridTabStyle(
                  activeColor: Theme.of(
                    context,
                  ).bottomNavigationBarTheme.selectedItemColor,
                  bottomPillColor: primaryColor.withAlpha(15),
                  inactiveColor: neutralColor,
                  bottomLabelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: neutralColor,
                  ),
                ),
                showContainer: false, // Wraps in external glass container
              ),
            ),
          );
        },
      ),
    );
  }
}
