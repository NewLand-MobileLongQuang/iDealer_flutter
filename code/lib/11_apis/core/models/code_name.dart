class CodeName {
  String code;
  String name;

  CodeName(this.code, this.name);

  static bool compareFn(CodeName? one, CodeName? two) {
    if (one == null) {
      if (two == null) {
        return true;
      }
      return false;
    }
    if (two == null) {
      return false;
    }
    if (one.code == two.code) {
      return true;
    }
    return false;
  }
}
