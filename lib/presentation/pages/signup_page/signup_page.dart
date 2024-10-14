import 'package:fitness_app/domain/entites/user_entity.dart';
import 'package:fitness_app/presentation/logic/auth/auth_bloc.dart';
import 'package:fitness_app/presentation/logic/user/user_bloc.dart';
import 'package:fitness_app/presentation/pages/home_page/home_page.dart';
import 'package:fitness_app/presentation/pages/signin_page/signin_page.dart';
import 'package:fitness_app/presentation/widgets/text_field_control.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? '')),
          );
        } else if (state is AuthRegistered && state.userId != null) {
          context.read<UserBloc>().add(UpdateEmailEvent(_textController.text));
          context.read<UserBloc>().add(UpdateNameEvent(_nameController.text));
        }
      },
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? '')),
            );
          } else if (state is UserDataUpdated) {
            context.read<UserBloc>().add(
                  SubmitUserEvent(
                    UserEntity(
                      userId: context.read<AuthBloc>().state.userId,
                      email: state.email,
                      fullname: state.fullname
                    ),
                  ),
                );
          } else if (state is UserLoaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 87, 83, 83),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.yellow),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()),
                            );
                          },
                        ),
                      ),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Let's Start!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFE0C3FC),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 30.0),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _nameController,
                                label: 'Full name',
                                hintText: 'example@example.com',
                              ),
                              const SizedBox(height: 20.0),
                              CustomTextField(
                                controller: _textController,
                                label: 'Email or Mobile Number',
                                hintText: '+123 567 89000',
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                  controller: _passwordController,
                                  label: 'Password',
                                  hintText: '********',
                                  isPassword: true),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: _confirmpassController,
                                label: 'Confirm Password',
                                hintText: '********',
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'By continuing, you agree to \n Terms of Use and Privacy Policy.',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          final email = _textController.text.trim();
                          final password = _passwordController.text.trim();
                          final fullname = _nameController.text.trim();
                          final confpass = _confirmpassController.text.trim();

                          if (fullname.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter your full name'),
                              ),
                            );
                          } else if (email.isNotEmpty &&
                              password.isNotEmpty &&
                              confpass.isNotEmpty) {
                            if (password == confpass) {
                              context
                                  .read<AuthBloc>()
                                  .add(SignUpEvent(email, password));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passwords do not match'),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please fill in all the required fields'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text("Sign Up",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                      const Text('or sign up with',
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      IconButton(
                        icon: SvgPicture.asset("assets/svgs/Google Icon.svg"),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 5),
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
                                text: 'Log In',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => const SignInPage()),
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
      ),
    );
  }
}