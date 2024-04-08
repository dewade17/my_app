import 'package:flutter/material.dart';
import 'package:my_app/masakan/EditResepPage.dart';
import 'package:my_app/masakan/resep_baru.dart';
import 'package:my_app/masakan/helper_resep.dart';
import 'package:my_app/masakan/present_masakan.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class MasakanScreen extends StatefulWidget {
  const MasakanScreen({Key? key}) : super(key: key);

  @override
  _MasakanScreenState createState() => _MasakanScreenState();
}

class _MasakanScreenState extends State<MasakanScreen> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Resep> resepList = [];

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Masakan'),
        leading: Icon(Icons.kitchen),
      ),
      body: SingleChildScrollView(
        child: createListView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Input Resep',
        onPressed: () async {
          var resep = await navigateToEntryForm(context);
          if (resep != null) addResep(resep);
        },
      ),
    );
  }

  Future<Resep?> navigateToEntryForm(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return InputResep(Resep(0, '', '', '')); // Create a new Resep object
      }),
    );
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1!;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              resepList[index].nama_masakan,
              style: textStyle,
            ),
            subtitle: Text(resepList[index].jenis_masakan),
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    var resep = await navigateToEditResepForm(
                        context, resepList[index]);
                    if (resep != null) editResep(resep);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteResep(resepList[index]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Resep?> navigateToEditResepForm(
      BuildContext context, Resep resep) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return EditResepPage(resep: resep);
      }),
    );
  }

  void addResep(Resep resep) async {
    int result = await dbHelper.insert(resep);
    if (result > 0) {
      updateListView();
    }
  }

  void editResep(Resep resep) async {
    int result = await dbHelper.update(resep);
    if (result > 0) {
      updateListView();
      print("Edit Resep RESULT: $result");
    }
  }

  void deleteResep(Resep resep) async {
    int result = await dbHelper.delete(resep.id);
    if (result > 0) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Resep>> resepListFuture = dbHelper.getResepList();
      resepListFuture.then((resepList) {
        setState(() {
          this.resepList = resepList;
          this.count = resepList.length;
        });
      });
    });
  }
}
