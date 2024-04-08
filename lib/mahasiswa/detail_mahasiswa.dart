import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/mahasiswa/mahasiswa_screen.dart';

class DetailMahasiswa extends StatefulWidget {
  const DetailMahasiswa({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  _DetailMahasiswaState createState() => _DetailMahasiswaState();
}

class _DetailMahasiswaState extends State<DetailMahasiswa> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  final TextEditingController _kelasmahasiswa = TextEditingController();

  bool _isFormIncomplete = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final String id = widget.id; // Get the ID passed to the widget
      final response = await http.get(
        Uri.parse(
            'https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1/news/$id'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        _title.text = jsonData['title'];
        _body.text = jsonData['body'];
        _kelasmahasiswa.text = jsonData['Kelas'];
      } else {
        print('Gagal mendapatkan data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _updateData() async {
    try {
      final Map<String, dynamic> updatedData = {
        'title': _title.text,
        'body': _body.text,
        'Kelas': _kelasmahasiswa.text,
      };

      final response = await http.put(
        Uri.parse(
            'https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1/news/${widget.id}'),
        body: jsonEncode(updatedData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Data berhasil diperbarui
        _showSnackBar('Data berhasil diperbarui'); // Tampilkan SnackBar
        Navigator.pop(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MahasiswaScreen())); // Kembali ke halaman sebelumnya setelah berhasil memperbarui data
      } else {
        // Gagal memperbarui data
        print('Gagal memperbarui data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Mahasiswa')),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey, // Mengaitkan GlobalKey dengan widget Form
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _title,
                    decoration: InputDecoration(labelText: 'Nama Mahasiswa :'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Harap isi Identitas Nama';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _body,
                    decoration: InputDecoration(labelText: 'Nim Mahasiswa :'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Harap isi Nomor Induk Mahasiswa';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _kelasmahasiswa,
                    decoration: InputDecoration(labelText: 'Kelas :'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Harap isi kelas';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateData();
                      } else {
                        setState(() {
                          _isFormIncomplete =
                              true; // Setel _isFormIncomplete menjadi true saat validasi gagal
                        });
                      }
                    },
                    child: Text('Simpan'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MahasiswaScreen()));
                    },
                    child: Text('Batal'),
                  ),
                  if (_isFormIncomplete)
                    const Text(
                      'Harap isi semua Data.',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}
