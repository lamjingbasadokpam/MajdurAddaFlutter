// To parse this JSON data, do
//
//     final majdurDetails = majdurDetailsFromJson(jsonString);

import 'dart:convert';

List<MajdurDetails> majdurDetailsFromJson(String str) {
    final jsonData = json.decode(str);
    return List<MajdurDetails>.from(jsonData.map((x) => MajdurDetails.fromJson(x)));
}

String majdurDetailsToJson(List<MajdurDetails> data) {
    final dyn =  List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class MajdurDetails {
    String id;
    String firstName;
    String? middleName;
    String lastName;
    Address address;
    String mobileNo;
    String majdurType;
    bool availability;
    String workTiming;
    String majdurStatus;
    String workStatus;
    String language;
    String creationDate;

    MajdurDetails({
        required this.id,
        required this.firstName,
        this.middleName,
        required this.lastName,
        required this.address,
        required this.mobileNo,
        required this.majdurType,
        required this.availability,
        required this.workTiming,
        required this.majdurStatus,
        required this.workStatus,
        required this.language,
        required this.creationDate,
    });

    factory MajdurDetails.fromJson(Map<String, dynamic> json) =>  MajdurDetails(
        id: json["id"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        address: Address.fromJson(json["address"]),
        mobileNo: json["mobileNo"],
        majdurType: json["majdurType"],
        availability: json["availability"],
        workTiming: json["workTiming"],
        majdurStatus: json["majdurStatus"],
        workStatus: json["workStatus"],
        language: json["language"],
        creationDate: json["creationDate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "address": address.toJson(),
        "mobileNo": mobileNo,
        "majdurType": majdurType,
        "availability": availability,
        "workTiming": workTiming,
        "majdurStatus": majdurStatus,
        "workStatus": workStatus,
        "language": language,
        "creationDate": creationDate,
    };
}

class Address {
    String city;
    String state;

    Address({
        required this.city,
        required this.state,
    });

    factory Address.fromJson(Map<String, dynamic> json) =>  Address(
        city: json["city"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
    };
}


