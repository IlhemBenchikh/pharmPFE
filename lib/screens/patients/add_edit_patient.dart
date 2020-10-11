import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/patient.dart';
import 'package:pharm_pfe/style/style.dart';

class AddEditPatient extends StatefulWidget {
  final Patient patient;

  final int userid;

  const AddEditPatient({Key key, this.patient, this.userid}) : super(key: key);
  @override
  _AddEditPatientState createState() => _AddEditPatientState();
}

class _AddEditPatientState extends State<AddEditPatient> {
  TextEditingController ordonnanceController,
      fullnameController,
      tailleController,
      poidController;
  String birthDate;
  GlobalKey<FormState> _formKey;

  InputDecoration _inputDecoration(String lable) {
    return InputDecoration(
        labelText: lable,
        errorStyle:
            Theme.of(context).textTheme.caption.copyWith(color: Style.redColor),
        labelStyle: Theme.of(context).textTheme.caption,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Style.redColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Style.redColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.primaryColor),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Style.accentColor),
        ));
  }

  @override
  void initState() {
    _formKey = GlobalKey();
    if (widget.patient != null) {
      ordonnanceController =
          TextEditingController(text: widget.patient.ordonnance);
      fullnameController = TextEditingController(text: widget.patient.fullname);
      tailleController =
          TextEditingController(text: widget.patient.taille.toString());
      poidController =
          TextEditingController(text: widget.patient.poid.toString());
      birthDate = widget.patient.birthdate;
    } else {
      ordonnanceController = TextEditingController();
      fullnameController = TextEditingController();
      poidController = TextEditingController();
      tailleController = TextEditingController();
      birthDate = "";
    }
    super.initState();
  }

  _validateInput() {
    if (_formKey.currentState.validate()) {
      //TODO: save Patient
      if (widget.patient == null) {
        print("added");
        DatabaseHelper.insertPatient(Patient(
          id: null,
          userid: widget.userid,
          ordonnance: ordonnanceController.text.trim(),
          birthdate: birthDate.isEmpty ? "2000-1-1" : birthDate,
          taille: num.parse(tailleController.text),
          poid: num.parse(poidController.text),
          fullname: fullnameController.text.trim(),
        )).then((value) {
          Navigator.of(context).pop(Patient(
            id: value,
            userid: widget.userid,
            ordonnance: ordonnanceController.text.trim(),
            birthdate: birthDate.isEmpty ? "2000-1-1" : birthDate,
            taille: num.parse(tailleController.text),
            poid: num.parse(poidController.text),
            fullname: fullnameController.text.trim(),
          ));
        }).catchError((onError) {
          return;
        });
      } else {
        print("updated");
        DatabaseHelper.updatePatient(Patient(
          id: widget.patient.id,
          userid: widget.patient.userid,
          ordonnance: ordonnanceController.text.trim(),
          birthdate: birthDate.isEmpty ? "2000-1-1" : birthDate,
          taille: num.parse(tailleController.text),
          poid: num.parse(poidController.text),
          fullname: fullnameController.text.trim(),
        )).then((value) {
          Navigator.of(context).pop(Patient(
            id: widget.patient.id,
            userid: widget.userid,
            ordonnance: ordonnanceController.text.trim(),
            birthdate: birthDate.isEmpty ? "2000-1-1" : birthDate,
            taille: num.parse(tailleController.text),
            poid: num.parse(poidController.text),
            fullname: fullnameController.text.trim(),
          ));
        }).catchError((onError) {
          return;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.darkBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _validateInput();
              })
        ],
        backgroundColor: Style.darkblueColor,
        title: Text(widget.patient == null ? "Ajouter" : "Modifier",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Style.darkBackgroundColor)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("N° Ordonnance"),
                controller: ordonnanceController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir le N° de l'Ordonnance";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Nom complet de patient"),
                controller: fullnameController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir un nom complet";
                  }
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                    color: Style.darkBackgroundColor,
                    child: InkWell(
                      onTap: () {
                        DatePicker.showSimpleDatePicker(
                          context,
                          cancelText: "Annuler",
                          titleText: "Date de naissance",
                          textColor: Style.primaryColor,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1930),
                          lastDate: DateTime(2020),
                          dateFormat: "dd-MMMM-yyyy",
                          locale: DateTimePickerLocale.fr,
                          looping: true,
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              birthDate = value.year.toString() +
                                  "-" +
                                  value.month.toString() +
                                  "-" +
                                  value.day.toString();
                            });
                          }
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            // border: Border(
                            //     bottom: BorderSide(
                            //         color: Style.secondaryColor, width: 1))
                          ),
                          child: Text(
                            birthDate.isEmpty ? "Date de naissance" : birthDate,
                            style: birthDate.isEmpty
                                ? Theme.of(context).textTheme.caption
                                : Theme.of(context).textTheme.bodyText2,
                          )),
                    ))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Taille"),
                controller: tailleController,
                keyboardType: TextInputType.number,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir la taille";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Poid"),
                controller: poidController,
                keyboardType: TextInputType.number,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir le poid";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
