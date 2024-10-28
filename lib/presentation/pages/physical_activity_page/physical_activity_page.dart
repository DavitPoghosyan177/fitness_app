import 'package:fitness_app/domain/entites/user_entity.dart';
import 'package:fitness_app/presentation/logic/auth/auth_bloc.dart';
import 'package:fitness_app/presentation/logic/user/user_bloc.dart';
import 'package:fitness_app/presentation/pages/fill_profile_page/fill_profile_page.dart';
import 'package:fitness_app/presentation/pages/gender_selection_pge/gender_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhysicalActivityScreen extends StatefulWidget {
  const PhysicalActivityScreen({super.key, this.userEntity});
  final UserEntity? userEntity;

  @override
  State<PhysicalActivityScreen> createState() => _PhysicalActivityScreenState();
}

class _PhysicalActivityScreenState extends State<PhysicalActivityScreen> {
  String? selectedLevel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
       if (state is UserFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error ?? 'An error occurred'),
            ),
          );
        } else if (state is UserDataUpdated) {
           context.read<UserBloc>().add(
                UpdateUserDataEvent(
                  UserEntity(
                    userId: context.read<AuthBloc>().state.userId,
                    gender: state.gender,
                    age: state.age,
                    weight: state.weight,
                    height: state.height,
                    goal: state.goal,
                    activity: state.activity
                  ),
                ),
              );
               Navigator.pushReplacement(
             context,
             MaterialPageRoute(
               builder: (context) => const FillProfileScreen(),
             ),
           );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[800],
          appBar: AppBar(
            backgroundColor: Colors.grey[800],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.yellow),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GenderSelectionScreen()),
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Physical Activity Level",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOptionButton(
                          "Beginner", Colors.white, Colors.purple),
                      const SizedBox(height: 24),
                      _buildOptionButton(
                          "Intermediate", Colors.white, Colors.purple),
                      const SizedBox(height: 24),
                      _buildOptionButton(
                          "Advance", const Color(0xFFBFF33D), Colors.black),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                        if (selectedLevel != null) {
                         context
                            .read<UserBloc>()
                            .add(UpdateActivityEvent(selectedLevel!));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select your activity.'),
                          ),
                        );
                      }
                    
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 60),
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Continue",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(String title, Color bgColor, Color textColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLevel = title;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
