class Resep {
  // Attributes
  late int _id;
  late String _nama_masakan;
  late String _jenis_masakan;
  late String _tanggal_posting;

  // Constructor
  Resep(
      this._id, this._nama_masakan, this._jenis_masakan, this._tanggal_posting);

  // Named Constructor fromMap
  Resep.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nama_masakan = map['nama_masakan'].toString();
    this._jenis_masakan = map['jenis_masakan'].toString();
    this._tanggal_posting = map['tanggal_posting'].toString();
  }

  // Getter methods
  int get id => _id;
  String get nama_masakan => _nama_masakan;
  String get jenis_masakan => _jenis_masakan;
  String get tanggal_posting => _tanggal_posting;

  // Setter methods
  set nama_masakan(String value) {
    _nama_masakan = value;
  }

  set jenis_masakan(String value) {
    _jenis_masakan = value;
  }

  set tanggal_posting(String value) {
    _tanggal_posting = value;
  }

  // Convert object attributes to Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nama_masakan'] = nama_masakan;
    map['jenis_masakan'] = jenis_masakan;
    map['tanggal_posting'] = tanggal_posting;
    return map;
  }
}
