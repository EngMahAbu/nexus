import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/assets/fonts/nexus_icons.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/shared/components/components.dart';
import 'package:nexus/shared/styles/colors.dart';
import '../../home_layout/cubit/home_states.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) => SingleChildScrollView(
        child: Column(
          children: [
            // Post Card Area
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar & Name Area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: BoxBorder.all(
                              width: 2,
                              color: primaryColor,
                            ),
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
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.userProfile!.displayName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                NexusIcons.earth,
                                size: 15,
                                color: neutralColor,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Public',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: neutralColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Post Text Area
                  TextFormField(
                    style: TextStyle(color: neutralColor),
                    maxLines: 10,
                    decoration: InputDecoration(
                      hint: Text(
                        'What\'s happening in your network?',
                        style: TextStyle(color: neutralColor, fontSize: 18),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Options Area
                  horizontalDivider(),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      secondaryButton(
                        width: 130,
                        onPressed: () {},
                        label: 'Add Photo',
                        icon: NexusIcons.add_image,
                      ),
                      SizedBox(width: 20),
                      secondaryButton(
                        width: 100,
                        onPressed: () {},
                        label: 'Video',
                        icon: NexusIcons.video,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      secondaryButton(
                        width: 80,
                        onPressed: () {},
                        label: 'Tag',
                        icon: NexusIcons.sign_at,
                      ),
                      SizedBox(width: 20),
                      secondaryButton(
                        width: 110,
                        onPressed: () {},
                        label: 'Location',
                        icon: NexusIcons.location_marker,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Other Cards Area
            Column(
              children: [
                // Engagement Tip Card Area
                Container(
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
                      Icon(
                        NexusIcons.stars,
                        size: 25,
                        color: textButtonLabelColor,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Engagement Tip',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Posts with images receive 3x more professional interactions from decision-makers.',
                        style: TextStyle(fontSize: 14, color: neutralColor),
                      ),
                    ],
                  ),
                ),
                // Trending Topics Card Area
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        NexusIcons.upgoing_arrow,
                        size: 15,
                        color: textButtonLabelColor,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Trending Topics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          secondaryButton(
                            width: 80,
                            height: 30,
                            onPressed: () {},
                            label: '#AIFuture',
                          ),
                          SizedBox(width: 10),
                          secondaryButton(
                            width: 100,
                            height: 30,
                            onPressed: () {},
                            label: '#Networking',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
