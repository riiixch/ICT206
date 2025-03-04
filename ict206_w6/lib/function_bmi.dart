List<dynamic> function_bmi(double weight, double height) {
  double height_cal = height / 100;
  height_cal = height_cal * height_cal;

  double bmi = weight / height_cal;

  String message = "";

  if (bmi >= 30) {
    message = "น้ำหนักอยู่ในเกณท์อ้วนมาก";
  } else if (bmi >= 25) {
    message = "น้ำหนักอยู่ในเกณท์อ้วน";
  } else if (bmi >= 23) {
    message = "น้ำหนักเกินมาตราฐาน";
  } else if (bmi >= 18.5) {
    message = "น้ำหนักสมส่วน";
  } else {
    message = "น้ำหนักต่ำกว่าเกณท์";
  }

  return [bmi, message];
}
