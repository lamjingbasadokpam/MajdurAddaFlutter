class PigeonUserDetails {
  PigeonUserDetails({
    required this.userInfo,
    required this.providerData,
  });

  PigeonUserInfo userInfo;
  List<Map<Object?, Object?>?> providerData;

  // You can add a factory constructor to create instances from JSON or Map
  factory PigeonUserDetails.fromMap(Map<String, dynamic> map) {
    return PigeonUserDetails(
      userInfo: PigeonUserInfo.fromMap(map['userInfo']),
      providerData: List<Map<Object?, Object?>?>.from(map['providerData']),
    );
  }
}

class PigeonUserInfo {
  PigeonUserInfo({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    required this.isAnonymous,
    required this.isEmailVerified,
    this.providerId,
    this.tenantId,
    this.refreshToken,
    this.creationTimestamp,
    this.lastSignInTimestamp,
  });

  String uid;
  String? email;
  String? displayName;
  String? photoUrl;
  String? phoneNumber;
  bool isAnonymous;
  bool isEmailVerified;
  String? providerId;
  String? tenantId;
  String? refreshToken;
  int? creationTimestamp;
  int? lastSignInTimestamp;

  // A factory constructor to parse the data into PigeonUserInfo
  factory PigeonUserInfo.fromMap(Map<String, dynamic> map) {
    return PigeonUserInfo(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      phoneNumber: map['phoneNumber'],
      isAnonymous: map['isAnonymous'],
      isEmailVerified: map['isEmailVerified'],
      providerId: map['providerId'],
      tenantId: map['tenantId'],
      refreshToken: map['refreshToken'],
      creationTimestamp: map['creationTimestamp'],
      lastSignInTimestamp: map['lastSignInTimestamp'],
    );
  }
}
