dynamic studentInfo() {
  // TODO 1

  var name ="Zahratul Adzka";
  var favNumber = 7;
  final bool isPraktikan= true;

  // End of TODO 1
  return [name, favNumber, isPraktikan];
}

dynamic circleArea(num r) {
  if (r < 0) {
    return 0.0;
  } else {
    const double pi = 3.1415926535897932; //π sama dengan library dart.math;

    // TODO 2
      double area = pi *r*r;
      return area;
    // End of TODO 2
  }
}

int? parseAndAddOne(String? input) {
  // TODO 3
  if(input == null) {
    return null;
  }

  int? parsedNumber = int.tryParse(input);
  if (parsedNumber == null){
    throw Exception("Input harus berupa Angka");
  } 
  return parsedNumber +1;
  // End of TODO 3
}
