extension HandleEnum on String {
  String? getName() {
    return this.toString().split('.').last;
  }
}
