extension IterableCompactMap<T> on Iterable<T> {
  Iterable<TR> compactMap<TR>(TR? Function(T) selector) {
    return map(selector).noneNull();
  }

  List<TR> compactMapList<TR>(TR? Function(T) selector) {
    return compactMap(selector).toList();
  }
}

extension IterableNoneNull<T> on Iterable<T?> {
  Iterable<T> noneNull() sync* {
    for (final item in this) {
      if (item != null) {
        yield item;
      }
    }
  }
}

extension ListNoneNull<T> on Iterable<T?> {
  List<T> noneNullList() {
    return noneNull().toList();
  }
}

extension DistinctItems<T> on Iterable<T> {
  Iterable<T> distinctBy<TProp>(TProp Function(T) selector) sync* {
    final setList = <TProp>{};
    for (final item in this) {
      final key = selector(item);
      if (setList.add(key)) {
        yield item;
      }
    }
  }
}

extension IterableMinMax<T extends num> on Iterable<T> {
  T? min() {
    T? value;
    for (final item in this) {
      if (value == null || value > item) {
        value = item;
      }
    }
    return value;
  }

  T? max() {
    T? value;
    for (final item in this) {
      if (value == null || value < item) {
        value = item;
      }
    }
    return value;
  }

  double? mid() {
    T? min, max;
    for (final item in this) {
      if (min == null || min > item) {
        min = item;
      }
      if (max == null || max < item) {
        max = item;
      }
    }
    if (min != null && max != null) {
      return (max + min) / 2;
    }
    return null;
  }
}
