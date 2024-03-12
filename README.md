Absent value for nullable field

## Features

Simple wrapper class for representing `absent` value. You might need it when you create `copyWith`
method for class that contains nullable field.

## Getting started

### Pubspec

```yaml
dependencies:
  nullable_absent: ^2.0.0
```

## Usage

For class that contains nullable field and you want to have `copyWith` function. 
```dart
class MyData {
  final String id;
  final String? name;
  
  MyData({required this.id, required this.name});
}
```
For non-null field, it is obvious that we can use `String?` for specifying new value for `id`, or
just leave it `null` to use the old value
But for nullable field, we sometimes want to set it to `null`, and we sometimes want to use the old
value. So `String?` is not enough.
```dart
MyData copyWith({String? id}) {
  return MyData(
      id: id ?? this.id, 
      name: name ?? this.name, // What if we want to set name = null
  );
}
```
With `nullable_absent`, we can distinguish between *set to null* or *use old value* like this. 
```dart
MyData copyWith({
    String? id,
    NullableAbsent<String> name = const NullableAbsent.absent(),
}) {
  return MyData(
      id: id ?? this.id, 
      name: NullableAbsent(this.name).apply(name),
  );
}
```
`apply(newValue)` is a convenient method for creating the result value.

## Additional information

You can use `typedef` to make code shorter.
```dart
typedef $<T> = NullableAbsent<T>

// copyWith code
MyData copyWith({
  String? id,
  $<String> name = const $.absent(),
}) {
  return MyData(
      id: id ?? this.id, 
      name: $(this.name).apply(name));
}

// Usage
final dataWithNewName = data.copyWith(name: $("new_name"));
```
