class MyAdvertisementListResponseModel {
  String version;
  String errorMessage;
  String correletionId;
  List<MyResult> result;
  int statusCode;

  MyAdvertisementListResponseModel(
      {this.version,
      this.errorMessage,
      this.correletionId,
      this.result,
      this.statusCode});

  MyAdvertisementListResponseModel.fromJson(Map<String, dynamic> json) {
    version = json['Version'];
    errorMessage = json['ErrorMessage'];
    correletionId = json['CorreletionId'];
    if (json['Result'] != null) {
      result = new List<MyResult>();
      json['Result'].forEach((v) {
        result.add(new MyResult.fromJson(v));
      });
    }
    statusCode = json['StatusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Version'] = this.version;
    data['ErrorMessage'] = this.errorMessage;
    data['CorreletionId'] = this.correletionId;
    if (this.result != null) {
      data['Result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['StatusCode'] = this.statusCode;
    return data;
  }
}

class MyResult {
  int unitPeace;
  int unitAmount;
  String untilDate;
  String flightCode;
  String flightCodeId;
  String ownerId;

  MyResult(
      {this.unitPeace,
      this.unitAmount,
      this.untilDate,
      this.flightCode,
      this.flightCodeId,
      this.ownerId});

  MyResult.fromJson(Map<String, dynamic> json) {
    unitPeace = json['unitPeace'];
    unitAmount = json['unitAmount'];
    untilDate = json['untilDate'];
    flightCode = json['flightCode'];
    flightCodeId = json['flightCodeId'];
    ownerId = json['ownerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitPeace'] = this.unitPeace;
    data['unitAmount'] = this.unitAmount;
    data['untilDate'] = this.untilDate;
    data['flightCode'] = this.flightCode;
    data['flightCodeId'] = this.flightCodeId;
    data['ownerId'] = this.ownerId;
    return data;
  }
}
