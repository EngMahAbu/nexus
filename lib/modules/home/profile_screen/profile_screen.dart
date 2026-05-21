import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/assets/fonts/nexus_icons.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:nexus/shared/components/components.dart';
import 'package:nexus/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context)..getUser();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) => SingleChildScrollView(
        child: Column(
          children: [
            // Cover & Avatar Area
            Stack(
              alignment: AlignmentGeometry.bottomStart,
              children: [
                Container(
                  height: 270,
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: AssetImage('lib/assets/cover_photo.png'),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 40),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.antiAlias,
                      child: Image(
                        image: AssetImage('lib/assets/avatar.png'),
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Name Area
            Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              alignment: AlignmentGeometry.bottomStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cubit.user.displayName}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '@jordan_nexus',
                    style: TextStyle(fontSize: 14, color: neutralColor),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      button(
                        height: 45,
                        width: 100,
                        onPressed: () => {},
                        label: 'Follow',
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsetsGeometry.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: BoxBorder.all(width: 2, color: neutralColor),
                        ),
                        child: Icon(
                          NexusIcons.message_dot,
                          color: neutralColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bio Area
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Digital architect and brand strategist focusing on the intersection of professional growth and authentic social connection. Based in San Francisco. 🚀',
                    style: TextStyle(fontSize: 16, color: neutralColor),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        NexusIcons.location_marker,
                        size: 15,
                        color: neutralColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'San Francisco, CA',
                        style: TextStyle(
                          color: neutralColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(NexusIcons.link, size: 10, color: neutralColor),
                      SizedBox(width: 15),
                      Text(
                        'nexus.design/jordan',
                        style: TextStyle(
                          color: buttonBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(NexusIcons.calendar, size: 15, color: neutralColor),
                      SizedBox(width: 10),
                      Text(
                        'Joined March 2023',
                        style: TextStyle(
                          color: neutralColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Stats Area
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(10),
                border: BoxBorder.all(width: 1, color: textButtonLabelColor),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '128',
                        style: TextStyle(
                          fontSize: 18,
                          color: buttonBackgroundColor,
                        ),
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(fontSize: 18, color: neutralColor),
                      ),
                    ],
                  ),
                  // Vertical Divider
                  Container(
                    height: 25,
                    width: 1,
                    margin: EdgeInsetsGeometry.symmetric(horizontal: 15),
                    decoration: BoxDecoration(color: textButtonLabelColor),
                  ),
                  Column(
                    children: [
                      Text(
                        '12.5k',
                        style: TextStyle(
                          fontSize: 18,
                          color: buttonBackgroundColor,
                        ),
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(fontSize: 18, color: neutralColor),
                      ),
                    ],
                  ),
                  // Vertical Divider
                  Container(
                    height: 25,
                    width: 1,
                    margin: EdgeInsetsGeometry.symmetric(horizontal: 15),
                    decoration: BoxDecoration(color: textButtonLabelColor),
                  ),
                  Column(
                    children: [
                      Text(
                        '842',
                        style: TextStyle(
                          fontSize: 18,
                          color: buttonBackgroundColor,
                        ),
                      ),
                      Text(
                        'Following',
                        style: TextStyle(fontSize: 18, color: neutralColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Content Area
            SizedBox(height: 20),
            DefaultTabController(
              length: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Tabs Bar
                        SizedBox(
                          width: 300,
                          child: TabBar(
                            dividerHeight: 0,
                            indicatorColor: textButtonLabelColor,
                            labelPadding: EdgeInsetsGeometry.only(bottom: 8),
                            tabs: [
                              Text(
                                'Photos',
                                style: TextStyle(
                                  color: textButtonLabelColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Shared',
                                style: TextStyle(
                                  color: textButtonLabelColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Tagged',
                                style: TextStyle(
                                  color: textButtonLabelColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () => {},
                          icon: Icon(NexusIcons.square_tiles),
                          iconSize: 20,
                          color: neutralColor,
                        ),
                      ],
                    ),
                    // View Page
                    Container(
                      padding: EdgeInsetsDirectional.only(top: 4),
                      height: 500,
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'lib/assets/cover_photo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'lib/assets/cover_photo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'lib/assets/cover_photo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'lib/assets/cover_photo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'lib/assets/cover_photo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'lib/assets/cover_photo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'lib/assets/cover_photo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'lib/assets/cover_photo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'lib/assets/cover_photo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
