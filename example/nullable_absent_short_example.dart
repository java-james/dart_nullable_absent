import 'package:nullable_absent/nullable_absent.dart';

void main() {
  final data = MyData(id: "id", name: "name");
  print("data: $data");
  final dataWithNewName = data.copyWith(name: $("new_name"));
  print("dataWithNewName: $dataWithNewName");

  //TODO: Don't know why explicit type is needed here
  final dataWithNullName = data.copyWith(name: $<String>(null));
  print("dataWithNullName: $dataWithNullName");

  // If using original class name, explicit type is not needed
  final dataWithNullNameLong = data.copyWith(name: NullableAbsent(null));
  print("dataWithNullNameLong: $dataWithNullNameLong");

  final dataWithNewId = data.copyWith(id: "new_id");
  print("dataWithNewId: $dataWithNewId");
}

typedef $<T> = NullableAbsent<T>;

class MyData {
  final String id;
  final String? name;

  MyData({required this.id, required this.name});

  MyData copyWith({
    String? id,
    $<String> name = const $.absent(),
  }) {
    return MyData(
        id: id ?? this.id,
        name: name.replace(oldValue: this.name));
  }

  @override
  String toString() {
    return [id, name].toString();
  }
}
