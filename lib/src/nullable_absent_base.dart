/// Wrapper class for representing absent value.
class NullableAbsent<T> {
  final bool _absent;
  final T? _value;

  /// Create a present [value]
  const NullableAbsent(T? value)
      : _absent = false,
        _value = value;

  /// Create an absent
  const NullableAbsent.absent()
      : _absent = true,
        _value = null as dynamic;

  /// Return the result value after applying [newValue]
  T? apply(NullableAbsent<T> newValue) =>
      newValue._absent ? this._value : newValue._value;
}
