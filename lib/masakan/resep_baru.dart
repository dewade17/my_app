import 'package:flutter/material.dart';
import 'package:my_app/masakan/present_masakan.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class InputResep extends StatefulWidget {
  final Resep resep;

  InputResep(this.resep);

  @override
  _InputResepState createState() => _InputResepState(this.resep);
}

class _InputResepState extends State<InputResep> {
  Resep resep;
  TextEditingController namaMasakanController = TextEditingController();
  TextEditingController jenisMasakanController = TextEditingController();
  TextEditingController tanggalPostingController = TextEditingController();
  final format = DateFormat('yyyy-MM-dd');

  _InputResepState(this.resep);

  @override
  Widget build(BuildContext context) {
    namaMasakanController.text = resep.nama_masakan;
    jenisMasakanController.text = resep.jenis_masakan;
    tanggalPostingController.text = resep.tanggal_posting;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Resep"),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: namaMasakanController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Nama Masakan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: jenisMasakanController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Jenis Masakan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  DateTimeField(
                    controller: tanggalPostingController,
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2045),
                      );
                    },
                    decoration: InputDecoration(
                      labelText: "Tanggal Posting",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColorLight,
                        backgroundColor: Theme.of(context).primaryColorDark,
                      ),
                      child: Text("Simpan", textScaleFactor: 1.5),
                      onPressed: () {
                        resep.nama_masakan = namaMasakanController.text;
                        resep.jenis_masakan = jenisMasakanController.text;
                        resep.tanggal_posting = tanggalPostingController.text;
                        print("Ini Update ya");
                        Navigator.pop(context, resep);
                      },
                    ),
                  ),
                  Container(width: 5.0),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColorLight,
                        backgroundColor: Theme.of(context).primaryColorDark,
                      ),
                      child: Text("Batal", textScaleFactor: 1.5),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
