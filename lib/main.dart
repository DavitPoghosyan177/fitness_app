import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/data/repositories/auth_repository_imp.dart';
import 'package:fitness_app/data/repositories/biometric_repository_imp.dart';
import 'package:fitness_app/data/repositories/media_repository_imp.dart';
import 'package:fitness_app/data/repositories/user_repository_imp.dart';
import 'package:fitness_app/data/services/auth_service/auth_service.dart';
import 'package:fitness_app/data/services/auth_service/auth_service_imp.dart';
import 'package:fitness_app/data/services/biometric_service/biometric_service.dart';
import 'package:fitness_app/data/services/biometric_service/biometric_service_imp.dart';
import 'package:fitness_app/data/services/media_service/media_serivce.dart';
import 'package:fitness_app/data/services/media_service/media_service_imp.dart';
import 'package:fitness_app/data/services/user_service/user_service.dart';
import 'package:fitness_app/data/services/user_service/user_service_imp.dart';
import 'package:fitness_app/domain/repositories/auth_repository.dart';
import 'package:fitness_app/domain/repositories/biometric_repository.dart';
import 'package:fitness_app/domain/repositories/media_repository.dart';
import 'package:fitness_app/domain/repositories/user_repository.dart';
import 'package:fitness_app/presentation/logic/auth/auth_bloc.dart';
import 'package:fitness_app/presentation/logic/biometric/biometric_bloc.dart';
import 'package:fitness_app/presentation/logic/media/media_bloc.dart';
import 'package:fitness_app/presentation/logic/user/user_bloc.dart';
import 'package:fitness_app/presentation/pages/native_splash_page/native_splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void _initCrashlytics() {
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError =
      (Object exception, StackTrace stackTrace) {
    FirebaseCrashlytics.instance
        .recordError(exception, stackTrace, fatal: true);
    return true;
  };
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final FirebaseApp firebaseApp = await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCYhmJPkYCw1OwEhy7hP8Seu1DgXg_XenU",
      appId: '1:180992421387:android:2c64a4710e649334d4610e',
      messagingSenderId: '',
      projectId: 'fitnessapp-cc104',
      storageBucket: 'fitnessapp-cc104.appspot.com',
    ),
  );
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  _initCrashlytics();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthService>(
          create: (context) => AuthServiceImp(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImp(
              authService: RepositoryProvider.of<AuthService>(context)),
        ),
        RepositoryProvider<UserService>(
          create: (context) => UserServiceImp(
              firebaseFirestore:
                  FirebaseFirestore.instanceFor(app: firebaseApp),
              firebaseStorage: FirebaseStorage.instance),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryImp(
            userService: RepositoryProvider.of<UserService>(context),
            authService: RepositoryProvider.of<AuthService>(context),
          ),
        ),
        RepositoryProvider<BiometricService>(
          create: (context) => BiometricServiceImp(),
        ),
        RepositoryProvider<BiometricRepository>(
          create: (context) => BiometricRepositoryImp(
              RepositoryProvider.of<BiometricService>(context)),
        ),
        RepositoryProvider<MediaService>(
            create: (context) => MediaServiceImp(
                FirebaseFirestore.instanceFor(app: firebaseApp),
                FirebaseStorage.instance)),
        RepositoryProvider<MediaRepository>(
          create: (context) => MediaRepostoryImp(
              mediaService: RepositoryProvider.of<MediaService>(context)),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                AuthBloc(RepositoryProvider.of<AuthRepository>(context))),
        BlocProvider(
            create: (context) => UserBloc(
                  RepositoryProvider.of<UserRepository>(context),
                )),
        BlocProvider(
            create: (context) => BiometricBloc(
                  RepositoryProvider.of<BiometricRepository>(context),
                )),
        BlocProvider(
          create: (context) => MediaBloc(
            RepositoryProvider.of<MediaRepository>(context),
          )
            ..add(LoadVideosEvent())
            ..add(LoadArticlesEvent()),
        ),
      ], child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
