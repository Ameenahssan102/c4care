// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';

import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Custom/texts.dart';
import 'package:C4CARE/Model/profilemodel.dart';
import 'package:C4CARE/Provider/profile.provider.dart';
import 'package:C4CARE/Values/dialogs.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/template_widgets/radio_widget.dart';
import 'package:C4CARE/template_widgets/radio_widget2.dart';
import 'package:C4CARE/template_widgets/radio_widget3.dart';
import 'package:C4CARE/template_widgets/radio_widget4.dart';
import 'package:C4CARE/template_widgets/radio_widget5.dart';
import 'package:C4CARE/template_widgets/radio_widget6.dart';
import 'package:C4CARE/Custom/widgets/cached_image.dart';
import 'package:C4CARE/Custom/widgets/square_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileTemplate1 extends StatefulWidget {
  final ProfileModel profile;
  const ProfileTemplate1({super.key, required this.profile});

  @override
  State<ProfileTemplate1> createState() => _ProfileTemplate1State();
}

class _ProfileTemplate1State extends State<ProfileTemplate1> {
  @override
  void initState() {
    super.initState();
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
                                          widget.profile.imageUrl ?? '',
                                          context,
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
                        RadioWidget(
                          title: "VAT Status",
                          groupValue: profileProvider.profileDetails?.vat,
                          firstOption: 'applicable',
                          secondOption: 'exempt',
                          firstOptionText: 'Applicable',
                          secondOptionText: 'Exempt',
                          onChange: (val) => profileProvider.setVat(val),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1:
                              profileProvider.profileDetails?.documentType,
                          title: "ID and Proof of Address verified",
                          groupValue:
                              profileProvider.profileDetails?.idVerified,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint:
                              'Type of document(s) seen and verified(ie; Passport, Birth Certificate)',
                          onChange: (val) => profileProvider.setIdVerified(val),
                          onFormChange: (v) =>
                              profileProvider.setDocumentType(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.workInUkVerifiedDocument,
                          title: "Right to Work in UK verified",
                          groupValue:
                              profileProvider.profileDetails?.workInUkVerified,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint:
                              'Type of document(s) seen and verified (ie; Visa, Share Code)',
                          onChange: (val) =>
                              profileProvider.setWorkInUkVerified(val),
                          onFormChange: (v) =>
                              profileProvider.setWorkInUkVerifiedDocument(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.individualRightExpiry,
                          title:
                              "Is there a time limit on individual’s right to stay and work in UK?",
                          groupValue:
                              profileProvider.profileDetails?.individualRight,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint:
                              'If Yes, date permit is due to expire(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setIndividualRight(val),
                          onFormChange: (v) =>
                              profileProvider.setIndividualRightExpiry(v),
                        ),
                        const SizedBox(height: 16.0),
                        Texts.regularBold("CRIMINALITY CHECKS",
                            color: AppColors.primaryDarkColor),
                        const SizedBox(height: 16.0),
                        RadioWidget2(
                          title: "Type of criminality checks obtained ",
                          groupValue: profileProvider
                              .profileDetails?.criminalityCheckType,
                          firstOption: 'dbs',
                          secondOption: 'pvg',
                          thirdOption: 'none',
                          firstOptionText: 'DBS(England)',
                          secondOptionText: 'PVG(Scotland)',
                          thirdOptionText: 'None',
                          onChange: (v) =>
                              profileProvider.setCriminalityCheckType(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget(
                          title: "Level of Check",
                          groupValue:
                              profileProvider.profileDetails?.levelOfCheck,
                          firstOption: 'enhanced',
                          secondOption: 'standard',
                          firstOptionText: 'Enhanced',
                          secondOptionText: 'Standard',
                          onChange: (val) =>
                              profileProvider.setLevelOfCheck(val),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget2(
                          title: "Workforce Checked",
                          groupValue:
                              profileProvider.profileDetails?.checkedWorkForce,
                          firstOption: 'adult',
                          secondOption: 'child',
                          thirdOption: 'adult_child',
                          firstOptionText: 'Adult',
                          secondOptionText: 'Child',
                          thirdOptionText: 'Adult& Child',
                          onChange: (v) =>
                              profileProvider.setCheckedWorkForce(v),
                        ),
                        //completed
                        const SizedBox(height: 16.0),
                        RadioWidget4(
                          title: "Checked Against Barred List?",
                          formValue1: profileProvider
                              .profileDetails?.barredListIssueDate,
                          formValue2: profileProvider
                              .profileDetails?.barredListCertificateNo,
                          groupValue:
                              profileProvider.profileDetails?.barredList,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Issue Date(DD/MM/YYYY)',
                          hint2: 'Certificate No',
                          onChange: (v) => profileProvider.setBarredList(v),
                          onFormChange1: (v) =>
                              profileProvider.setBarredListIssueDate(v),
                          onFormChange2: (v) =>
                              profileProvider.setBarredListCertificateNo(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget(
                          title: "Outcome",
                          groupValue: profileProvider.profileDetails?.outcome,
                          firstOption: 'clear',
                          secondOption: 'anomalies',
                          firstOptionText: 'Clear',
                          secondOptionText: 'Anomalies',
                          onChange: (val) => profileProvider.setOutcome(val),
                        ),
                        if (profileProvider.profileDetails?.outcome ==
                            'anomalies')
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: RadioWidget(
                              title: "Risk Assessment Completed?",
                              groupValue: profileProvider
                                  .profileDetails?.riskAssessmentCompleted,
                              firstOption: 'yes',
                              secondOption: 'no',
                              firstOptionText: 'Yes',
                              secondOptionText: 'No',
                              onChange: (val) => profileProvider
                                  .setRiskAssessmentCompleted(val),
                            ),
                          ),
                        const SizedBox(height: 16.0),
                        Texts.regularBold(
                            "PROFESSIONAL BODY REGISTRATION FOR CANDIDATE",
                            color: AppColors.primaryDarkColor),
                        const SizedBox(height: 16.0),
                        RadioWidget5(
                          title: "Professional body registration obtained",
                          formValue1: profileProvider
                              .profileDetails?.professionalBodyRegistrationNo,
                          groupValue: profileProvider
                              .profileDetails?.professionalBodyRegistration,
                          firstOption: 'nmc',
                          secondOption: 'niscc',
                          thirdOption: 'other',
                          fourthOption: 'none',
                          firstOptionText: 'NMC',
                          secondOptionText: 'NISCC',
                          thirdOptionText: 'Other',
                          fourthOptionText: 'None',
                          onChange: (v) => profileProvider
                              .setProfessionalBodyRegistration(v),
                          onFormChange: (v) => profileProvider
                              .setProfessionalBodyRegistrationNo(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget4(
                          title: "Valid",
                          formValue1: profileProvider.profileDetails != null
                              ? profileProvider.profileDetails!
                                  .professionalBodyRegistrationExpiryDate
                              : "",
                          formValue2: profileProvider.profileDetails != null
                              ? profileProvider.profileDetails
                                  ?.professionalBodyRegistrationVerifiedDate
                              : "",
                          groupValue: profileProvider.profileDetails
                              ?.professionalBodyRegistrationValid,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Valid To Date(DD/MM/YYYY)',
                          hint2: 'Date Verified(DD/MM/YYYY)',
                          onChange: (v) => profileProvider
                              .setProfessionalBodyRegistrationValid(v),
                          onFormChange1: (v) => profileProvider
                              .setProfessionalBodyRegistrationExpiryDate(v),
                          onFormChange2: (v) => profileProvider
                              .setProfessionalBodyRegistrationVerifiedDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget(
                          title:
                              "Any Fitness to Practice Issues Noted: (if Yes, confirm risk assessment carried out and list any restrictions in place)",
                          groupValue: profileProvider
                              .profileDetails?.fitnessToPracticeIssues,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          onChange: (val) =>
                              profileProvider.setFitnessToPracticeIssues(val),
                        ),
                        const SizedBox(height: 16.0),
                        Texts.regularBold(
                            "EVIDENCE OF SUITABLE CONDUCT IN PREVIOUS EMPLOYMENT",
                            color: AppColors.primaryDarkColor),
                        const SizedBox(height: 16.0),
                        RadioWidget(
                          title: "Full employment history provided",
                          groupValue: profileProvider
                              .profileDetails?.fullEmploymentHistoryProvided,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          onChange: (val) => profileProvider
                              .setFullEmploymentHistoryProvided(val),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget(
                          title:
                              "Written explanation provided of any gaps in employment",
                          groupValue: profileProvider
                              .profileDetails?.explanationForGaps,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          onChange: (val) =>
                              profileProvider.setExplanationForGaps(val),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget(
                          title:
                              "Satisfactory verification of the reasons why candidates previous employment ended",
                          groupValue: profileProvider
                              .profileDetails?.satisfactoryVerificationReasons,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          onChange: (val) => profileProvider
                              .setSatisfactoryVerificationReasons(val),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget(
                          title: "References Received ",
                          groupValue: profileProvider
                              .profileDetails?.referencesReceived,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          onChange: (val) =>
                              profileProvider.setReferencesReceived(val),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget(
                          title: "All required paperwork checked ",
                          groupValue: profileProvider
                              .profileDetails?.allRequiredPaperworkChecked,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          onChange: (val) => profileProvider
                              .setAllRequiredPaperworkChecked(val),
                        ),
                        const SizedBox(height: 16.0),
                        Texts.largeBold("SECTION 3 - OTHER / CHECKS",
                            color: Colors.red),
                        const SizedBox(height: 16.0),
                        RadioWidget(
                          title: "Full UK Driving Licence ",
                          groupValue: profileProvider
                              .profileDetails?.fullUkDrivingLicence,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          onChange: (val) =>
                              profileProvider.setFullUkDrivingLicence(val),
                        ),
                        const SizedBox(height: 16.0),
                        Texts.largeBold(
                            "SECTION 4 - TRAINING AND QUALIFICATIONS",
                            color: Colors.red),
                        const SizedBox(height: 16.0),
                        Texts.regularBold(
                            "STATUTORY TRAINING COMPLETED (ALL ROLES)",
                            color: AppColors.primaryDarkColor),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider.profileDetails?.coshhDate,
                          title:
                              "Control of Substances Hazardous to Health (COSHH)",
                          groupValue: profileProvider.profileDetails?.coshh,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) => profileProvider.setCoshh(val),
                          onFormChange: (v) => profileProvider.setCoshhDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1:
                              profileProvider.profileDetails?.fireSafetyDate,
                          title: "Fire Safety",
                          groupValue:
                              profileProvider.profileDetails?.fireSafety,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) => profileProvider.setFireSafety(val),
                          onFormChange: (v) =>
                              profileProvider.setFireSafetyDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider.profileDetails?.gdprDate,
                          title: "General Data Protection Regulations (GDPR)",
                          groupValue: profileProvider.profileDetails?.gdpr,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) => profileProvider.setGdpr(val),
                          onFormChange: (v) => profileProvider.setGdprDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.healthAndSafetyLawDate,
                          title: "Health and Safety Law",
                          groupValue: profileProvider
                              .profileDetails?.healthAndSafetyLaw,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setHealthAndSafetyLaw(val),
                          onFormChange: (v) =>
                              profileProvider.setHealthAndSafetyLawDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.manualHandlingTheoryDate,
                          title: "Manual Handling Theory",
                          groupValue: profileProvider
                              .profileDetails?.manualHandlingTheory,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setManualHandlingTheory(val),
                          onFormChange: (v) =>
                              profileProvider.setManualHandlingTheoryDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.movingAndHandlingPeopleDate,
                          title: "Moving and Handling People",
                          groupValue: profileProvider
                              .profileDetails?.movingAndHandlingPeople,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setMovingAndHandlingPeople(val),
                          onFormChange: (v) =>
                              profileProvider.setMovingAndHandlingPeopleDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        Texts.regularBold(
                            "OTHER MANDATORY TRAINING COMPLETED (AS REQUIRED FOR SERVICE / ROLE)",
                            color: AppColors.primaryDarkColor),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.mentalCapacityActDate,
                          title: "Mental Capacity Act (England & Wales)",
                          groupValue:
                              profileProvider.profileDetails?.mentalCapacityAct,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setMentalCapacityAct(val),
                          onFormChange: (v) =>
                              profileProvider.setMentalCapacityActDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.basicFoodHygieneDate,
                          title: "Basic Food Hygiene",
                          groupValue:
                              profileProvider.profileDetails?.basicFoodHygiene,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setBasicFoodHygiene(val),
                          onFormChange: (v) =>
                              profileProvider.setBasicFoodHygieneDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1:
                              profileProvider.profileDetails?.bedRailSafetyDate,
                          title: "Bed Rail Safety",
                          groupValue:
                              profileProvider.profileDetails?.bedRailSafety,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setBedRailSafety(val),
                          onFormChange: (v) =>
                              profileProvider.setBedRailSafetyDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1:
                              profileProvider.profileDetails?.bedRailSafetyDate,
                          title: "Basic Life Support (BLS)",
                          groupValue:
                              profileProvider.profileDetails?.basicLifeSupport,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setBasicLifeSupport(val),
                          onFormChange: (v) =>
                              profileProvider.setBasicLifeSupportDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.deprivationOfLibertyDate,
                          title: "Deprivation of Liberty (DOLS)",
                          groupValue: profileProvider
                              .profileDetails?.deprivationOfLiberty,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setDeprivationOfLiberty(val),
                          onFormChange: (v) =>
                              profileProvider.setDeprivationOfLibertyDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1:
                              profileProvider.profileDetails?.dutyOfCandorDate,
                          title: "Duty of Candor",
                          groupValue:
                              profileProvider.profileDetails?.dutyOfCandor,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setDutyOfCandor(val),
                          onFormChange: (v) =>
                              profileProvider.setDutyOfCandorDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.equalityAndDiversityDate,
                          title: "Equality & Diversity",
                          groupValue: profileProvider
                              .profileDetails?.equalityAndDiversity,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setEqualityAndDiversity(val),
                          onFormChange: (v) =>
                              profileProvider.setEqualityAndDiversityDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.intermediateLifeSupportDate,
                          title: "Intermediate Life Support (ILS)",
                          groupValue: profileProvider
                              .profileDetails?.intermediateLifeSupport,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setIntermediateLifeSupport(val),
                          onFormChange: (v) =>
                              profileProvider.setIntermediateLifeSupportDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.infectionControlDate,
                          title: "Infection Control",
                          groupValue:
                              profileProvider.profileDetails?.infectionControl,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setInfectionControl(val),
                          onFormChange: (v) =>
                              profileProvider.setInfectionControlDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.informationGovernanceDate,
                          title: "Information Governance",
                          groupValue: profileProvider
                              .profileDetails?.informationGovernance,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setInformationGovernance(val),
                          onFormChange: (v) =>
                              profileProvider.setInformationGovernanceDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider.profileDetails
                              ?.safeguardingOfVulnerableAdultsDate,
                          title: "Safeguarding of Vulnerable Adults (SOVA)",
                          groupValue: profileProvider
                              .profileDetails?.safeguardingOfVulnerableAdults,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) => profileProvider
                              .setSafeguardingOfVulnerableAdults(val),
                          onFormChange: (v) => profileProvider
                              .setSafeguardingOfVulnerableAdultsDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1:
                              profileProvider.profileDetails?.riddorDate,
                          title:
                              "Reporting of Injuries, Diseases and Dangerous Occurrences Regulations (RIDDOR)",
                          groupValue: profileProvider.profileDetails?.riddor,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) => profileProvider.setRiddor(val),
                          onFormChange: (v) => profileProvider.setRiddorDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.dementiaAwarenessDate,
                          title: "Dementia Awareness",
                          groupValue:
                              profileProvider.profileDetails?.dementiaAwareness,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setDementiaAwareness(val),
                          onFormChange: (v) =>
                              profileProvider.setDementiaAwarenessDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        RadioWidget3(
                          formValue1: profileProvider
                              .profileDetails?.managingMedicationsDate,
                          title: "Managing Medications",
                          groupValue: profileProvider
                              .profileDetails?.managingMedications,
                          firstOption: 'yes',
                          secondOption: 'no',
                          firstOptionText: 'Yes',
                          secondOptionText: 'No',
                          hint: 'Date(DD/MM/YYYY)',
                          onChange: (val) =>
                              profileProvider.setManagingMedications(val),
                          onFormChange: (v) =>
                              profileProvider.setManagingMedicationsDate(v),
                        ),
                        const SizedBox(height: 16.0),
                        // Texts.largeBold("SECTION 5 - VERIFICATION",
                        //     color: Colors.red),
                        // const SizedBox(height: 16.0),
                        // RadioWidget6(
                        //   formValue1:
                        //       profileProvider.profileDetails?.completedBy,
                        //   formValue2: profileProvider.profileDetails?.position,
                        //   formValue3:
                        //       profileProvider.profileDetails?.submitDate,
                        //   onFormChange1: (val) {
                        //     profileProvider.setCompletedBy(val);
                        //   },
                        //   onFormChange2: (val) {
                        //     profileProvider.setPosition(val);
                        //   },
                        //   onFormChange3: (val) {
                        //     profileProvider.setSubmitDate(val);
                        //   },
                        // ),
                        // const SizedBox(height: 16.0),
                        ElevatedButton(
                            onPressed: () => profileProvider
                                .updateProfileDetails(widget.profile.id)
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
