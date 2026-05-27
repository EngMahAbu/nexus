import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/assets/fonts/nexus_icons.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/modules/home/profile_screen/profile_screen.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:nexus/shared/components/components.dart';
import 'package:nexus/shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController bioController = TextEditingController();

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);

          if (state is ProfileGetSuccessState) {
            fullNameController.text = cubit.userProfile!.displayName;
            usernameController.text = cubit.userProfile!.username;
            bioController.text = cubit.userProfile!.bio;
          } else if (state is ProfileUpdateSuccessState) {
            showToast(
              message: 'Profile Updated Successfully!',
              backgroundColor: Colors.green,
            );
            Navigator.pop(context, profileUpdated);
          }
        },
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              leadingWidth: 75,
              leading: Container(
                padding: EdgeInsetsDirectional.only(start: 15),
                alignment: AlignmentDirectional.center,
                child: textButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: 'Cancel',
                  labelColor: neutralColor,
                  labelSize: 18,
                ),
              ),
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
              title: Text('Edit Profile'),
              actions: [
                textButton(
                  onPressed: () {
                    UserProfile newProfile = cubit.userProfile!.update(
                      displayName: fullNameController.text,
                      username: usernameController.text,
                      bio: bioController.text,
                    );
                    if (cubit.userProfile!.isDifferent(newProfile) ||
                        cubit.avatarPhotoFile != null ||
                        cubit.coverPhotoFile != null) {
                      cubit.updateUserProfile(newProfile);
                    } else {
                      showToast(
                        message: 'User information has not changed',
                        backgroundColor: Colors.amber,
                      );
                    }
                  },
                  label: 'Save',
                  labelSize: 18,
                ),
              ],
              actionsPadding: EdgeInsetsDirectional.only(end: 20),
            ),
            body: ConditionalBuilder(
              condition: cubit.userProfile != null,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    // Cover & Avatar Area
                    Stack(
                      alignment: AlignmentGeometry.bottomCenter,
                      children: [
                        Container(
                          height: 270,
                          alignment: Alignment.topCenter,
                          child: (state is CoverPhotoPickSuccessState)
                              ? Image(
                                  image: FileImage(cubit.coverPhotoFile!),
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.fill,
                                )
                              : Image(
                                  image:
                                      (cubit.userProfile!.coverPhotoUrl == null)
                                      ? AssetImage('lib/assets/cover_photo.png')
                                      : NetworkImage(
                                          cubit.userProfile!.coverPhotoUrl!,
                                        ),
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        Stack(
                          alignment: AlignmentGeometry.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: (state is AvatarPhotoPickSuccessState)
                                    ? Image(
                                        image: FileImage(
                                          cubit.avatarPhotoFile!,
                                        ),
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.fill,
                                      )
                                    : Image(
                                        image:
                                            (cubit.userProfile!.photoUrl ==
                                                null)
                                            ? AssetImage(
                                                'lib/assets/avatar.png',
                                              )
                                            : NetworkImage(
                                                cubit.userProfile!.photoUrl!,
                                              ),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                bottom: 8,
                                end: 12,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  cubit.pickUserAvatarPhoto();
                                },
                                icon: Icon(
                                  NexusIcons.camera_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          padding: EdgeInsetsDirectional.only(
                            end: 10,
                            bottom: 75,
                          ),
                          child: IconButton(
                            onPressed: () {
                              cubit.pickUserCoverPhoto();
                            },
                            icon: Icon(
                              NexusIcons.camera_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Form Area
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
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                formField(
                                  label: 'Full Name',
                                  hint: 'John Doe',
                                  controller: fullNameController,
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return 'Your name is required';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    formKey.currentState?.validate();
                                  },
                                  backgroundColor: Colors.white,
                                ),
                                SizedBox(height: 20),
                                formField(
                                  label: 'Username',
                                  hint: 'john_doe',
                                  controller: usernameController,
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return 'You must have a username';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    formKey.currentState?.validate();
                                  },
                                  backgroundColor: Colors.white,
                                ),
                                SizedBox(height: 20),
                                formField(
                                  label: 'Bio',
                                  hint: 'Tell others about you',
                                  controller: bioController,
                                  backgroundColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
