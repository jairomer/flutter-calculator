class Optional<E> {
  late E content;
  void assign(E c) {
    content = c;
  }
  E? get() {
    return content;
  }
}