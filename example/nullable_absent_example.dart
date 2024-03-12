import 'package:nullable_absent/nullable_absent.dart';

void main() {
  final data = MyData(id: "id", name: "name");
  print("data: $data");
  final dataWithNewName = data.copyWith(name: NullableAbsent("new_name"));
  print("dataWithNewName: $dataWithNewName");
  final dataWithNullName = data.copyWith(name: NullableAbsent(null));
  print("dataWithNullName: $dataWithNullName");
  final dataWithNewId = data.copyWith(id: "new_id");
  print("dataWithNewId: $dataWithNewId");
}

class MyData {
  final String id;
  final String? name;

  MyData({required this.id, required this.name});

  MyData copyWith({
    String? id,
    NullableAbsent<String> name = const NullableAbsent.absent(),
  }) {
    return MyData(
        id: id ?? this.id, name: NullableAbsent(this.name).apply(name));
  }

  @override
  String toString() {
    return [id, name].toString();
  }
}
