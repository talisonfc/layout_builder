class SlotState {
  static int index = 0;

  static generateIndex() {
    return index++;
  }
}
