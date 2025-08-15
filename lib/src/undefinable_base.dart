/// Wrapper class for representing an undefined value.
class Undefinable<BaseType> {
  final bool _isUndefined;
  final BaseType _value;

  /// Constructors to create with and without a value
  const Undefinable(BaseType value)
      : _isUndefined = false,
        _value = value;
  const Undefinable.defined(BaseType value)
      : _isUndefined = false,
        _value = value;
  const Undefinable.undefined()
      : _isUndefined = true,
        _value = null as dynamic;

  bool get isUndefined => _isUndefined;
  bool get isDefined => !_isUndefined;
  bool get isNull => !isUndefined && _value == null;

  BaseType get value {
    if (isUndefined) {
      throw StateError(
        'Value is undefined. Check with isUndefined() before trying to get value',
      );
    }
    return _value;
  }

  get valueOrNull {
    if (isUndefined) {
      return null;
    }
    return _value;
  }

  BaseType valueOr(BaseType fallback) {
    if (isUndefined) {
      return fallback;
    }
    return _value;
  }

  BaseType valueOrFn(BaseType Function(BaseType) fn) {
    if (isUndefined) {
      return fn(_value);
    }
    return _value;
  }
}

// Functions just for convenience
Undefinable<BaseType> createUndefined<BaseType>() =>
    Undefinable<BaseType>.undefined();
Undefinable<BaseType> createDefined<BaseType>(BaseType t) =>
    Undefinable<BaseType>.defined(t);

/// [UndefinableExtension] is an extension class that adds methods to [Undefinable<T>].
extension UndefinableExtension on Object {
  /// [toUndefinable] is a method that returns an [Undefinable<T>] with the value of [this].
  Undefinable<T> toUndefinable<T>() => Undefinable<T>.defined(this as T);
}
