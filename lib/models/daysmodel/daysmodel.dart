class Sunday {
  num pemasukanSunday;
  num pengeluaranSunday;

  Sunday({required this.pemasukanSunday, required this.pengeluaranSunday});
  factory Sunday.fromJson(Map<String, dynamic> json) {
    return Sunday(
        pemasukanSunday: json['pemasukanSunday'],
        pengeluaranSunday: json['pengeluaranSunday']);
  }
}

class Monday {
  num pemasukanMonday;
  num pengeluaranMonday;

  Monday({required this.pemasukanMonday, required this.pengeluaranMonday});
  factory Monday.fromJson(Map<String, dynamic> json) {
    return Monday(
        pemasukanMonday: json['pemasukanMonday'],
        pengeluaranMonday: json['pengeluaranMonday']);
  }
}

class Tuesday {
  num pemasukanTuesday;
  num pengeluaranTuesday;

  Tuesday({required this.pemasukanTuesday, required this.pengeluaranTuesday});
  factory Tuesday.fromJson(Map<String, dynamic> json) {
    return Tuesday(
        pemasukanTuesday: json['pemasukanTuesday'],
        pengeluaranTuesday: json['pengeluaranTuesday']);
  }
}

class Wednesday {
  num pemasukanWednesday;
  num pengeluaranWednesday;

  Wednesday(
      {required this.pemasukanWednesday, required this.pengeluaranWednesday});
  factory Wednesday.fromJson(Map<String, dynamic> json) {
    return Wednesday(
        pemasukanWednesday: json['pemasukanWednesday'],
        pengeluaranWednesday: json['pengeluaranWednesday']);
  }
}

class Thursday {
  num pemasukanThursday;
  num pengeluaranThursday;

  Thursday(
      {required this.pemasukanThursday, required this.pengeluaranThursday});
  factory Thursday.fromJson(Map<String, dynamic> json) {
    return Thursday(
        pemasukanThursday: json['pemasukanThursday'],
        pengeluaranThursday: json['pengeluaranThursday']);
  }
}

class Friday {
  num pemasukanFriday;
  num pengeluaranFriday;

  Friday({required this.pemasukanFriday, required this.pengeluaranFriday});
  factory Friday.fromJson(Map<String, dynamic> json) {
    return Friday(
        pemasukanFriday: json['pemasukanFriday'],
        pengeluaranFriday: json['pengeluaranFriday']);
  }
}

class Saturday {
  num pemasukanSaturday;
  num pengeluaranSaturday;

  Saturday(
      {required this.pemasukanSaturday, required this.pengeluaranSaturday});
  factory Saturday.fromJson(Map<String, dynamic> json) {
    return Saturday(
        pemasukanSaturday: json['pemasukanSaturday'],
        pengeluaranSaturday: json['pengeluaranSaturday']);
  }
}
