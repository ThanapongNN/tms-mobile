bool validateThaiNationalID(String id) {
  if (id.length != 13) return false;

  int i = 0, sum = 0;
  // STEP 1 - get only first 12 digits
  for (; i < 12; i++) {
    // STEP 2 - multiply each digit with each index (reverse)
    // STEP 3 - sum multiply value together
    sum += int.parse(id[i]) * (13 - i);
  }
  // STEP 4 - mod sum with 11
  double mod = sum % 11;
  // STEP 5 - subtract 11 with mod, then mod 10 to get unit
  double check = (11 - mod) % 10;
  // STEP 6 - if check is match the digit 13th is correct
  if (check == int.parse(id[12])) {
    return true;
  }
  return false;
}
