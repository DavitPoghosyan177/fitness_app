import 'package:fitness_app/domain/entites/user_entity.dart';
import 'package:fitness_app/presentation/logic/media/media_bloc.dart';
import 'package:fitness_app/presentation/logic/user/user_bloc.dart';
import 'package:fitness_app/presentation/pages/first_setup_page/first_setup_page.dart';
import 'package:fitness_app/presentation/widgets/text_field_for_fill_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({super.key, this.userEntity});
  final UserEntity? userEntity;

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaBloc, MediaState>(
      listener: (context, mediaState) {
        if (mediaState is MediaFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(mediaState.error)));
        } else if (mediaState is MediaUpdated) {
          context.read<UserBloc>().add(GetUserByIdEvent(
              userId: context.read<UserBloc>().state.userEntity?.userId ?? ""));
        }
      },
      builder: (context, mediaState) {
        return BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error ?? 'An error occurred'),
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
                          builder: (context) => const FitnessScreen()),
                    );
                  },
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Fill Your Profile",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 62,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.black,
                              backgroundImage: NetworkImage(
                                state.userEntity?.photoUrl ?? "",
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Choose an option'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            context.read<MediaBloc>().add(
                                                UploadPictureFromGalleryEvent());
                                          },
                                          child:
                                              const Text('Choose from Gallery'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            context.read<MediaBloc>().add(
                                                UploadPictureFromCameraEvent());
                                          },
                                          child: const Text('Take a Picture'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit,
                                  size: 20, color: Colors.black),
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(),
                              iconSize: 20,
                              color: Colors.black,
                              splashRadius: 24,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.yellow),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  const CircleBorder(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    CustomTextFieldForFillPage(
                      label: "Full name",
                      hintText: "Madison Smith",
                      controller: fullNameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFieldForFillPage(
                      label: "Nickname",
                      hintText: "Madison",
                      controller: nicknameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFieldForFillPage(
                      label: "Email",
                      hintText: "madisons@example.com",
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFieldForFillPage(
                      label: "Mobile Number",
                      hintText: "+123 567 89000",
                      controller: phoneController,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UserBloc>().add(
                                UpdateUserDataEvent(UserEntity(
                                  userId: state.userEntity?.userId ?? "",
                                  displayName: fullNameController.text.isEmpty
                                      ? null
                                      : fullNameController.text,
                                  email: emailController.text.isEmpty
                                      ? null
                                      : emailController.text,
                                  nickName: nicknameController.text.isEmpty
                                      ? null
                                      : nicknameController.text,
                                  mobileNumber: phoneController.text.isEmpty
                                      ? null
                                      : phoneController.text,
                                )),
                              );
                          context.read<UserBloc>().add(
                              UpdateNickNameEvent(nicknameController.text));
                          context.read<UserBloc>().add(
                              UpdateMobileNumberEvent(phoneController.text));
                          if (mediaState is MediaLoaded) {
                            context.read<MediaBloc>().add(
                                  UploadProfilePhotoEvent(
                                    state.userEntity?.userId ?? '',
                                    mediaState.fileImage!.file,
                                  ),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 60),
                          backgroundColor: const Color(0xFFBFF33D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text("Start",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
