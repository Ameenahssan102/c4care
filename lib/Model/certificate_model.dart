class CertificateRes {
  String certificateImagePublicId;
  String certificateImageUrl;

  CertificateRes({
    required this.certificateImagePublicId,
    required this.certificateImageUrl,
  });

  factory CertificateRes.fromJson(Map<String, dynamic> json) => CertificateRes(
        certificateImagePublicId: json["certificateImagePublicId"],
        certificateImageUrl: json["certificateImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "certificateImagePublicId": certificateImagePublicId,
        "certificateImageUrl": certificateImageUrl,
      };
}
