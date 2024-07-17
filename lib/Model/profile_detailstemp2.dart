class ProfileDetailsTemp2 {
  String? imageUrl;
  String? certificateImageUrl;
  String? certificateImagePublicId;
  String? idVerified;
  String? documentType;
  String? workInUkVerifiedDocument;
  String? workInUkVerified;
  String? individualRightExpiry;
  String? individualRight;
  String? criminalityCheckType;
  String? disclosureCertificateNo;
  String? disclosureIssueDate;
  String? levelOfCheck;
  String? nmcRegistration;
  String? nmcPin;
  String? nmcRenewalDate;

  String? healthSafety;
  String? healthSafetyCU;
  String? healthSafetyCV;

  String? movingHandlingPeople;
  String? movingHandlingPeopleCU;
  String? movingHandlingPeopleCV;

  String? fireSafetyAtWork;
  String? fireSafetyAtWorkCU;
  String? fireSafetyAtWorkCV;

  String? safeguardingAdults;
  String? safeguardingAdultsCU;
  String? safeguardingAdultsCV;

  String? infectionPreventionAndControl;
  String? infectionPreventionAndControlCU;
  String? infectionPreventionAndControlCV;

  String? foodSafetyAndHygiene;
  String? foodSafetyAndHygieneCU;
  String? foodSafetyAndHygieneCV;

  String? completedBy;
  String? position;
  String? submitDate;

  ProfileDetailsTemp2({
    required this.imageUrl,
    required this.certificateImageUrl,
    required this.certificateImagePublicId,
    required this.idVerified,
    required this.documentType,
    required this.workInUkVerifiedDocument,
    required this.workInUkVerified,
    required this.individualRightExpiry,
    required this.individualRight,
    required this.criminalityCheckType,
    required this.levelOfCheck,
    required this.disclosureCertificateNo,
    required this.disclosureIssueDate,
    required this.nmcRegistration,
    required this.nmcPin,
    required this.nmcRenewalDate,
    required this.healthSafety,
    required this.healthSafetyCU,
    required this.healthSafetyCV,
    required this.movingHandlingPeople,
    required this.movingHandlingPeopleCU,
    required this.movingHandlingPeopleCV,
    required this.fireSafetyAtWork,
    required this.fireSafetyAtWorkCU,
    required this.fireSafetyAtWorkCV,
    required this.safeguardingAdults,
    required this.safeguardingAdultsCU,
    required this.safeguardingAdultsCV,
    required this.infectionPreventionAndControl,
    required this.infectionPreventionAndControlCU,
    required this.infectionPreventionAndControlCV,
    required this.foodSafetyAndHygiene,
    required this.foodSafetyAndHygieneCU,
    required this.foodSafetyAndHygieneCV,
    required this.completedBy,
    required this.position,
    required this.submitDate,
  });

  factory ProfileDetailsTemp2.fromJson(Map<String, dynamic> json) => ProfileDetailsTemp2(
        imageUrl: json["imageUrl"],
        certificateImageUrl: json["certificateImageUrl"],
        certificateImagePublicId: json["certificateImagePublicId"],
        idVerified: json["idVerified"],
        documentType: json["documentType"],
        workInUkVerifiedDocument: json["workInUkVerifiedDocument"],
        workInUkVerified: json["workInUkVerified"],
        individualRightExpiry: json["individualRightExpiry"],
        individualRight: json["individualRight"],
        criminalityCheckType: json["criminalityCheckType"],
        levelOfCheck: json["levelOfCheck"],
        completedBy: json["completedBy"],
        position: json["position"],
        submitDate: json["submitDate"],
        disclosureCertificateNo: json["disclosureCertificateNo"],
        disclosureIssueDate: json["disclosureIssueDate"],
        nmcRegistration: json["nmcRegistration"],
        nmcPin: json["nmcPin"],
        nmcRenewalDate: json["nmcRenewalDate"],
        healthSafety: json["healthSafety"],
        healthSafetyCU: json["healthSafetyCU"],
        healthSafetyCV: json["healthSafetyCV"],
        movingHandlingPeople: json["movingHandlingPeople"],
        movingHandlingPeopleCU: json["movingHandlingPeopleCU"],
        movingHandlingPeopleCV: json["movingHandlingPeopleCV"],
        fireSafetyAtWork: json["fireSafetyAtWork"],
        fireSafetyAtWorkCU: json["fireSafetyAtWorkCU"],
        fireSafetyAtWorkCV: json["fireSafetyAtWorkCV"],
        safeguardingAdults: json["safeguardingAdults"],
        safeguardingAdultsCU: json["safeguardingAdultsCU"],
        safeguardingAdultsCV: json["safeguardingAdultsCV"],
        infectionPreventionAndControl: json["infectionPreventionAndControl"],
        infectionPreventionAndControlCU: json["infectionPreventionAndControlCU"],
        infectionPreventionAndControlCV: json["infectionPreventionAndControlCV"],
        foodSafetyAndHygiene: json["foodSafetyAndHygiene"],
        foodSafetyAndHygieneCU: json["foodSafetyAndHygieneCU"],
        foodSafetyAndHygieneCV: json["foodSafetyAndHygieneCV"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "idVerified": idVerified,
        "documentType": documentType,
        "workInUkVerifiedDocument": workInUkVerifiedDocument,
        "workInUkVerified": workInUkVerified,
        "individualRightExpiry": individualRightExpiry,
        "individualRight": individualRight,
        "criminalityCheckType": criminalityCheckType,
        "levelOfCheck": levelOfCheck,
        "completedBy": completedBy,
        "position": position,
        "submitDate": submitDate,
        "disclosureCertificateNo": disclosureCertificateNo,
        "disclosureIssueDate": disclosureIssueDate,
        "nmcRegistration": nmcRegistration,
        "nmcPin": nmcPin,
        "nmcRenewalDate": nmcRenewalDate,
        "healthSafety": healthSafety,
        "healthSafetyCU": healthSafetyCU,
        "healthSafetyCV": healthSafetyCV,
        "movingHandlingPeople": movingHandlingPeople,
        "movingHandlingPeopleCU": movingHandlingPeopleCU,
        "movingHandlingPeopleCV": movingHandlingPeopleCV,
        "fireSafetyAtWork": fireSafetyAtWork,
        "fireSafetyAtWorkCU": fireSafetyAtWorkCU,
        "fireSafetyAtWorkCV": fireSafetyAtWorkCV,
        "safeguardingAdults": safeguardingAdults,
        "safeguardingAdultsCU": safeguardingAdultsCU,
        "safeguardingAdultsCV": safeguardingAdultsCV,
        "infectionPreventionAndControl": infectionPreventionAndControl,
        "infectionPreventionAndControlCU": infectionPreventionAndControlCU,
        "infectionPreventionAndControlCV": infectionPreventionAndControlCV,
        "foodSafetyAndHygiene": foodSafetyAndHygiene,
        "foodSafetyAndHygieneCU": foodSafetyAndHygieneCU,
        "foodSafetyAndHygieneCV": foodSafetyAndHygieneCV,
        "certificateImageUrl": certificateImageUrl,
        "certificateImagePublicId": certificateImagePublicId,
      };
}
