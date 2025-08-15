# Undefinable

A Dart library for representing values that can be explicitly "undefined" or "defined" (including null). This is especially useful for APIs like `copyWith`, where you need to distinguish between "do not change this field" and "set this field to null or a new value".

## Motivation

In Dart, optional parameters default to `null`, which makes it impossible to distinguish between "no change" and "set to null" in patterns like `copyWith`. `Undefinable<T>` solves this by providing an explicit undefined state.

## Features

- Explicitly represent undefined and defined values
- Convenient API for checking state and extracting values
- Extension for easy conversion
- Helper functions for construction

## Usage

### Basic Usage

```dart
import 'package:undefinable/undefinable.dart';

void main() {
  final undef = Undefinable<String>.undefined();
  final defined = Undefinable<String>.defined('Hello');
  final definedNull = Undefinable<String?>.defined(null);

  print(undef.isUndefined); // true
  print(defined.isDefined); // true
  print(defined.value); // Hello
  print(definedNull.isDefined); // true
  print(definedNull.value); // null
}
```

### Using with copyWith

```dart
class Person {
  final String? name;
  final int? age;

  Person({this.name, this.age});

  Person copyWith({
    Undefinable<String?> name = const Undefinable.undefined(),
    Undefinable<int?> age = const Undefinable.undefined(),
  }) {
    return Person(
      name: name.isUndefined ? this.name : name.value,
      age: age.isUndefined ? this.age : age.value,
    );
  }
}

final person = Person(name: 'Alice', age: 30);

final updated = person.copyWith(
  name: Undefinable<String?>.defined(null), // set name to null
  age: Undefinable<int?>.undefined(), // don't change age
);

print(updated.name); // null
print(updated.age); // 30
```

### Extension Usage

```dart
final value = 'Hello'.toUndefinable<String>();
print(value.isDefined); // true
print(value.value); // Hello
```

### Helper Functions

```dart
final undef = createUndefined<int>();
final defined = createDefined<int>(42);
```

## API Reference

### Undefinable<T>

- `Undefinable.defined(T value)` – create a defined value (can be null)
- `Undefinable.undefined()` – create an undefined value
- `isUndefined` – true if value is undefined
- `isDefined` – true if value is defined
- `isNull` – true if value is defined and null
- `value` – get the value (throws if undefined)
- `valueOrNull` – get the value or null if undefined
- `valueOr(fallback)` – get the value or fallback if undefined
- `valueOrFn(fn)` – get the value or result of fn if undefined

### Extensions

- `toUndefinable<T>()` – convert any object to Undefinable<T>

### Helper Functions

- `createUndefined<T>()` – create an undefined value
- `createDefined<T>(T value)` – create a defined value