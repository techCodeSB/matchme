int getAgeFromYMD(dobString) {
  var getDate = dobString.split(" ")[0];
 
  DateTime dob = DateTime.parse(getDate); // expects 'YYYY-MM-DD'
  DateTime today = DateTime.now();

  int age = today.year - dob.year;

  bool hasBirthdayPassed = (today.month > dob.month) ||
      (today.month == dob.month && today.day >= dob.day);

  if (!hasBirthdayPassed) {
    age--;
  }

  return age;
}