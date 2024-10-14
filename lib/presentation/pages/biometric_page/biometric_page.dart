import 'package:fitness_app/data/repositories/biometric_repository_imp.dart';
import 'package:fitness_app/data/services/biometric_service/biometric_service_imp.dart';
import 'package:fitness_app/presentation/logic/biometric/biometric_bloc.dart';
import 'package:fitness_app/presentation/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricPage extends StatefulWidget {
  const BiometricPage({super.key});

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final biometricService = BiometricServiceImp();
        final biometricRepository = BiometricRepositoryImp(biometricService);
        final biometricBloc = BiometricBloc(biometricRepository);
        biometricBloc.add(const CheckBiometricSupportEvent());
        return biometricBloc;
      },
      child: BlocConsumer<BiometricBloc, BiometricState>(
        listener: (context, state) {
          if (state is BiometricAuthenticated) {
            if (state.isAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Authentication successful!'),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Authentication failed!'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          final bool isAuthenticated = state is BiometricAuthenticated && state.isAuthenticated;

          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width:  MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(255, 87, 83, 83),
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Set Your Biometric Data',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 70),
                    if (state is BiometricSupportChecked)
                      state.isSupported
                          ? Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE0C3FC),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 100.0,
                                    vertical: 70.0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () {
                                        context
                                            .read<BiometricBloc>()
                                            .add(const AuthenticateUserEvent());
                                      },
                                      style: TextButton.styleFrom(
                                        textStyle: const TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/images/Mark.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Biometric not supported',
                              style: TextStyle(color: Colors.red),
                            ),
                    if (state is BiometricAuthenticated)
                      state.isAuthenticated
                          ? const Text(
                              'Authenticated',
                              style: TextStyle(color: Colors.green),
                            )
                          : const Text(
                              'Authentication failed',
                              style: TextStyle(color: Colors.red),
                            ),
                    if (state is! BiometricSupportChecked &&
                        state is! BiometricAuthenticated)
                      const CircularProgressIndicator(),
                    const SizedBox(height: 40.0),
                    if (!isAuthenticated)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
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
                        child: const Text("Skip",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    const SizedBox(height: 20.0),
                    
                    ElevatedButton(
                      onPressed: () {
                        if (state is BiometricAuthenticated) {
                          if (state.isAuthenticated) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Authentication failed! Please try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
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
                      child: const Text("Continue",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
