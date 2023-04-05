class Stack<E> {
  late List<E> _stackContents;

  Stack() {
    _stackContents = <E>[];
  }

  E? look() {
    if (_stackContents.isEmpty) {
      return null;
    }
    return _stackContents.first;
  }

  E? pop() {
    if (_stackContents.isEmpty) {
      return null;
    }
    var first = _stackContents.first;
    _stackContents.removeAt(0);
    return first;
  }

  void push(E item) {
    _stackContents.add(item);
  }

  int size() {
    return _stackContents.length;
  }
}