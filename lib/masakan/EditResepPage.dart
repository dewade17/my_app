import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:my_app/masakan/present_masakan.dart';

class EditResepPage extends StatefulWidget {
  final Resep resep;

  EditResepPage({required this.resep});

  @override
  _EditResepPageState createState() => _EditResepPageState();
}

class _EditResepPageState extends State<EditResepPage> {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _namaController = TextEditingController();
  TextEditingController _jenisController = TextEditingController();
  DateTime? _tanggalPosting;

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.resep.nama_masakan;
    _jenisController.text = widget.resep.jenis_masakan;
    _tanggalPosting = DateTime.parse(widget.resep.tanggal_posting);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Resep'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Masakan'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _jenisController,
                decoration: InputDecoration(labelText: 'Jenis Masakan'),
              ),
              SizedBox(height: 30),
              DateTimeField(
                format: format,
                initialValue: _tanggalPosting,
                decoration: InputDecoration(
                  labelText: "Tanggal Posting",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2045),
                  );
                },
                onChanged: (selectedDate) {
                  setState(() {
                    _tanggalPosting = selectedDate;
                  });
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _saveChanges();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(double.infinity, 50), // Lebar minimum tombol
                  ),
                  child:
                      Text('Simpan Perubahan', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(double.infinity, 50), // Lebar minimum tombol
                  ),
                  child: Text('Batal', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    // Mendapatkan nilai terbaru dari TextFormField
    String namaMasakan = _namaController.text;
    String jenisMasakan = _jenisController.text;
    String tanggalPosting = _tanggalPosting != null
        ? format.format(_tanggalPosting!)
        : widget.resep.tanggal_posting;

    // Membuat objek Resep baru dengan nilai terbaru
    Resep updatedResep = Resep(
      widget.resep.id,
      namaMasakan,
      jenisMasakan,
      tanggalPosting,
    );

    // Mengembalikan nilai Resep yang diperbarui ke halaman sebelumnya
    Navigator.pop(context, updatedResep);
  }
}
