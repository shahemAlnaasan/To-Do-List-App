import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../controller/date_picker_controller.dart';
import '../../controller/todo_bloc/todo_bloc.dart';
import '../../model/date_model.dart';
import '../../model/user_data/user_data.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_todo.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageNameController = TextEditingController();
  DatePickerController? datePickerController = DatePickerController();

  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  Future<DateTime?>? deadlinePicked;
  File? image;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        imageNameController.text = pickedFile.name;
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
          imageNameController.text = pickedFile.name;
        });
      }
    } else {
      return;
    }
  }

  void showImageSourceSelector(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    pickImageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take from Camera'),
                  onTap: () {
                    pickImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 375.sp,
        height: 722.sp,
        decoration: const BoxDecoration(
            color: Color(0xffF79E89),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.only(top: 16.sp, left: 24.sp, right: 24.sp),
          child: Column(
            children: [
              Image.asset("icons/Rectangle.png"),
              SizedBox(height: 20.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 327.sp,
                    height: 48.sp,
                    child: CustomTextFormTodo(
                      textInputAction: TextInputAction.next,
                      focusNode: titleFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(descriptionFocusNode);
                      },
                      controller: titleController,
                      color: Colors.white,
                      keyboardType: TextInputType.text,
                      hint: 'Title',
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  SizedBox(
                    width: 327.sp,
                    height: 400.sp,
                    child: CustomTextFormTodo(
                      textInputAction: TextInputAction.done,
                      focusNode: descriptionFocusNode,
                      controller: descriptionController,
                      color: Colors.white,
                      hint: 'Description',
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  SizedBox(
                    width: 327.sp,
                    height: 48.sp,
                    child: CustomTextFormTodo(
                      controller: datePickerController!.dateController,
                      suffixIconColor:
                          datePickerController!.dateController.text.isEmpty
                              ? const Color.fromARGB(112, 255, 255, 255)
                              : Colors.white,
                      hintColor:
                          datePickerController!.dateController.text.isEmpty
                              ? const Color.fromARGB(112, 255, 255, 255)
                              : Colors.white,
                      color: datePickerController!.dateController.text.isEmpty
                          ? const Color.fromARGB(112, 255, 255, 255)
                          : Colors.white,
                      readOnly: true,
                      hint: 'Deadline (Optional)',
                      suffixIcon: Image.asset(
                        "icons/calendar.png",
                        color: datePickerController!.dateController.text.isEmpty
                            ? const Color.fromARGB(112, 255, 255, 255)
                            : Colors.white,
                      ),
                      onTap: () {
                        deadlinePicked =
                            datePickerController!.selectDate(context);
                      },
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  SizedBox(
                    width: 327.sp,
                    height: 48.sp,
                    child: CustomTextFormTodo(
                      suffixIconColor: imageNameController.text.isEmpty
                          ? const Color.fromARGB(112, 255, 255, 255)
                          : Colors.white,
                      controller: imageNameController,
                      hintColor: imageNameController.text.isEmpty
                          ? const Color.fromARGB(112, 255, 255, 255)
                          : Colors.white,
                      color: imageNameController.text.isEmpty
                          ? const Color.fromARGB(112, 255, 255, 255)
                          : Colors.white,
                      onTap: () {
                        showImageSourceSelector(context);
                      },
                      readOnly: true,
                      hint: 'Add Image (Optional)',
                      suffixIcon: Image.asset(
                        "icons/image.png",
                        color: imageNameController.text.isEmpty
                            ? const Color.fromARGB(112, 255, 255, 255)
                            : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  CustomButton(
                    title: "ADD TODO",
                    color: Colors.white,
                    textColor: const Color(0xffF79E89),
                    onTap: () async {
                      final title = titleController.text;

                      final description = descriptionController.text;

                      final DateTime? deadline = await deadlinePicked;

                      final DateTime creatingDate = DateModel().nowDate;

                      String? imagePath;
                      if (image != null) {
                        imagePath = image!.path;
                      }

                      final UserData userData = UserData(
                        title: title,
                        description: description,
                        creatingDate: creatingDate,
                        deadline: deadline,
                        image: imagePath,
                      );

                      // ignore: use_build_context_synchronously
                      BlocProvider.of<TodoBloc>(context)
                          .add(AddTodosEvent(userData: userData));

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
