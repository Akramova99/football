import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/constants.dart';
import '../../../../../utils/constants/styles.dart';
import '../../../../widgets/custom_button.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.find<ProfilePageController>();
  bool isChooseImg = false;
  final ScrollController _scrollController =
      ScrollController(); // Add ScrollController

  // FocusNodes for text fields
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose ScrollController
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    Get.delete<ProfilePageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(builder: (_) {
      controller.nameCont.text =
          controller.name != null ? controller.name! : "";
      controller.phoneNumberCont.text = controller.user.email != null
          ? formatPhoneNumber(controller.user.email!)
          : '';
      return Scaffold(
        body: SafeArea(
          // Ensure UI stays within screen bounds
          child: CustomScrollView(
            controller: _scrollController,
            // Scroll controller for smooth scroll behavior
            slivers: [
              SliverAppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.white,
                title: Text("Profil".tr),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    controller.getData();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 21,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !isChooseImg
                            ? InkWell(
                                onTap: () async {
                                  await controller.chooseImage();
                                  setState(() {
                                    isChooseImg = true;
                                  });
                                },
                                child: _buildImagePicker(),
                              )
                            : _buildSelectedImage(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 17.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                controller.name != null ? controller.name! : "",
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                controller.user.email != null
                                    ? formatPhoneNumber(controller.user.email!)
                                    : '',
                                style: CustomStyles.dataTitle!
                                    .copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        _buildTextField(
                          controller: controller.nameCont,
                          hintText: "Taxallus".tr,
                          iconPath: "assets/images/intro/username_img.png",
                          focusNode: _nameFocusNode,
                          // Assign FocusNode
                          onFieldSubmitted: (value) {
                            _phoneFocusNode
                                .requestFocus(); // Shift focus to phone field
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: controller.phoneNumberCont,
                          hintText: "+998",
                          iconPath: "assets/images/intro/phone.png",
                          inputType: TextInputType.phone,
                          inputFormatters: [controller.phoneNumberMask],
                          focusNode: _phoneFocusNode,
                          // Assign FocusNode
                          onFieldSubmitted: (value) {
                            _passwordFocusNode
                                .requestFocus(); // Shift focus to password field
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildPasswordField(controller),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: "O\'zgartirish".tr,
                          onPress: () {
                            controller.updateUserData();
                            controller.getData();
                          },
                          color: AppColors.baseColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildImagePicker() {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/settings/default_img.png',
              width: 90,
              height: 87,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedImage() {
    return Center(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: ClipOval(
                  child: controller.isUpload
                      ? Image.file(
                          controller.imageFile!,
                          width: 90,
                          height: 87,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/settings/default_img.png',
                          width: 90,
                          height: 87,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 75.w,
            child: IconButton(
              onPressed: () async {
                setState(() {
                  controller.isUpload = false;
                  isChooseImg = false;
                });

                await Future.delayed(const Duration(milliseconds: 100));

                await controller.chooseImage();
                controller.getData();
                setState(() {
                  isChooseImg = true;
                });
              },
              icon: const Icon(
                Icons.close_outlined,
                color: AppColors.redy,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    FocusNode? focusNode, // FocusNode parameter
    Function(String)? onFieldSubmitted, // Field submission callback
  }) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 20,
            height: 20,
          ),
          const VerticalDivider(
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(fontFamily: "Poppins"),
              ),
              keyboardType: inputType,
              inputFormatters: inputFormatters,
              focusNode: focusNode,
              // Assign FocusNode
              onSubmitted: onFieldSubmitted, // Handle field submission
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(ProfilePageController controller) {
    Logger().i(controller.passwordCont.text);
    return Container(
      height: 64,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/intro/password_img.png",
            width: 20,
            height: 20,
          ),
          const VerticalDivider(
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          Expanded(
            child: TextField(
              controller: controller.passwordCont,
              obscureText: controller.showPassword,
              cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Parol".tr,
                hintStyle: const TextStyle(fontFamily: "Poppins"),
                suffixIcon: IconButton(
                  icon: controller.showPassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: controller.hidePassword,
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              focusNode: _passwordFocusNode, // Assign FocusNode to password
            ),
          ),
        ],
      ),
    );
  }
}
