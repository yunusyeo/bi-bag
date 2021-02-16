class AddAdvertisementRequestModel {
  int unitPeace;
  int unitAmount;
  String untilDate;
  String flightCode;
  String flightCodeId;
  String ownerId;

  AddAdvertisementRequestModel(
      {this.unitPeace,
      this.unitAmount,
      this.untilDate,
      this.flightCode,
      this.flightCodeId,
      this.ownerId});

  AddAdvertisementRequestModel.fromJson(Map<String, dynamic> json) {
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
