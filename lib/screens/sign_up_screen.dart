import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solulab5/blocs/auth_bloc/auth_bloc.dart';
import 'package:solulab5/models/user.dart';
import 'package:solulab5/widgets/common_widgets.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),

      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  customBackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 32.0),
                  customSwitzerText(
                      text: 'Create Account',
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF101817)),
                  const SizedBox(height: 8.0),
                  customSwitzerText(
                      text: 'Let’s create account toghter',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF828A89)),
                  const SizedBox(height: 32.0),
                  customTextFormField(
                    labelText: 'Full Name',
                    hintText: 'Enter your name',
                    controller: nameController,
                  ),
                  const SizedBox(height: 16.0),
                  customTextFormField(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 16.0),
                  customTextFormField(
                    labelText: 'Number',
                    hintText: 'Enter your number',
                    controller: numberController,
                  ),
                  const SizedBox(height: 16.0),
                  customTextFormField(
                    labelText: 'Password',
                    hintText: '*******',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  customTextFormField(
                    labelText: 'Confirm Password',
                    hintText: '*******',
                    controller: confirmPasswordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: customButton(
                      text: 'Sign Up',
                      onPressed: () {
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                        final newUser = User(
                          name: nameController.text,
                          email: emailController.text,
                          number: numberController.text,
                          password: passwordController.text,
                        );
                        context.read<AuthBloc>().add(SignUpEvent(newUser));
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 56.0,
                    child: customGoogleButton(
                        text: 'Sign Up With Google', onPressed: () {}),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customSwitzerText(
                          text: 'Already have an account?',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF828A89)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        child: customSwitzerText(
                          text: 'Sign In',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF101817),
                        ),
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
  }
}
