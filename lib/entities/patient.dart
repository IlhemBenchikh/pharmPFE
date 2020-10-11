import 'package:flutter/cupertino.dart';

class Patient {
  int id, userid;
  String ordonnance, fullname, birthdate;
  num poid, taille;

  Patient({
    this.id,
    this.ordonnance,
    this.fullname,
    this.birthdate,
    @required this.userid,
    this.taille,
    this.poid,
  });

  Patient.fromMap(Map<String, dynamic> map) {
    id = map["patient_id"];
    ordonnance = map["patient_ordonnance"];
    fullname = map["patient_fullname"];
    birthdate = map["patient_birthdate"];
    taille = map["patient_taille"];
    poid = map["patient_poid"];
    userid = map["user_id"];
  }

  Map<String, dynamic> toMap() {
    return {
      "patient_id": id,
      "patient_ordonnance": ordonnance,
      "patient_fullname": fullname,
      "patient_birthdate": birthdate,
      "patient_taille": taille,
      "patient_poid": poid,
      "user_id": userid
    };
  }
}
