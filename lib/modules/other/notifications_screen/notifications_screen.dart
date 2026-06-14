import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/assets/fonts/nexus_icons.dart';
import 'package:nexus/models/notification.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:nexus/shared/date_time_helper.dart';
import 'package:nexus/shared/styles/colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        if (cubit.notificationsList.isEmpty &&
            !cubit.notificationsLoadingTriggered) {
          cubit.getNotificationsHistory();
          cubit.notificationsLoadingTriggered = true;
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
            padding: const EdgeInsetsDirectional.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upper Area
                Row(
                  children: [
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Stay updated with your latest network activity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: neutralColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Mark as read Button
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: surfaceContainerHighestColor,
                            borderRadius: BorderRadiusGeometry.circular(5),
                          ),
                          child: Text(
                            "Mark all as read",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textButtonLabelColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Notifications Title Area
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textButtonLabelColor,
                  ),
                ),
                SizedBox(height: 15),
                // Notifications Area
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.notificationsList.isNotEmpty,
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          // Messages List Area
                          ListView.separated(
                            itemBuilder: (context, index) =>
                                notificationItemBuilder(
                                  cubit.notificationsList[index],
                                  cubit,
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15),
                            itemCount: cubit.notificationsList.length,
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

  Widget notificationItemBuilder(Notification notification, HomeCubit cubit) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: primaryDimmedColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(NexusIcons.heart, color: primaryDimmedColor),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 5,
                  children: [
                    Text(
                      notification.cloudMessage.notificationData.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        overflow: TextOverflow.clip,
                      ),
                      maxLines: 4,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: Text(
                        DateTimeHelper.formatTime(notification.sendDate),
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
