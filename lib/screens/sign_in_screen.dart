import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solulab5/blocs/auth_bloc/auth_bloc.dart';

import 'package:solulab5/widgets/common_widgets.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(context, '/home');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Successfully Logged In!',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Error Occured!',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
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
                      text: 'Welcome Back',
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF101817)),
                  const SizedBox(height: 8.0),
                  customSwitzerText(
                      text: 'Welcome Back! Please Enter Your Details.',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF828A89)),
                  const SizedBox(height: 32.0),
                  customTextFormField(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 16.0),
                  customTextFormField(
                    labelText: 'Password',
                    hintText: '*******',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (value) {},
                          ),
                          customSwitzerText(
                              text: 'Remember For 30 Days',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF828A89)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: customSwitzerText(
                          text: 'Forgot password',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF101817),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: customButton(
                      text: 'Sign In',
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              SignInEvent(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 56.0,
                    child: customGoogleButton(
                        text: 'Sign In With Google', onPressed: () {}),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customSwitzerText(
                          text: 'Don’t have an account?',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF828A89)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: customSwitzerText(
                          text: 'Sign Up for free',
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
