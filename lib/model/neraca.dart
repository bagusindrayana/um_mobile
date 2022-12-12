class Neraca {
  String? namaTransaksi;
  String? debet;
  String? kredit;
  String? saldo;

  Neraca({this.namaTransaksi, this.debet, this.kredit, this.saldo});

  Neraca.fromJson(Map<String, dynamic> json) {
    namaTransaksi = json['nama_transaksi'];
    debet = json['debet'];
    kredit = json['kredit'];
    saldo = json['saldo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_transaksi'] = this.namaTransaksi;
    data['debet'] = this.debet;
    data['kredit'] = this.kredit;
    data['saldo'] = this.saldo;
    return data;
  }
}
