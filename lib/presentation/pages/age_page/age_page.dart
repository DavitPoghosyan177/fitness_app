import 'package:fitness_app/domain/entites/user_entity.dart';
import 'package:fitness_app/presentation/logic/user/user_bloc.dart';
import 'package:fitness_app/presentation/pages/gender_selection_pge/gender_selection_page.dart';
import 'package:fitness_app/presentation/pages/weight_page/weight_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeSelectionScreen extends StatefulWidget {
  const AgeSelectionScreen({super.key, this.userEntity});
  final UserEntity? userEntity;

  @override
  State<AgeSelectionScreen> createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  int selectedAge = 28;

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
              builder: (context) => const WeightSelectionScreen(),
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
                      builder: (context) => const GenderSelectionScreen()),
                );
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'How Old Are You?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                '$selectedAge',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Icon(
                Icons.arrow_drop_up,
                color: Colors.yellow,
                size: 60,
              ),
              SizedBox(
                height: 150,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 151,
                  onPageChanged: (index) {
                    setState(() {
                      selectedAge = index + 18;
                    });
                  },
                  controller: PageController(
                    initialPage: selectedAge - 18,
                    viewportFraction: 0.2,
                  ),
                  itemBuilder: (context, index) {
                    final age = index + 18;
                    final isSelected = selectedAge == age;
    
                    return Center(
                      child: Container(
                        height: isSelected ? 100 : 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFE0C3FC)
                              : Colors.purple.withOpacity(0.2),
                          shape: BoxShape.rectangle,
                        ),
                        child: Text(
                          '$age',
                          style: TextStyle(
                              fontSize: isSelected ? 36 : 24,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFFE0C3FC)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                      context
                          .read<UserBloc>()
                          .add(UpdateAgeEvent(selectedAge.toString()));
                                    },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
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
            ],
          ),
        );
      },
    );
  }
}
