class FetchFlights {
  String version;
  String errorMessage;
  String correletionId;
  Result result;
  int statusCode;

  FetchFlights(
      {this.version,
      this.errorMessage,
      this.correletionId,
      this.result,
      this.statusCode});

  FetchFlights.fromJson(Map<String, dynamic> json) {
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
  String createdAt;
  String createdBy;
  String updatedAt;
  Null updatedBy;
  bool deleted;
  String flightDate;
  String flightStatus;
  String airline;
  String flightCode;
  String departureAirport;
  String departureIata;
  String departureDateHour;
  String arrivalAirport;
  String arrivalIata;

  Result(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.deleted,
      this.flightDate,
      this.flightStatus,
      this.airline,
      this.flightCode,
      this.departureAirport,
      this.departureIata,
      this.departureDateHour,
      this.arrivalAirport,
      this.arrivalIata});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    deleted = json['deleted'];
    flightDate = json['flightDate'];
    flightStatus = json['flightStatus'];
    airline = json['airline'];
    flightCode = json['flightCode'];
    departureAirport = json['departureAirport'];
    departureIata = json['departureIata'];
    departureDateHour = json['departureDateHour'];
    arrivalAirport = json['arrivalAirport'];
    arrivalIata = json['arrivalIata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['deleted'] = this.deleted;
    data['flightDate'] = this.flightDate;
    data['flightStatus'] = this.flightStatus;
    data['airline'] = this.airline;
    data['flightCode'] = this.flightCode;
    data['departureAirport'] = this.departureAirport;
    data['departureIata'] = this.departureIata;
    data['departureDateHour'] = this.departureDateHour;
    data['arrivalAirport'] = this.arrivalAirport;
    data['arrivalIata'] = this.arrivalIata;
    return data;
  }
}
