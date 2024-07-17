// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:typed_data';

import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Custom/texts.dart';
import 'package:C4CARE/Model/profilemodel.dart';
import 'package:C4CARE/Provider/profile.provider.dart';
import 'package:C4CARE/Values/dialogs.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/template_widgets/radio_widget.dart';
import 'package:C4CARE/template_widgets/radio_widget3.dart';
import 'package:C4CARE/template_widgets/radio_widget4.dart';
import 'package:C4CARE/template_widgets/radio_widget6.dart';
import 'package:C4CARE/template_widgets/radio_widget7.dart';
import 'package:C4CARE/Custom/widgets/cached_image.dart';
import 'package:C4CARE/Custom/widgets/square_button.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileTemplate2 extends StatefulWidget {
  final ProfileModel profile;
  const ProfileTemplate2({super.key, required this.profile});

  @override
  State<ProfileTemplate2> createState() => _ProfileTemplate2State();
}

class _ProfileTemplate2State extends State<ProfileTemplate2>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false)
        .getProfileDetails(widget.profile);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) => SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const customText(text: 'Additional Details', id: 1),
              backgroundColor: AppColors.primaryDarkColor,
              leading: InkWell(
                onTap: () => Dialogs.showAlertDialog(
                  context: context,
                  subTitle: "Are you sure you want to exit",
                  title: "Save all changes before closing?",
                  yesClick: () => Navigator.pop(context),
                ),
                child: const Icon(Iconsax.arrow_left_1),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Stack(
                                  children: [
                                    if (profileProvider.selectedImage != null)
                                      Image.memory(
                                          profileProvider.selectedImage!,
                                          width: 70,
                                          height: 70)
                                    else
                                      CachedImage.load(
                                          widget.profile.imageUrl ?? "", context,
                                          size: 70),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: SquareButton(
                                        size: 30.0,
                                        fillColor: Colors.black26,
                                        child: const Icon(
                                          Iconsax.edit,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          XFile? result =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          if (result != null) {
                                            Uint8List bytes =
                                                await result.readAsBytes();
                                            profileProvider.setImage(bytes);
                                            profileProvider.updateProfileImage(
                                                widget.profile.id!, bytes);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                      text:
                                          "${widget.profile.firstName} ${widget.profile.lastName}",
                                      textSize: 19,
                                      weight: FontWeight.bold,
                                      id: 1),
                                  customText(
                                    text: widget.profile.role!.name!,
                                    id: 1,
                                    textSize: 18,
                                    color: AppColors.black,
                                  ),
                                  customText(
                                    text: widget.profile.employeeId!,
                                    id: 1,
                                    textSize: 18,
                                    color: AppColors.black,
                                  ),
                                  customText(
                                    text: widget.profile.email!,
                                    id: 1,
                                    textSize: 15,
                                  ),
                                  customText(
                                      text: widget.profile.mobile!,
                                      textSize: 14,
                                      id: 1),

                                  // Texts.mediumBold(widget.profile.city),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        // const SizedBox(height: 22.0),
                        Texts.largeBold(
                            "SECTION 2 - COMPLIANCE CHECKS PROOF OF IDENTITY AND RIGHT TO WORK",
                            color: Colors.red),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1:
                              profileProvider.profileDetailsTemp2?.documentType,
                          title: "ID and Proof of Address verified",
                          groupValue:
                              profileProvider.profileDetailsTemp2?.idVerified,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint:
                              'Type of document(s) seen and verified(ie; Passport, Birth Certificate)',
                          onChange: (val) =>
                              profileProvider.setIdVerifiedTemp2(val),
                          onFormChange: (v) =>
                              profileProvider.setDocumentTypeTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetailsTemp2?.workInUkVerifiedDocument,
                          title: "Right to Work in UK verified",
                          groupValue: profileProvider
                              .profileDetailsTemp2?.workInUkVerified,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint:
                              'Type of document(s) seen and verified (ie; Visa, Share Code)',
                          onChange: (val) =>
                              profileProvider.setWorkInUkVerifiedTemp2(val),
                          onFormChange: (v) => profileProvider
                              .setWorkInUkVerifiedDocumentTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetailsTemp2?.individualRightExpiry,
                          title:
                              "Is there a time limit on individual’s right to stay and work in UK?",
                          groupValue: profileProvider
                              .profileDetailsTemp2?.individualRight,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint:
                              'If Yes, date permit is due to expire(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setIndividualRightTemp2(val),
                          onFormChange: (v) =>
                              profileProvider.setIndividualRightExpiryTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        Texts.regularBold("CRIMINALITY CHECKS",
                            color: AppColors.primaryDarkColor),
                        const SizedBox(height: 16.0),
                        RadioWidget7(
                          title: "Type of criminality checks obtained ",
                          groupValue: profileProvider
                              .profileDetailsTemp2?.criminalityCheckType,
                          firstOption: 'dbs',
                          secondOption: 'pvg',
                          thirdOption: 'none',
                          firstOptionText: 'DBS(England)',
                          secondOptionText: 'PVG(Scotland)',
                          thirdOptionText: 'None',
                          onChange: (v) =>
                              profileProvider.setCriminalityCheckTypeTemp2(v),
                          formValue1: profileProvider
                              .profileDetailsTemp2?.disclosureCertificateNo,
                          formValue2: profileProvider
                              .profileDetailsTemp2?.disclosureIssueDate,
                          onFormChange1: (v) {
                            profileProvider.setDisclosureCertificateNoTemp2(v);
                          },
                          onFormChange2: (v) {
                            profileProvider.setDisclosureIssueDateTemp2(v);
                          },
                        ),
                        if (profileProvider
                                .profileDetailsTemp2?.criminalityCheckType !=
                            "none")
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: RadioWidget(
                              title: "Level of Check",
                              groupValue: profileProvider
                                  .profileDetailsTemp2?.levelOfCheck,
                              firstOption: 'enhanced',
                              secondOption: 'standard',
                              firstOptionText: 'Enhanced',
                              secondOptionText: 'Standard',
                              onChange: (val) =>
                                  profileProvider.setLevelOfCheckTemp2(val),
                            ),
                          ),
                        const SizedBox(height: 16.0),
                        Texts.regularBold(
                            "PROFESSIONAL BODY REGISTRATION FOR CANDIDATE",
                            color: AppColors.primaryDarkColor),
                        const SizedBox(height: 16.0),
                        RadioWidget4(
                          title:
                              "Do you hold an NMC-assigned registration number?",
                          formValue1:
                              profileProvider.profileDetailsTemp2?.nmcPin,
                          formValue2: profileProvider
                              .profileDetailsTemp2?.nmcRenewalDate,
                          groupValue: profileProvider
                              .profileDetailsTemp2?.nmcRegistration,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'PIN',
                          hint2: 'Renewal date:',
                          onChange: (v) =>
                              profileProvider.setNmcRegistrationTemp2(v),
                          onFormChange1: (v) =>
                              profileProvider.setNmcPinTemp2(v),
                          onFormChange2: (v) =>
                              profileProvider.setNmcRenewalDateTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          decoration: Decorations.boxDecorationColor(
                              color: Colors.black12),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Texts.regular("Certificate Upload"),
                              const SizedBox(height: 16.0),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Stack(
                                  children: [
                                    if (profileProvider
                                            .imageCertificateUpload !=
                                        null)
                                      Image.memory(
                                          profileProvider
                                              .imageCertificateUpload!,
                                          width: 160,
                                          height: 160)
                                    else
                                      CachedImage.load(
                                          profileProvider.profileDetailsTemp2
                                                  ?.certificateImageUrl ??
                                              "",
                                          context,
                                          size: 160),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: SquareButton(
                                        size: 30.0,
                                        fillColor: Colors.black26,
                                        child: const Icon(
                                          Icons.edit,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          XFile? result =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          if (result != null) {
                                            Uint8List bytes =
                                                await result.readAsBytes();

                                            profileProvider
                                                .setImageCertificateUpload(
                                                    bytes);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Texts.largeBold(
                            "SECTION 3 - TRAINING AND QUALIFICATIONS",
                            color: Colors.red),
                        const SizedBox(height: 16.0),
                        RadioWidget4(
                          title: "Health & Safety at Work",
                          formValue1: profileProvider
                              .profileDetailsTemp2?.healthSafetyCU,
                          formValue2: profileProvider
                              .profileDetailsTemp2?.healthSafetyCV,
                          groupValue:
                              profileProvider.profileDetailsTemp2?.healthSafety,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Dates of Course (DD/MM/YYYY)',
                          hint2: 'Course Validity (DD/MM/YYYY)',
                          onChange: (v) =>
                              profileProvider.setHealthSafetyTemp2(v),
                          onFormChange1: (v) =>
                              profileProvider.setHealthSafetyCUTemp2(v),
                          onFormChange2: (v) =>
                              profileProvider.setHealthSafetyCVTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget4(
                          title: "Moving & Handling of People",
                          formValue1: profileProvider
                              .profileDetailsTemp2?.movingHandlingPeopleCU,
                          formValue2: profileProvider
                              .profileDetailsTemp2?.movingHandlingPeopleCV,
                          groupValue: profileProvider
                              .profileDetailsTemp2?.movingHandlingPeople,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Dates of Course (DD/MM/YYYY)',
                          hint2: 'Course Validity (DD/MM/YYYY)',
                          onChange: (v) =>
                              profileProvider.setMovingHandlingPeopleTemp2(v),
                          onFormChange1: (v) =>
                              profileProvider.setMovingHandlingPeopleCUTemp2(v),
                          onFormChange2: (v) =>
                              profileProvider.setMovingHandlingPeopleCVTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget4(
                          title: "Fire Safety at Work",
                          formValue1: profileProvider
                              .profileDetailsTemp2?.fireSafetyAtWorkCU,
                          formValue2: profileProvider
                              .profileDetailsTemp2?.fireSafetyAtWorkCV,
                          groupValue: profileProvider
                              .profileDetailsTemp2?.fireSafetyAtWork,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Dates of Course (DD/MM/YYYY)',
                          hint2: 'Course Validity (DD/MM/YYYY)',
                          onChange: (v) =>
                              profileProvider.setFireSafetyAtWorkTemp2(v),
                          onFormChange1: (v) =>
                              profileProvider.setFireSafetyAtWorkCUTemp2(v),
                          onFormChange2: (v) =>
                              profileProvider.setFireSafetyAtWorkCVTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget4(
                          title: "Safeguarding Adults (SOVA)",
                          formValue1: profileProvider
                              .profileDetailsTemp2?.safeguardingAdultsCU,
                          formValue2: profileProvider
                              .profileDetailsTemp2?.safeguardingAdultsCV,
                          groupValue: profileProvider
                              .profileDetailsTemp2?.safeguardingAdults,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Dates of Course (DD/MM/YYYY)',
                          hint2: 'Course Validity (DD/MM/YYYY)',
                          onChange: (v) =>
                              profileProvider.setSafeguardingAdultsTemp2(v),
                          onFormChange1: (v) =>
                              profileProvider.setSafeguardingAdultsCUTemp2(v),
                          onFormChange2: (v) =>
                              profileProvider.setSafeguardingAdultsCVTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget4(
                          title: "Infection Prevention & Control",
                          formValue1: profileProvider.profileDetailsTemp2
                              ?.infectionPreventionAndControlCU,
                          formValue2: profileProvider.profileDetailsTemp2
                              ?.infectionPreventionAndControlCV,
                          groupValue: profileProvider.profileDetailsTemp2
                              ?.infectionPreventionAndControl,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Dates of Course (DD/MM/YYYY)',
                          hint2: 'Course Validity (DD/MM/YYYY)',
                          onChange: (v) => profileProvider
                              .setInfectionPreventionAndControlTemp2(v),
                          onFormChange1: (v) => profileProvider
                              .setInfectionPreventionAndControlCUTemp2(v),
                          onFormChange2: (v) => profileProvider
                              .setInfectionPreventionAndControlCVTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget4(
                          title: "Food Safety & Hygiene",
                          formValue1: profileProvider
                              .profileDetailsTemp2?.foodSafetyAndHygieneCU,
                          formValue2: profileProvider
                              .profileDetailsTemp2?.foodSafetyAndHygieneCV,
                          groupValue: profileProvider
                              .profileDetailsTemp2?.foodSafetyAndHygiene,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Dates of Course (DD/MM/YYYY)',
                          hint2: 'Course Validity (DD/MM/YYYY)',
                          onChange: (v) =>
                              profileProvider.setFoodSafetyAndHygieneTemp2(v),
                          onFormChange1: (v) =>
                              profileProvider.setFoodSafetyAndHygieneCUTemp2(v),
                          onFormChange2: (v) =>
                              profileProvider.setFoodSafetyAndHygieneCVTemp2(v),
                        ),
                        const SizedBox(height: 16.0),
                        // Texts.largeBold("SECTION 4 - VERIFICATION",
                        //     color: Colors.red),
                        // const SizedBox(height: 16.0),
                        // RadioWidget6(
                        //   formValue1:
                        //       profileProvider.profileDetailsTemp2?.completedBy,
                        //   formValue2:
                        //       profileProvider.profileDetailsTemp2?.position,
                        //   formValue3:
                        //       profileProvider.profileDetailsTemp2?.submitDate,
                        //   onFormChange1: (val) {
                        //     profileProvider.setCompletedByTemp2(val);
                        //   },
                        //   onFormChange2: (val) {
                        //     profileProvider.setPositionTemp2(val);
                        //   },
                        //   onFormChange3: (val) {
                        //     profileProvider.setSubmitDateTemp2(val);
                        //   },
                        // ),
                        // const SizedBox(height: 16.0),
                        ElevatedButton(
                            onPressed: () => profileProvider
                                .updateProfileDetailsTemp2(widget.profile.id)
                                .whenComplete(() => Navigator.pop(context)),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fixedSize: Size(size.width, 60),
                                backgroundColor: AppColors.primaryDarkColor,
                                textStyle: GoogleFonts.lato(fontSize: 20)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.edit_25, color: AppColors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                customText(
                                  text: "Update Details",
                                  id: 1,
                                  color: AppColors.white,
                                ),
                              ],
                            )),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
