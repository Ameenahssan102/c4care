// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously


import 'package:C4CARE/Dio/api_response.dart';
import 'package:C4CARE/Dio/dio_client.dart';
import 'package:C4CARE/Model/certificate_model.dart';
import 'package:C4CARE/Model/common_res_model.dart';
import 'package:C4CARE/Model/profile_details.temp1.dart';
import 'package:C4CARE/Model/profile_detailstemp2.dart';
import 'package:C4CARE/Model/profilemodel.dart';
import 'package:C4CARE/Navigation/nav.dart';
import 'package:C4CARE/Values/dialogs.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  final Repo repo;
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  final NavigationService ns;
  ProfileProvider({
    required this.dioClient,
    required this.repo,
    required this.sharedPreferences,
    required this.ns,
  });
  ProfileModel? profileModel;
  ProfileDetailsTemp1? profileDetails;
  ProfileDetailsTemp2? profileDetailsTemp2;
  Uint8List? selectedImage;
  Uint8List? imageCertificateUpload;
  Future<void> getProData() async {
    ApiResponse res = await repo.getData(StringConst.getProfile);
    if (res.response != null && res.response!.statusCode == 200) {
      profileModel = ProfileModel.fromJson(res.response!.data);
      notifyListeners();
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> getProfileDetails(ProfileModel user) async {
    selectedImage = null;
    if (kDebugMode) {
      print(user.id);
    }
    ApiResponse res = await repo
        .getData(StringConst.getProfileDetails, data: {'employeeId': user.id});
    if (res.response != null && res.response!.statusCode == 200) {
      if (user.role?.template?.name == "template_1") {
        profileDetails = ProfileDetailsTemp1.fromJson(res.response!.data);
      } else if (user.role?.template?.name == "template_2") {
        profileDetailsTemp2 = ProfileDetailsTemp2.fromJson(res.response!.data);
      }
      notifyListeners();
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> updateProfileDetails(employeeId) async {
    var data = {
      'employeeId': employeeId,
      'profileDetails': profileDetails?.toJson()
    };
    ApiResponse res =
        await repo.postData(StringConst.updateProfileDetails, data: data);
    if (res.response != null && res.response!.statusCode == 200) {
      CommonRes commonRes = CommonRes.fromJson(res.response!.data);
      Alerts.showSuccess(commonRes.message);
      // Navigator.pop(ns.getContext());
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> updateProfileDetailsTemp2(employeeId) async {
    var data = {
      'employeeId': employeeId,
      'profileDetails': profileDetailsTemp2?.toJson()
    };
    ApiResponse res =
        await repo.postData(StringConst.updateProfileDetails, data: data);
    if (res.response != null && res.response!.statusCode == 200) {
      CommonRes commonRes = CommonRes.fromJson(res.response!.data);
      Alerts.showSuccess(commonRes.message);
      // Navigator.pop(ns.getContext());
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> updateDocumentImage(ProfileModel user) async {
    Dialogs.showLoading();
    var imageBytes = MultipartFile.fromBytes(imageCertificateUpload!);
    var data = {'employeeId': user.id, 'image': imageBytes};
    var formData = FormData.fromMap(data);
    ApiResponse res =
        await repo.postData(StringConst.updateDocumentImage, data: formData);
    Navigator.pop(ns.getContext());
    if (res.response != null && res.response!.statusCode == 200) {
      CertificateRes certificateRes =
          CertificateRes.fromJson(res.response!.data);
      profileDetailsTemp2?.certificateImagePublicId =
          certificateRes.certificateImagePublicId;
      profileDetailsTemp2?.certificateImageUrl =
          certificateRes.certificateImageUrl;
      updateProfileDetailsTemp2(user.id);
    } else {
      Navigator.pop(ns.getContext());
      Alerts.showError(res.error);
    }
  }

  Future<void> updateProfileImage(String employeeId, Uint8List bytes) async {
    var imageBytes = MultipartFile.fromBytes(bytes);
    if (kDebugMode) {
      print(imageBytes);
    }
    var data = {'employeeId': employeeId, 'image': imageBytes};
    var formData = FormData.fromMap(data);
    ApiResponse res =
        await repo.postData(StringConst.updateProfileImage, data: formData);
    if (res.response != null && res.response!.statusCode == 200) {
      CommonRes commonRes = CommonRes.fromJson(res.response!.data);
      Alerts.showSuccess(commonRes.message);
    } else {
      Alerts.showError(res.error);
    }
  }

  void setVat(val) {
    profileDetails?.vat = val;
    notifyListeners();
  }

  setIdVerified(val) {
    profileDetails?.idVerified = val;
    if (val == 'no') {
      profileDetails?.documentType = "";
    }
    notifyListeners();
  }

  setDocumentType(val) {
    profileDetails?.documentType = val;
  }

  setWorkInUkVerified(val) {
    profileDetails?.workInUkVerified = val;
    if (val == 'no') {
      profileDetails?.workInUkVerifiedDocument = "";
    }
    notifyListeners();
  }

  setWorkInUkVerifiedDocument(val) {
    profileDetails?.workInUkVerifiedDocument = val;
  }

  setIndividualRight(val) {
    profileDetails?.individualRight = val;
    if (val == 'no') {
      profileDetails?.individualRightExpiry = "";
    }
    notifyListeners();
  }

  setIndividualRightExpiry(val) {
    profileDetails?.individualRightExpiry = val;
  }

  setCriminalityCheckType(val) {
    profileDetails?.criminalityCheckType = val;
    notifyListeners();
  }

  setLevelOfCheck(val) {
    profileDetails?.levelOfCheck = val;
    notifyListeners();
  }

  setCheckedWorkForce(val) {
    profileDetails?.checkedWorkForce = val;
    notifyListeners();
  }

  ///
  setBarredList(val) {
    profileDetails?.barredList = val;
    if (val == 'no') {
      profileDetails?.barredListIssueDate = "";
      profileDetails?.barredListCertificateNo = "";
    }
    notifyListeners();
  }

  setBarredListIssueDate(val) {
    profileDetails?.barredListIssueDate = val;
  }

  setBarredListCertificateNo(val) {
    profileDetails?.barredListCertificateNo = val;
  }

  setOutcome(val) {
    profileDetails?.outcome = val;
    if (val == 'clear') {
      profileDetails?.riskAssessmentCompleted = 'no';
    }
    notifyListeners();
  }

  setRiskAssessmentCompleted(val) {
    profileDetails?.riskAssessmentCompleted = val;
    notifyListeners();
  }

  setProfessionalBodyRegistration(val) {
    profileDetails?.professionalBodyRegistration = val;
    if (val == 'no') {
      profileDetails?.professionalBodyRegistrationNo = "";
    }
    notifyListeners();
  }

  setProfessionalBodyRegistrationNo(val) {
    profileDetails?.professionalBodyRegistrationNo = val;
  }

  setProfessionalBodyRegistrationValid(val) {
    profileDetails?.professionalBodyRegistrationValid = val;
    if (val == 'no') {
      profileDetails?.professionalBodyRegistrationExpiryDate = "";
      profileDetails?.professionalBodyRegistrationVerifiedDate = "";
    }
    notifyListeners();
  }

  setProfessionalBodyRegistrationExpiryDate(val) {
    profileDetails?.professionalBodyRegistrationExpiryDate = val;
  }

  setProfessionalBodyRegistrationVerifiedDate(val) {
    profileDetails?.professionalBodyRegistrationVerifiedDate = val;
  }

  setFitnessToPracticeIssues(val) {
    profileDetails?.fitnessToPracticeIssues = val;
    notifyListeners();
  }

  setFullEmploymentHistoryProvided(val) {
    profileDetails?.fullEmploymentHistoryProvided = val;
    notifyListeners();
  }

  setExplanationForGaps(val) {
    profileDetails?.explanationForGaps = val;
    notifyListeners();
  }

  setSatisfactoryVerificationReasons(val) {
    profileDetails?.satisfactoryVerificationReasons = val;
    notifyListeners();
  }

  setReferencesReceived(val) {
    profileDetails?.referencesReceived = val;
    notifyListeners();
  }

  setAllRequiredPaperworkChecked(val) {
    profileDetails?.allRequiredPaperworkChecked = val;
    notifyListeners();
  }

  setFullUkDrivingLicence(val) {
    profileDetails?.fullUkDrivingLicence = val;
    notifyListeners();
  }

  ///
  setCoshh(val) {
    profileDetails?.coshh = val;
    if (val == 'no') {
      profileDetails?.coshhDate = "";
    }
    notifyListeners();
  }

  setCoshhDate(val) {
    profileDetails?.coshhDate = val;
  }

  ///

  setFireSafety(val) {
    profileDetails?.fireSafety = val;
    if (val == 'no') {
      profileDetails?.fireSafetyDate = "";
    }
    notifyListeners();
  }

  setFireSafetyDate(val) {
    profileDetails?.fireSafetyDate = val;
  }

  ///
  setGdpr(val) {
    profileDetails?.gdpr = val;
    if (val == 'no') {
      profileDetails?.gdprDate = "";
    }
    notifyListeners();
  }

  setGdprDate(val) {
    profileDetails?.gdprDate = val;
  }

  ///
  setHealthAndSafetyLaw(val) {
    profileDetails?.healthAndSafetyLaw = val;
    if (val == 'no') {
      profileDetails?.healthAndSafetyLawDate = "";
    }
    notifyListeners();
  }

  setHealthAndSafetyLawDate(val) {
    profileDetails?.healthAndSafetyLawDate = val;
  }

  ///
  setManualHandlingTheory(val) {
    profileDetails?.manualHandlingTheory = val;
    if (val == 'no') {
      profileDetails?.manualHandlingTheoryDate = "";
    }
    notifyListeners();
  }

  setManualHandlingTheoryDate(val) {
    profileDetails?.manualHandlingTheoryDate = val;
  }

  ///
  setMovingAndHandlingPeople(val) {
    profileDetails?.movingAndHandlingPeople = val;
    if (val == 'no') {
      profileDetails?.movingAndHandlingPeopleDate = "";
    }
    notifyListeners();
  }

  setMovingAndHandlingPeopleDate(val) {
    profileDetails?.movingAndHandlingPeopleDate = val;
  }

  ///
  setMentalCapacityAct(val) {
    profileDetails?.mentalCapacityAct = val;
    if (val == 'no') {
      profileDetails?.mentalCapacityActDate = "";
    }
    notifyListeners();
  }

  setMentalCapacityActDate(val) {
    profileDetails?.mentalCapacityActDate = val;
  }

  ///
  setBasicFoodHygiene(val) {
    profileDetails?.basicFoodHygiene = val;
    if (val == 'no') {
      profileDetails?.basicFoodHygieneDate = "";
    }
    notifyListeners();
  }

  setBasicFoodHygieneDate(val) {
    profileDetails?.basicFoodHygieneDate = val;
  }

  ///
  setBedRailSafety(val) {
    profileDetails?.bedRailSafety = val;
    if (val == 'no') {
      profileDetails?.bedRailSafetyDate = "";
    }
    notifyListeners();
  }

  setBedRailSafetyDate(val) {
    profileDetails?.bedRailSafetyDate = val;
  }

  ///
  setBasicLifeSupport(val) {
    profileDetails?.basicLifeSupport = val;
    if (val == 'no') {
      profileDetails?.basicLifeSupportDate = "";
    }
    notifyListeners();
  }

  setBasicLifeSupportDate(val) {
    profileDetails?.basicLifeSupportDate = val;
  }

  ///
  setDeprivationOfLiberty(val) {
    profileDetails?.deprivationOfLiberty = val;
    if (val == 'no') {
      profileDetails?.deprivationOfLibertyDate = "";
    }
    notifyListeners();
  }

  setDeprivationOfLibertyDate(val) {
    profileDetails?.deprivationOfLibertyDate = val;
  }

  ///
  setDutyOfCandor(val) {
    profileDetails?.dutyOfCandor = val;
    if (val == 'no') {
      profileDetails?.dutyOfCandorDate = "";
    }
    notifyListeners();
  }

  setDutyOfCandorDate(val) {
    profileDetails?.dutyOfCandorDate = val;
  }

  ///
  setEqualityAndDiversity(val) {
    profileDetails?.equalityAndDiversity = val;
    if (val == 'no') {
      profileDetails?.equalityAndDiversityDate = "";
    }
    notifyListeners();
  }

  setEqualityAndDiversityDate(val) {
    profileDetails?.equalityAndDiversityDate = val;
  }

  ///
  setIntermediateLifeSupport(val) {
    profileDetails?.intermediateLifeSupport = val;
    if (val == 'no') {
      profileDetails?.intermediateLifeSupportDate = "";
    }
    notifyListeners();
  }

  setIntermediateLifeSupportDate(val) {
    profileDetails?.intermediateLifeSupportDate = val;
  }

  ///
  setInfectionControl(val) {
    profileDetails?.infectionControl = val;
    if (val == 'no') {
      profileDetails?.infectionControlDate = "";
    }
    notifyListeners();
  }

  setInfectionControlDate(val) {
    profileDetails?.infectionControlDate = val;
  }

  ///
  setInformationGovernance(val) {
    profileDetails?.informationGovernance = val;
    if (val == 'no') {
      profileDetails?.informationGovernanceDate = "";
    }
    notifyListeners();
  }

  setInformationGovernanceDate(val) {
    profileDetails?.informationGovernanceDate = val;
  }

  ///
  setSafeguardingOfVulnerableAdults(val) {
    profileDetails?.safeguardingOfVulnerableAdults = val;
    if (val == 'no') {
      profileDetails?.safeguardingOfVulnerableAdultsDate = "";
    }
    notifyListeners();
  }

  setSafeguardingOfVulnerableAdultsDate(val) {
    profileDetails?.safeguardingOfVulnerableAdultsDate = val;
  }

  ///
  setRiddor(val) {
    profileDetails?.riddor = val;
    if (val == 'no') {
      profileDetails?.riddorDate = "";
    }
    notifyListeners();
  }

  setRiddorDate(val) {
    profileDetails?.riddorDate = val;
  }

  ///
  setDementiaAwareness(val) {
    profileDetails?.dementiaAwareness = val;
    if (val == 'no') {
      profileDetails?.dementiaAwarenessDate = "";
    }
    notifyListeners();
  }

  setDementiaAwarenessDate(val) {
    profileDetails?.dementiaAwarenessDate = val;
  }

  ///
  setManagingMedications(val) {
    profileDetails?.managingMedications = val;
    if (val == 'no') {
      profileDetails?.managingMedicationsDate = "";
    }
    notifyListeners();
  }

  setManagingMedicationsDate(val) {
    profileDetails?.managingMedicationsDate = val;
  }

  setCompletedBy(val) {
    profileDetails?.completedBy = val;
  }

  setPosition(val) {
    profileDetails?.position = val;
  }

  setSubmitDate(val) {
    profileDetails?.submitDate = val;
  }

  void setImage(Uint8List bytes) {
    selectedImage = bytes;
    notifyListeners();
  }

  void setImageCertificateUpload(Uint8List bytes) {
    imageCertificateUpload = bytes;
    notifyListeners();
  }

  ///

  setIdVerifiedTemp2(val) {
    profileDetailsTemp2?.idVerified = val;
    if (val == 'no') {
      profileDetailsTemp2?.documentType = "";
    }
    notifyListeners();
  }

  setDocumentTypeTemp2(val) {
    profileDetailsTemp2?.documentType = val;
  }

  //

  setWorkInUkVerifiedTemp2(val) {
    profileDetailsTemp2?.workInUkVerified = val;
    if (val == 'no') {
      profileDetailsTemp2?.workInUkVerifiedDocument = "";
    }
    notifyListeners();
  }

  setWorkInUkVerifiedDocumentTemp2(val) {
    profileDetailsTemp2?.workInUkVerifiedDocument = val;
  } //

  setIndividualRightTemp2(val) {
    profileDetailsTemp2?.individualRight = val;
    if (val == 'no') {
      profileDetailsTemp2?.individualRightExpiry = "";
    }
    notifyListeners();
  }

  setIndividualRightExpiryTemp2(val) {
    profileDetailsTemp2?.individualRightExpiry = val;
  }

  //

  setCriminalityCheckTypeTemp2(val) {
    profileDetailsTemp2?.criminalityCheckType = val;
    if (val == 'no') {
      profileDetailsTemp2?.disclosureCertificateNo = "";
      profileDetailsTemp2?.disclosureIssueDate = "";
    }
    notifyListeners();
  }

  void setDisclosureCertificateNoTemp2(val) {
    profileDetailsTemp2?.disclosureCertificateNo = val;
  }

  void setDisclosureIssueDateTemp2(val) {
    profileDetailsTemp2?.disclosureIssueDate = val;
  }

  setLevelOfCheckTemp2(val) {
    profileDetailsTemp2?.levelOfCheck = val;
    notifyListeners();
  }

//
  setNmcRegistrationTemp2(val) {
    profileDetailsTemp2?.nmcRegistration = val;
    if (val == 'no') {
      profileDetailsTemp2?.nmcRenewalDate = "";
      profileDetailsTemp2?.nmcPin = "";
    }
    notifyListeners();
  }

  setNmcPinTemp2(val) {
    profileDetailsTemp2?.nmcPin = val;
  }

  setNmcRenewalDateTemp2(val) {
    profileDetailsTemp2?.nmcRenewalDate = val;
  }

  //
  setHealthSafetyTemp2(val) {
    profileDetailsTemp2?.healthSafety = val;
    if (val == 'no') {
      profileDetailsTemp2?.healthSafetyCU = "";
      profileDetailsTemp2?.healthSafetyCV = "";
    }
    notifyListeners();
  }

  setHealthSafetyCUTemp2(val) {
    profileDetailsTemp2?.healthSafetyCU = val;
  }

  setHealthSafetyCVTemp2(val) {
    profileDetailsTemp2?.healthSafetyCV = val;
  }

  //
  setMovingHandlingPeopleTemp2(val) {
    profileDetailsTemp2?.movingHandlingPeople = val;
    if (val == 'no') {
      profileDetailsTemp2?.movingHandlingPeopleCU = "";
      profileDetailsTemp2?.movingHandlingPeopleCV = "";
    }
    notifyListeners();
  }

  setMovingHandlingPeopleCUTemp2(val) {
    profileDetailsTemp2?.movingHandlingPeopleCU = val;
  }

  setMovingHandlingPeopleCVTemp2(val) {
    profileDetailsTemp2?.movingHandlingPeopleCV = val;
  }

  //
  setFireSafetyAtWorkTemp2(val) {
    profileDetailsTemp2?.fireSafetyAtWork = val;
    if (val == 'no') {
      profileDetailsTemp2?.fireSafetyAtWorkCU = "";
      profileDetailsTemp2?.movingHandlingPeopleCV = "";
    }
    notifyListeners();
  }

  setFireSafetyAtWorkCUTemp2(val) {
    profileDetailsTemp2?.fireSafetyAtWorkCU = val;
  }

  setFireSafetyAtWorkCVTemp2(val) {
    profileDetailsTemp2?.fireSafetyAtWorkCV = val;
  }

  //
  setSafeguardingAdultsTemp2(val) {
    profileDetailsTemp2?.safeguardingAdults = val;
    if (val == 'no') {
      profileDetailsTemp2?.safeguardingAdultsCU = "";
      profileDetailsTemp2?.safeguardingAdultsCV = "";
    }
    notifyListeners();
  }

  setSafeguardingAdultsCUTemp2(val) {
    profileDetailsTemp2?.safeguardingAdultsCU = val;
  }

  setSafeguardingAdultsCVTemp2(val) {
    profileDetailsTemp2?.safeguardingAdultsCV = val;
  }

  //
  setInfectionPreventionAndControlTemp2(val) {
    profileDetailsTemp2?.infectionPreventionAndControl = val;
    if (val == 'no') {
      profileDetailsTemp2?.safeguardingAdultsCU = "";
      profileDetailsTemp2?.safeguardingAdultsCV = "";
    }
    notifyListeners();
  }

  setInfectionPreventionAndControlCUTemp2(val) {
    profileDetailsTemp2?.infectionPreventionAndControlCU = val;
  }

  setInfectionPreventionAndControlCVTemp2(val) {
    profileDetailsTemp2?.infectionPreventionAndControlCV = val;
  }

  //
  setFoodSafetyAndHygieneTemp2(val) {
    profileDetailsTemp2?.foodSafetyAndHygiene = val;
    if (val == 'no') {
      profileDetailsTemp2?.foodSafetyAndHygieneCU = "";
      profileDetailsTemp2?.foodSafetyAndHygieneCV = "";
    }
    notifyListeners();
  }

  setFoodSafetyAndHygieneCUTemp2(val) {
    profileDetailsTemp2?.foodSafetyAndHygieneCU = val;
  }

  setFoodSafetyAndHygieneCVTemp2(val) {
    profileDetailsTemp2?.foodSafetyAndHygieneCV = val;
  }

  setCompletedByTemp2(val) {
    profileDetailsTemp2?.completedBy = val;
  }

  setPositionTemp2(val) {
    profileDetailsTemp2?.position = val;
  }

  setSubmitDateTemp2(val) {
    profileDetailsTemp2?.submitDate = val;
  }
}
