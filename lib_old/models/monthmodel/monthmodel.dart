class Januari {
  num debitJanuari;
  num kreditJanuari;

  Januari({required this.debitJanuari, required this.kreditJanuari});
  factory Januari.fromJson(Map<String, dynamic> json) {
    return Januari(
        debitJanuari: json['debitJanuari'],
        kreditJanuari: json['kreditJanuari']);
  }
}

class Februari {
  num debitFebruari;
  num kreditFebruari;

  Februari({required this.debitFebruari, required this.kreditFebruari});
  factory Februari.fromJson(Map<String, dynamic> json) {
    return Februari(
        debitFebruari: json['debitFebruari'],
        kreditFebruari: json['kreditFebruari']);
  }
}

class Maret {
  num debitMaret;
  num kreditMaret;

  Maret({required this.debitMaret, required this.kreditMaret});
  factory Maret.fromJson(Map<String, dynamic> json) {
    return Maret(
        debitMaret: json['debitMaret'], kreditMaret: json['kreditMaret']);
  }
}

class April {
  num debitApril;
  num kreditApril;

  April({required this.debitApril, required this.kreditApril});
  factory April.fromJson(Map<String, dynamic> json) {
    return April(
        debitApril: json['debitApril'], kreditApril: json['kreditApril']);
  }
}

class Mei {
  num debitMei;
  num kreditMei;

  Mei({required this.debitMei, required this.kreditMei});
  factory Mei.fromJson(Map<String, dynamic> json) {
    return Mei(debitMei: json['debitMei'], kreditMei: json['kreditMei']);
  }
}

class Juni {
  num debitJuni;
  num kreditJuni;

  Juni({required this.debitJuni, required this.kreditJuni});
  factory Juni.fromJson(Map<String, dynamic> json) {
    return Juni(debitJuni: json['debitJuni'], kreditJuni: json['kreditJuni']);
  }
}

class Juli {
  num debitJuli;
  num kreditJuli;

  Juli({required this.debitJuli, required this.kreditJuli});
  factory Juli.fromJson(Map<String, dynamic> json) {
    return Juli(debitJuli: json['debitJuli'], kreditJuli: json['kreditJuli']);
  }
}

class Agustus {
  num debitAgustus;
  num kreditAgustus;

  Agustus({required this.debitAgustus, required this.kreditAgustus});
  factory Agustus.fromJson(Map<String, dynamic> json) {
    return Agustus(
        debitAgustus: json['debitAgustus'],
        kreditAgustus: json['kreditAgustus']);
  }
}

class September {
  num debitSeptember;
  num kreditSeptember;

  September({required this.debitSeptember, required this.kreditSeptember});
  factory September.fromJson(Map<String, dynamic> json) {
    return September(
        debitSeptember: json['debitSeptember'],
        kreditSeptember: json['kreditSeptember']);
  }
}

class Oktober {
  num debitOktober;
  num kreditOktober;

  Oktober({required this.debitOktober, required this.kreditOktober});
  factory Oktober.fromJson(Map<String, dynamic> json) {
    return Oktober(
        debitOktober: json['debitOktober'],
        kreditOktober: json['kreditOktober']);
  }
}

class November {
  num debitNovember;
  num kreditNovember;

  November({required this.debitNovember, required this.kreditNovember});
  factory November.fromJson(Map<String, dynamic> json) {
    return November(
        debitNovember: json['debitNovember'],
        kreditNovember: json['kreditNovember']);
  }
}

class Desember {
  num debitDesember;
  num kreditDesember;

  Desember({required this.debitDesember, required this.kreditDesember});
  factory Desember.fromJson(Map<String, dynamic> json) {
    return Desember(
        debitDesember: json['debitDesember'],
        kreditDesember: json['kreditDesember']);
  }
}
