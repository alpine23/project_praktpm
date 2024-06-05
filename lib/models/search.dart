class SearchData {
  final String? nama;
  final String? alamat;
  final String? namaTempat;
  final int? tax;
  final int? status;
  final String? slug;
  final String? tanggalMulai;
  final String? filename;
  final int? minprice;
  final String? updatedAt;

  SearchData({
    this.nama,
    this.alamat,
    this.namaTempat,
    this.tax,
    this.status,
    this.slug,
    this.tanggalMulai,
    this.filename,
    this.minprice,
    this.updatedAt,
  });

  SearchData.fromJson(Map<String, dynamic> json)
      : nama = json['nama'] as String?,
        alamat = json['alamat'] as String?,
        namaTempat = json['namaTempat'] as String?,
        tax = json['tax'] as int?,
        status = json['status'] as int?,
        slug = json['slug'] as String?,
        tanggalMulai = json['tanggalMulai'] as String?,
        filename = json['filename'] as String?,
        minprice = json['minprice'] as int?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'alamat': alamat,
        'namaTempat': namaTempat,
        'tax': tax,
        'status': status,
        'slug': slug,
        'tanggalMulai': tanggalMulai,
        'filename': filename,
        'minprice': minprice,
        'updated_at': updatedAt
      };
}
