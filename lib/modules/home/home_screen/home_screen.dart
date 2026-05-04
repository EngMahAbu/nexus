import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/modules/home_layout/cubit/home_cubit.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context)..getUser();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) => Container(
        height: 400,
        width: 200,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            if (state is GotUser)
              Text('Home Screen: ${state.user.displayName}'),
          ],
        ),
      ),
    );
  }
}
