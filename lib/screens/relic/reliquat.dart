import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/customWidgets/empty_folder.dart';
import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

class ReliquatList extends StatefulWidget {
  final int userid;

  const ReliquatList({Key key, this.userid}) : super(key: key);
  @override
  _ReliquatListState createState() => _ReliquatListState();
}

class _ReliquatListState extends State<ReliquatList> {
  List<Drug> reliquatList;

  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.darkBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        title: Text('Liste des reliquats perimés'),
        backgroundColor: Colors.cyan[700],
      ),
      body: ListView(children: <Widget>[
        ListTile(
          trailing: Icon(
            Icons.delete_forever,
            size: 25,
            color: Colors.cyan[700],
          ),
          contentPadding: EdgeInsets.all(12),
          leading: Icon(
            Icons.inbox,
            color: Colors.cyan[700],
          ),
          title: Text(
            "doliprane",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Style.primaryColor),
          ),
        ),
        ListTile(
          trailing:
              Icon(Icons.delete_forever, size: 25, color: Colors.cyan[700]),
          contentPadding: EdgeInsets.all(12),
          leading: Icon(
            Icons.inbox,
            color: Colors.cyan[700],
          ),
          title: Text(
            "AHHk",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Style.primaryColor),
          ),
        ),
      ]),
    );
  }
}
