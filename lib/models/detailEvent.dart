class Welcome {
  final String? msg;
  final int? status;
  final Data? data;

  Welcome({
    this.msg,
    this.status,
    this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
      msg: json['msg'],
      status: json['status'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class Data {
  final int? id;
  final String? nama;
  final String? user;
  final DateTime? tanggalMulai;
  final String? waktuMulai;
  final DateTime? tanggalSelesai;
  final String? waktuSelesai;
  final String? alamat;
  final String? namaTempat;
  final int? tax;
  final String? filename;
  final String? deskripsi;
  final String? slug;
  final int? status;

  Data({
    this.id,
    this.nama,
    this.user,
    this.tanggalMulai,
    this.waktuMulai,
    this.tanggalSelesai,
    this.waktuSelesai,
    this.alamat,
    this.namaTempat,
    this.tax,
    this.filename,
    this.deskripsi,
    this.slug,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      nama: json['nama'],
      user: json['user'],
      tanggalMulai: json['tanggalMulai'] != null
          ? DateTime.parse(json['tanggalMulai'])
          : null,
      waktuMulai: json['waktuMulai'],
      tanggalSelesai: json['tanggalSelesai'] != null
          ? DateTime.parse(json['tanggalSelesai'])
          : null,
      waktuSelesai: json['waktuSelesai'],
      alamat: json['alamat'],
      namaTempat: json['namaTempat'],
      tax: json['tax'],
      filename: json['filename'],
      deskripsi: json['deskripsi'],
      slug: json['slug'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'user': user,
      'tanggalMulai': tanggalMulai?.toIso8601String(),
      'waktuMulai': waktuMulai,
      'tanggalSelesai': tanggalSelesai?.toIso8601String(),
      'waktuSelesai': waktuSelesai,
      'alamat': alamat,
      'namaTempat': namaTempat,
      'tax': tax,
      'filename': filename,
      'deskripsi': deskripsi,
      'slug': slug,
      'status': status,
    };
  }
}
