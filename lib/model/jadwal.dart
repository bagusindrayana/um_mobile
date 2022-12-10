/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myJadwalNode = Jadwal.fromJson(map);
*/
class Jadwal {
  String? hari;
  String? jam;
  String? kode;
  String? nama;
  String? sks;
  String? kelas;
  String? ruang;
  String? dosen;

  Jadwal(
      {this.hari,
      this.jam,
      this.kode,
      this.nama,
      this.sks,
      this.kelas,
      this.ruang,
      this.dosen});

  Jadwal.fromJson(Map<String, dynamic> json) {
    hari = json['hari'];
    jam = json['jam'];
    kode = json['kode'];
    nama = json['nama'];
    sks = json['sks'];
    kelas = json['kelas'];
    ruang = json['ruang'];
    dosen = json['dosen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['hari'] = hari;
    data['jam'] = jam;
    data['kode'] = kode;
    data['nama'] = nama;
    data['sks'] = sks;
    data['kelas'] = kelas;
    data['ruang'] = ruang;
    data['dosen'] = dosen;
    return data;
  }
}
