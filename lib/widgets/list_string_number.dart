//สร้าง Array ตัวเลข

List<String> listStringNumber({required int start, required int end, bool invert = false}) {
  List<String> data = [];

  for (var i = start; i <= end; i++) {
    if (invert) {
      data.insert(0, i.toString());
    } else {
      data.add(i.toString());
    }
  }

  return data;
}
