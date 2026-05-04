import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/assets/fonts/nexus_icons.dart';
import 'package:nexus/modules/auth/cubit/auth_cubit.dart';
import 'package:nexus/modules/auth/cubit/auth_states.dart';
import 'package:nexus/modules/home_layout/home_page.dart';
import 'package:nexus/shared/components/components.dart';
import 'package:nexus/shared/components/constants.dart';
import 'package:nexus/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmationController =
        TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthRegisterSuccessState) {
            // TODO: fix the null bug here
            showToast(
              message: 'Welcome ${state.credential.user!.displayName}!',
              backgroundColor: Colors.green,
            );
            navigateToAndRemove(context, HomePage());
          } else if (state is AuthRegisterErrorState) {
            showToast(message: state.errorMessage);
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);

          return Scaffold(
            appBar: appBar(),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(
                      containerRadius,
                    ),
                    color: containerBackgroundColor,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const Text(
                          'Fill in your details to start networking.',
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
                                label: 'Full Name',
                                hint: 'John Doe',
                                controller: nameController,
                                validator: (input) {
                                  if (input == null || input.isEmpty) {
                                    return 'Your name is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              formField(
                                label: 'Email Address',
                                hint: 'name@company.com',
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
                                hidePassword: true,
                                controller: passwordController,
                                validator: (input) {
                                  if (input == null || input.isEmpty) {
                                    return 'A password is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              formField(
                                label: 'Confirm Password',
                                hint: '123456',
                                hidePassword: true,
                                controller: passwordConfirmationController,
                                validator: (input) {
                                  if (input == null || input.isEmpty) {
                                    return 'You have to confirm password';
                                  } else if (input != passwordController.text) {
                                    return 'Match password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              ConditionalBuilder(
                                condition: state is AuthRegisterLoadingState,
                                builder: (context) =>
                                    Center(child: CircularProgressIndicator()),
                                fallback: (context) => button(
                                  label: 'Create Account',
                                  suffixIcon:
                                      NexusIcons.send_arrow_forward_outlined,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.createUser(
                                        name: nameController.text,
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
                        horizontalDivider(centerLabel: 'OR CONTINUE WITH'),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: button(
                                label: 'Google',
                                labelColor: Colors.black,
                                // TODO: replace temporary icon.
                                prefixIcon:
                                    NexusIcons.send_arrow_forward_outlined,
                                // TODO: remove temporary color.
                                prefixIconColor: primaryColor,
                                buttonColor: Colors.transparent,
                                isOutlined: true,
                                onPressed: () {
                                  showToast(message: 'coming soon');
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: button(
                                label: 'Apple',
                                labelColor: Colors.black,
                                // TODO: replace temporary icon.
                                prefixIcon:
                                    NexusIcons.send_arrow_forward_outlined,
                                // TODO: remove temporary color.
                                prefixIconColor: primaryColor,
                                buttonColor: Colors.transparent,
                                isOutlined: true,
                                onPressed: () {
                                  showToast(message: 'coming soon');
                                },
                              ),
                            ),
                          ],
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
                                Navigator.pop(context);
                              },
                              label: 'Sign In',
                            ),
                          ],
                        ),
                      ],
                    ),
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
