import 'dart:async';

import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Provider/login.provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../Custom/base_widget.dart';
import '../../../Custom/custom_textfield.dart';
import '../../../Values/values.dart';

class ChangePwd extends StatefulWidget {
  const ChangePwd({Key? key}) : super(key: key);

  @override
  State<ChangePwd> createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Iconsax.arrow_left_1),
        ),
        title: const customText(text: "Change Password", id: 1),
      ),
      resizeToAvoidBottomInset: true,
      child: Consumer<LoginUser>(
        builder: (context, authProvider, child) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                        obscureText: true,
                        hint: "Current Password",
                        controller: authProvider.currentPasswordController),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                        obscureText: true,
                        hint: "New Password",
                        controller: authProvider.newPasswordController),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                        obscureText: true,
                        hint: "Confirm Password",
                        controller: authProvider.confirmPasswordController),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                        onPressed: () {
                          authProvider.updatePassword();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fixedSize: Size(size.width, 60),
                            backgroundColor: AppColors.primaryDarkColor,
                            textStyle: GoogleFonts.lato(fontSize: 20)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.key, color: AppColors.white),
                            SizedBox(
                              width: 10,
                            ),
                            customText(
                              text: "Update Password",
                              id: 1,
                              color: AppColors.white,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
