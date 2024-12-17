extension OptionalMapper<T> on T? {
  R? map<R>(R? Function(T) mapper) {
    final T? value = this;
    if (value == null) {
      return null;
    }
    return mapper(value);
  }

  T or(T value) => this ?? value;
}

extension StringDefault on String? {
  String get orDefault => this ?? '';
}

extension NumberDefault<T extends num> on T? {
  T get orDefault => this ?? (0 as T);
}

extension ListDefault<T> on List<T>? {
  List<T> get orDefault => this ?? List<T>.empty(growable: true);
}

extension SetDefault<T> on Set<T>? {
  Set<T> get orDefault => this ?? <T>{};
}

extension MapDefault<TKey, TValue> on Map<TKey, TValue>? {
  Map<TKey, TValue> get orDefault => this ?? <TKey, TValue>{};
}

extension BooleanDefault<TKey, TValue> on bool? {
  bool get orDefault => this ?? false;
}

extension BooleanInvert on bool {
  bool get inverted => !this;
}

extension StringIterableForstOrDefault on Iterable<String?> {
  String get firstOrDefault => firstOrNull.orDefault;
}

extension NumberIterableForstOrDefault<T extends num> on Iterable<T?> {
  T get firstOrDefault => firstOrNull.orDefault;
}

extension BooleanIterableForstOrDefault<TKey, TValue> on Iterable<bool?> {
  bool get firstOrDefault => firstOrNull.orDefault;
}

extension StringIsNullOrEmpty on String? {
  bool get isNullOrEmpty {
    final value = this;
    return value == null || value.isEmpty;
  }
}

extension IterableIsNullOrEmpty<T> on Iterable<T>? {
  bool get isNullOrEmpty {
    final value = this;
    return value == null || value.isEmpty;
  }
}
