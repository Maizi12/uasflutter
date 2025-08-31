class Week1 {
  num debitWeek1;
  num kreditWeek1;

  Week1({required this.debitWeek1, required this.kreditWeek1});
  factory Week1.fromJson(Map<String, dynamic> json) {
    return Week1(
        debitWeek1: json['debitWeek1'], kreditWeek1: json['kreditWeek1']);
  }
}

class Week2 {
  num debitWeek2;
  num kreditWeek2;

  Week2({required this.debitWeek2, required this.kreditWeek2});
  factory Week2.fromJson(Map<String, dynamic> json) {
    return Week2(
        debitWeek2: json['debitWeek2'], kreditWeek2: json['kreditWeek2']);
  }
}

class Week3 {
  num debitWeek3;
  num kreditWeek3;

  Week3({required this.debitWeek3, required this.kreditWeek3});
  factory Week3.fromJson(Map<String, dynamic> json) {
    return Week3(
        debitWeek3: json['debitWeek3'], kreditWeek3: json['kreditWeek3']);
  }
}

class Week4 {
  num debitWeek4;
  num kreditWeek4;

  Week4({required this.debitWeek4, required this.kreditWeek4});
  factory Week4.fromJson(Map<String, dynamic> json) {
    return Week4(
        debitWeek4: json['debitWeek4'], kreditWeek4: json['kreditWeek4']);
  }
}

class Week5 {
  num debitWeek5;
  num kreditWeek5;

  Week5({required this.debitWeek5, required this.kreditWeek5});
  factory Week5.fromJson(Map<String, dynamic> json) {
    return Week5(
        debitWeek5: json['debitWeek5'], kreditWeek5: json['kreditWeek5']);
  }
}
