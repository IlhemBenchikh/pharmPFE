class Analysis {
  int id, userid;
  String creationDate;
  int patientId;
  int drugId;
  num posologie,
      reduction,
      surfaceCorporelle,
      adminDose,
      finalVolume,
      reliquat,
      maxIntervale,
      minIntervale;

  Analysis(
      {this.id,
      this.userid,
      this.creationDate,
      this.patientId,
      this.drugId,
      this.posologie,
      this.reduction,
      this.surfaceCorporelle,
      this.adminDose,
      this.finalVolume,
      this.reliquat,
      this.maxIntervale,
      this.minIntervale});

  Analysis.fromMap(Map<String, dynamic> map) {
    id = map["poch_id"];
    creationDate = map["poch_creationdate"];
    surfaceCorporelle = map["poch_surfaceCorporelle"];
    posologie = map["poch_posologie"];
    reduction = map["poch_reduction"];
    adminDose = map["poch_adminDose"];
    finalVolume = map["poch_finalVolume"];
    reliquat = map["poch_reliquat"];
    maxIntervale = map["poch_maxintervale"];
    minIntervale = map["poch_minintervale"];
    drugId = map["drug_id"];
    patientId = map["patient_id"];
    userid = map["user_id"];
  }

  Map<String, dynamic> toMap() {
    return {
      "poch_id": id,
      "poch_creationdate": creationDate,
      "poch_posologie": posologie,
      "poch_reduction": reduction,
      "poch_surfaceCorporelle": surfaceCorporelle,
      "poch_adminDose": adminDose,
      "poch_finalVolume": finalVolume,
      "poch_reliquat": reliquat,
      "drug_id": drugId,
      "user_id": userid,
      "patient_id": patientId,
      "poch_maxintervale": maxIntervale,
      "poch_minintervale": minIntervale,
    };
  }
}
