import 'package:fitness_app/presentation/logic/user/user_bloc.dart';
import 'package:fitness_app/presentation/pages/height_page/height_page.dart';
import 'package:fitness_app/presentation/pages/physical_activity_page/physical_activity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({super.key});

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String? selectedGoal;

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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PhysicalActivityScreen(),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HeightSelectionScreen()),
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "What Is Your Goal?",
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
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0C3FC),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildOption("Lose Weight"),
                        _buildOption("Gain Weight"),
                        _buildOption("Muscle Mass Gain"),
                        _buildOption("Shape Body"),
                        _buildOption("Others"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    
                    onPressed: () {
                      if (selectedGoal != null) {
                         context
                            .read<UserBloc>()
                            .add(UpdateGoalEvent(selectedGoal!));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select your goal.'),
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

  Widget _buildOption(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: RadioListTile<String>(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        value: title,
        groupValue: selectedGoal,
        onChanged: (value) {
          setState(() {
            selectedGoal = value;
          });
        },
        activeColor: Colors.black,
      ),
    );
  }
}
