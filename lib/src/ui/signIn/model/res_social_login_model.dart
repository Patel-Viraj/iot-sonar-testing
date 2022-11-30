import '../../../base/utils/constants/api_params.dart';
import '../../../base/utils/enum_utils.dart';

class SocialModel {
  String? accessToken;
  String? appleUserToken;
  String? id;
  String? fullName;
  String? profilePicture;
  String? email;
  socialLogin? platform;
  String? firstName;
  String? lastName;
  int? status;
  String? error;
  String? idToken;

  SocialModel(
      {this.accessToken,
      this.id,
      this.fullName,
      this.profilePicture,
      this.email,
      this.platform,
      this.firstName,
      this.lastName,
      this.appleUserToken,
      this.error,
      this.idToken,
      this.status});

  SocialModel.fromMap(Map<String, dynamic> json) {
    accessToken = json[ApiParams.paramAccessToken];
    id = json[ApiParams.paramId];
    fullName = json[ApiParams.paramFullName];
    profilePicture = json[ApiParams.paramProfilePicture];
    platform = json[ApiParams.paramplatform];
    firstName = json[ApiParams.paramFirstName];
    lastName = json[ApiParams.paramLastName];
    email = json[ApiParams.paramEmail];
    appleUserToken = json[ApiParams.paramAppleUserToken];
    idToken = json[ApiParams.paramGoogleIdToken];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[ApiParams.paramAccessToken] = accessToken;
    data[ApiParams.paramId] = id;
    data[ApiParams.paramFullName] = fullName;
    data[ApiParams.paramProfilePicture] = profilePicture;
    data[ApiParams.paramplatform] = platform;
    data[ApiParams.paramFirstName] = firstName;
    data[ApiParams.paramLastName] = lastName;
    data[ApiParams.paramEmail] = email;
    data[ApiParams.paramAppleUserToken] = appleUserToken;
    data[ApiParams.paramGoogleIdToken] = idToken;
    return data;
  }
}
