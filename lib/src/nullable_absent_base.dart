
/// Wrapper class for representing absent value.
class NullableAbsent<T> {
  final bool _absent;
  final T? _value;

  /// Create a present [value]
  const NullableAbsent(T? value):
        _absent = false,
        _value = value;

  /// Create an absent
  const NullableAbsent.absent():
      _absent = true,
      _value = null;

  /// Whether the value is absent
  bool get isAbsent => _absent;

  /// Return the result value when applying [this] on [oldValue]
  T? replace({required T? oldValue}) => _absent ? oldValue : _value;
}
