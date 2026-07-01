import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/assets/fonts/nexus_icons.dart';
import 'package:nexus/core/di/di.dart';
import 'package:nexus/features/auth/presentation/viewmodel/auth_cubit.dart';
import 'package:nexus/features/auth/presentation/viewmodel/auth_states.dart';
import 'package:nexus/features/auth/presentation/view/screens/register/register_screen.dart';
import 'package:nexus/modules/home_layout/home_page.dart';
import 'package:nexus/shared/components/components.dart';
import 'package:nexus/shared/components/constants.dart';
import 'package:nexus/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthLoginSuccessState) {
            showToast(message: 'logged in', backgroundColor: Colors.green);
            navigateToAndRemove(context, HomePage());
          } else if (state is AuthLoginErrorState) {
            showToast(message: state.errorMessage);
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      // Logo Container
                      Container(
                        padding: EdgeInsetsGeometry.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadiusGeometry.circular(
                            containerRadius,
                          ),
                          color: primaryColor,
                        ),
                        child: Icon(
                          NexusIcons.nexus_logo,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      const Text(
                        'Nexus',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const Text(
                        'Connect with the next generation of leaders.',
                        style: TextStyle(
                          fontSize: labelMediumTextSize,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(height: 30),
                      // Main Container
                      Container(
                        alignment: AlignmentGeometry.topStart,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(
                            containerRadius,
                          ),
                          color: containerBackgroundColor,
                        ),
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Text(
                              'Please enter your details to sign in.',
                              style: TextStyle(
                                fontSize: labelSmallTextSize,
                                color: secondaryColor,
                              ),
                            ),
                            SizedBox(height: 20),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  formField(
                                    label: 'Email Address',
                                    hint: 'name@company.com',
                                    prefixIcon: NexusIcons.message,
                                    prefixIconSize: iconSmallSize,
                                    controller: emailController,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return 'Your email is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  formField(
                                    label: 'Password',
                                    hint: '123456',
                                    hidePassword: !cubit.isLoginPasswordVisible,
                                    prefixIcon: NexusIcons.lock,
                                    suffixIcon: NexusIcons.eye,
                                    suffixIconSize: iconSmallSize,
                                    onSuffixIconTapped: () {
                                      cubit.toggleLoginPasswordVisibility();
                                    },
                                    controller: passwordController,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return 'A password is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      textButton(
                                        onPressed: () {
                                          showToast(message: 'forgot password');
                                        },
                                        label: 'Forgot Password?',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  ConditionalBuilder(
                                    condition: state is AuthLoginLoadingState,
                                    builder: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    fallback: (context) => button(
                                      label: 'Login',
                                      suffixIcon: Icons.arrow_forward,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.loginUser(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            horizontalDivider(),
                            SizedBox(height: 30),
                            button(
                              label: 'Sign in with Google',
                              labelColor: Colors.black,
                              // TODO: replace temporary icon & color.
                              prefixIcon:
                                  NexusIcons.send_arrow_forward_outlined,
                              prefixIconColor: primaryColor,
                              buttonColor: Colors.transparent,
                              isOutlined: true,
                              outlineColor: primaryColor15,
                              onPressed: () {
                                showToast(message: 'sign in with google');
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: labelMediumTextSize,
                              color: neutralColor,
                            ),
                          ),
                          SizedBox(width: 5),
                          textButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            label: 'Sign In',
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        '© 2026 Nexus. All rights reserved.',
                        style: TextStyle(color: neutralColor),
                      ),
                      Text(
                        'Professionalism in every connection.',
                        style: TextStyle(color: neutralColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
