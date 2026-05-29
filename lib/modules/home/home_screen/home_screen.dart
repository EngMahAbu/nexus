import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/assets/fonts/nexus_icons.dart';
import 'package:nexus/models/post.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:nexus/shared/components/components.dart';
import 'package:nexus/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: cubit.userProfile != null && cubit.postsList.isNotEmpty,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) => Container(
          margin: EdgeInsetsDirectional.only(top: 20, bottom: 5),
          child: ListView.separated(
            itemBuilder: (context, index) =>
                postItemBuilder(cubit.postsList[index], cubit),
            separatorBuilder: (context, index) => SizedBox(height: 25),
            itemCount: cubit.postsList.length,
          ),
        ),
      ),
    );
  }

  Widget postItemBuilder(Post post, HomeCubit cubit) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      image: NetworkImage(post.postAuthor.photoUrl),
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
                      post.postAuthor.displayName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      post.createdAt,
                      style: TextStyle(fontSize: 14, color: neutralColor),
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
          SizedBox(height: 15),
          // Post Text Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              post.textContent,
              style: TextStyle(fontSize: 16),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 5),
          // Hashtags Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '#SocialNexus #Networking',
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ),
          // Images Area
          if (post.imagesUrls.isNotEmpty) SizedBox(height: 15),
          if (post.imagesUrls.isNotEmpty)
            Image(image: NetworkImage(post.imagesUrls[0])),
          SizedBox(height: 15),
          // Counters Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  '${post.likesList.length} likes',
                  style: TextStyle(fontSize: 14, color: neutralColor),
                ),
                SizedBox(width: 5),
                Text('.', style: TextStyle(fontSize: 14, color: neutralColor)),
                SizedBox(width: 5),
                Text(
                  '${post.commentsList.length} comments',
                  style: TextStyle(fontSize: 14, color: neutralColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          // Options Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: horizontalDivider(),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                secondaryButton(
                  width: 90,
                  onPressed: () {
                    cubit.likePost(post);
                  },
                  label: 'Like',
                  backgroundColor: (post.isLiked) ? primaryFixed : Colors.white,
                  icon: NexusIcons.heart,
                ),
                SizedBox(width: 20),
                secondaryButton(
                  width: 100,
                  onPressed: () {},
                  label: 'Comment',
                  backgroundColor: Colors.white,
                  icon: NexusIcons.message,
                ),
                SizedBox(width: 20),
                secondaryButton(
                  width: 90,
                  onPressed: () {},
                  label: 'Share',
                  backgroundColor: Colors.white,
                  icon: NexusIcons.share,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
