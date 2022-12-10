/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myBiodataNode = Biodata.fromJson(map);
*/
class Biodata {
  String? namalengkap;
  String? programstudi;
  String? nim;
  String? status;
  String? dosenpembimbingakademik;
  String? tempatlahir;
  String? tanggallahir;
  String? jeniskelamin;
  String? agama;
  String? alamatasal;
  String? alamatdiselong;
  String? nomortelepon;
  String? namaayah;
  String? namaibu;
  String? pekerjaanayah;
  String? pekerjaanibu;
  String? penghasilanayah;
  String? penghasilanibu;

  Biodata(
      {this.namalengkap,
      this.programstudi,
      this.nim,
      this.status,
      this.dosenpembimbingakademik,
      this.tempatlahir,
      this.tanggallahir,
      this.jeniskelamin,
      this.agama,
      this.alamatasal,
      this.alamatdiselong,
      this.nomortelepon,
      this.namaayah,
      this.namaibu,
      this.pekerjaanayah,
      this.pekerjaanibu,
      this.penghasilanayah,
      this.penghasilanibu});

  Biodata.fromJson(Map<String, dynamic> json) {
    namalengkap = json['nama_lengkap'];
    programstudi = json['program_studi'];
    nim = json['nim'];
    status = json['status'];
    dosenpembimbingakademik = json['dosen_pembimbing akademik'];
    tempatlahir = json['tempat_lahir'];
    tanggallahir = json['tanggal_lahir'];
    jeniskelamin = json['jenis_kelamin'];
    agama = json['agama'];
    alamatasal = json['alamat_asal'];
    alamatdiselong = json['alamat_(di selong)'];
    nomortelepon = json['nomor_telepon'];
    namaayah = json['nama_ayah'];
    namaibu = json['nama_ibu'];
    pekerjaanayah = json['pekerjaan_ayah'];
    pekerjaanibu = json['pekerjaan_ibu'];
    penghasilanayah = json['penghasilan_ayah'];
    penghasilanibu = json['penghasilan_ibu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nama_lengkap'] = namalengkap;
    data['program_studi'] = programstudi;
    data['nim'] = nim;
    data['status'] = status;
    data['dosen_pembimbing akademik'] = dosenpembimbingakademik;
    data['tempat_lahir'] = tempatlahir;
    data['tanggal_lahir'] = tanggallahir;
    data['jenis_kelamin'] = jeniskelamin;
    data['agama'] = agama;
    data['alamat_asal'] = alamatasal;
    data['alamat_(di selong)'] = alamatdiselong;
    data['nomor_telepon'] = nomortelepon;
    data['nama_ayah'] = namaayah;
    data['nama_ibu'] = namaibu;
    data['pekerjaan_ayah'] = pekerjaanayah;
    data['pekerjaan_ibu'] = pekerjaanibu;
    data['penghasilan_ayah'] = penghasilanayah;
    data['penghasilan_ibu'] = penghasilanibu;
    return data;
  }

  String getFoto() {
    return "https://sias.universitasmulia.ac.id/upload/foto_mahasiswa/${nim}.jpg";
  }
}
