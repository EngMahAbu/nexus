import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_tab_bar/hybrid_tab_bar.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/shared/styles/colors.dart';
import '../../assets/fonts/nexus_icons.dart';
import 'cubit/home_states.dart';

  class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);

          // return HybridTabBarScaffold(
          //     style: HybridTabStyle(
          //       activeColor: primaryColor,
          //       bottomPillColor: primaryColor15,
          //     ),
          //     backgroundColor: Colors.green,
          //     bottomItems: const [
          //       // This item HAS segmented sub-tabs
          //       HybridNavItem(
          //         icon: Icons.explore,
          //         label: "Explore",
          //         // segmentedTabs: ["Rooms", "Inspiration", "Profiles"],
          //       ),
          //       // These items have NO sub-tabs
          //       HybridNavItem(icon: Icons.auto_awesome, label: "Assistant"),
          //       HybridNavItem(icon: Icons.settings, label: "Configs"),
          //     ],
          //     bodyBuilder: (bottomIndex, segmentedIndex) {
          //       // bottomIndex  → which bottom nav item is active (0, 1, 2)
          //       // segmentedIndex → which sub-tab is active (0, 1, 2) if applicable
          //       return cubit.bottomNavScreens[bottomIndex];
          //     },
          //   );

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(title),
              actions: [
                Icon(Icons.notifications),
                Icon(Icons.search),
                Icon(Icons.settings),
              ],
            ),
            body: cubit.bottomNavScreens[cubit.bottomNavCurrentIndex],
            bottomNavigationBar: Container(
              padding: EdgeInsetsDirectional.only(bottom: 30, start: 10, end: 10),
              child: HybridBottomBar(
                items: [
                  HybridNavItem(icon: NexusIcons.home, label: "Home"),
                  HybridNavItem(icon: Icons.search, label: "Search"),
                  HybridNavItem(icon: Icons.person, label: "Profile"),
                ],
                currentIndex: cubit.bottomNavCurrentIndex,
                onItemTapped: (index) => cubit.changeBottomNavBar(index),
                style: HybridTabStyle(
                  activeColor: primaryColor,
                  bottomPillColor: primaryColor15,
                ),
                showContainer: false,  // Wraps in external glass container
              ),
            ) ,
          );
        },
      ),
    );
  }
}
