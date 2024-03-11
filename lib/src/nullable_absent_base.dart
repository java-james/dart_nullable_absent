class NullableAbsent<T> {
  final bool _absent;
  final T? _value;

  const NullableAbsent(T? value):
        _absent = false,
        _value = value;

  const NullableAbsent.absent():
      _absent = true,
      _value = null;

  bool get isAbsent => _absent;

  T? replace({required T? oldValue}) => _absent ? oldValue : _value;
}
