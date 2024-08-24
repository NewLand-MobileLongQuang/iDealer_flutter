class PivotItem {
  Map<String, String> data;
  int count;

  PivotItem({required this.data, this.count = 1});

  bool isSameItemGroup(PivotItem item, List<String> keys) {
    var isDif = false;
    for (int i = 0; i < keys.length; i++) {
      if (data[keys[i]] != item.data[keys[i]]) {
        isDif = true;
        break;
      }
    }
    return !isDif;
  }
}
