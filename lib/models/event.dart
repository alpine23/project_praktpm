class Welcome {
  final String? msg;
  final int? status;
  final EventsModel? data;

  Welcome({
    this.msg,
    this.status,
    this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
      msg: json['msg'],
      status: json['status'],
      data: json['data'] != null ? EventsModel.fromJson(json['data']) : null,
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

class EventsModel {
  final int? currentPage;
  final List<Data>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final String? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  EventsModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      currentPage: json['current_page'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Data.fromJson(item))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data?.map((item) => item.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class Data {
  final String? nama;
  final String? alamat;
  final String? namaTempat;
  final int? status;
  final int? tax;
  final String? slug;
  final DateTime? tanggalMulai;
  final String? filename;
  final int? minprice;

  Data({
    this.nama,
    this.alamat,
    this.namaTempat,
    this.status,
    this.tax,
    this.slug,
    this.tanggalMulai,
    this.filename,
    this.minprice,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      nama: json['nama'],
      alamat: json['alamat'],
      namaTempat: json['namaTempat'],
      status: json['status'],
      tax: json['tax'],
      slug: json['slug'],
      tanggalMulai: json['tanggal_mulai'] != null
          ? DateTime.parse(json['tanggal_mulai'])
          : null,
      filename: json['filename'],
      minprice: json['minprice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'alamat': alamat,
      'namaTempat': namaTempat,
      'status': status,
      'tax': tax,
      'slug': slug,
      'tanggal_mulai': tanggalMulai?.toIso8601String(),
      'filename': filename,
      'minprice': minprice,
    };
  }
}
