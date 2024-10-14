import 'package:fitness_app/domain/entites/user_entity.dart';
import 'package:fitness_app/presentation/logic/auth/auth_bloc.dart';
import 'package:fitness_app/presentation/logic/user/user_bloc.dart';
import 'package:fitness_app/presentation/pages/biometric_page/biometric_page.dart';
import 'package:fitness_app/presentation/pages/signup_page/signup_page.dart';
import 'package:fitness_app/presentation/widgets/text_field_control.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if  (state is AuthRegistered) {
            context.read<UserBloc>().add(GetUserByIdEvent(userId: state.userId ?? ""));
        } 
          else if (state is AuthStateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? ''),
              ),
            );
          }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: const Color.fromARGB(255, 87, 83, 83),
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 70),
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0C3FC),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 30.0,
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            label: 'Username or email',
                            hintText: 'example@example.com',
                          ),
                          const SizedBox(height: 20.0),
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Password',
                            hintText: '********',
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              SignInEvent(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 80),
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Log In",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'or sign up with',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    IconButton(
                      icon: SvgPicture.asset("assets/svgs/Google Icon.svg"),
                      onPressed: () {
                        context.read<AuthBloc>().add(SignInWithGoogleEvent());
                      },
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, authstate) {
                        if (authstate is AuthStateFailed &&
                            authstate.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(authstate.error ?? '')));
                        } else if (authstate is AuthUserLoaded &&
                            authstate.userId != null) {
                          context.read<UserBloc>().add(AddUserToDbEvent(
                              UserEntity(
                                  userId: authstate.userId,
                                  email: authstate.email,
                                  displayName: authstate.displayName,
                                  photoUrl: authstate.photoUrl)));
                        } else if (authstate is AuthUserLoaded &&
                            authstate.userId != null) {
                          BlocProvider.of<UserBloc>(context)
                              .add(ListenUserEvent(userId: authstate.userId!));
                        }
                      },
                      builder: (context, authstate) {
                        if (authstate is AuthUserLoading) {
                          return const CircularProgressIndicator();
                        } else if (authstate is AuthStateFailed) {
                          return Text('Error: ${authstate.error}');
                        }
                        return const SizedBox(height: 16);
                      },
                    ),
                    BlocListener<UserBloc, UserState>(
                      listener: (context, userstate) {
                        if (userstate is UserLoaded) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BiometricPage()),
                          );
                        }
                      },
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, userstate) {
                          if (userstate is UserLoading) {
                            return const Text("Loading");
                          } else if (userstate is UserFailed) {
                            return Text('Error: ${userstate.error}');
                          }
                          return const SizedBox(height: 32);
                        },
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => const SignUpPage()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
