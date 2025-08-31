class Sunday {
  num debitSunday;
  num kreditSunday;

  Sunday({required this.debitSunday, required this.kreditSunday});
  factory Sunday.fromJson(Map<String, dynamic> json) {
    return Sunday(
        debitSunday: json['debitSunday'], kreditSunday: json['kreditSunday']);
  }
}

class Monday {
  num debitMonday;
  num kreditMonday;

  Monday({required this.debitMonday, required this.kreditMonday});
  factory Monday.fromJson(Map<String, dynamic> json) {
    return Monday(
        debitMonday: json['debitMonday'], kreditMonday: json['kreditMonday']);
  }
}

class Tuesday {
  num debitTuesday;
  num kreditTuesday;

  Tuesday({required this.debitTuesday, required this.kreditTuesday});
  factory Tuesday.fromJson(Map<String, dynamic> json) {
    return Tuesday(
        debitTuesday: json['debitTuesday'],
        kreditTuesday: json['kreditTuesday']);
  }
}

class Wednesday {
  num debitWednesday;
  num kreditWednesday;

  Wednesday({required this.debitWednesday, required this.kreditWednesday});
  factory Wednesday.fromJson(Map<String, dynamic> json) {
    return Wednesday(
        debitWednesday: json['debitWednesday'],
        kreditWednesday: json['kreditWednesday']);
  }
}

class Thursday {
  num debitThursday;
  num kreditThursday;

  Thursday({required this.debitThursday, required this.kreditThursday});
  factory Thursday.fromJson(Map<String, dynamic> json) {
    return Thursday(
        debitThursday: json['debitThursday'],
        kreditThursday: json['kreditThursday']);
  }
}

class Friday {
  num debitFriday;
  num kreditFriday;

  Friday({required this.debitFriday, required this.kreditFriday});
  factory Friday.fromJson(Map<String, dynamic> json) {
    return Friday(
        debitFriday: json['debitFriday'], kreditFriday: json['kreditFriday']);
  }
}

class Saturday {
  num debitSaturday;
  num kreditSaturday;

  Saturday({required this.debitSaturday, required this.kreditSaturday});
  factory Saturday.fromJson(Map<String, dynamic> json) {
    return Saturday(
        debitSaturday: json['debitSaturday'],
        kreditSaturday: json['kreditSaturday']);
  }
}
