class LoginResponseModel {
  String version;
  String errorMessage;
  String correletionId;
  Result result;
  int statusCode;

  LoginResponseModel(
      {this.version,
      this.errorMessage,
      this.correletionId,
      this.result,
      this.statusCode});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    version = json['Version'];
    errorMessage = json['ErrorMessage'];
    correletionId = json['CorreletionId'];
    result =
        json['Result'] != null ? new Result.fromJson(json['Result']) : null;
    statusCode = json['StatusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Version'] = this.version;
    data['ErrorMessage'] = this.errorMessage;
    data['CorreletionId'] = this.correletionId;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    data['StatusCode'] = this.statusCode;
    return data;
  }
}

class Result {
  String id;
  String firstName;
  String lastName;
  String username;
  String token;
  String phone;

  Result(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.token,
      this.phone});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    token = json['token'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['token'] = this.token;
    data['phone'] = this.phone;
    return data;
  }
}
