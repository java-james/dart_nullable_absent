import 'package:undefinable/undefinable.dart';

void main() {
  final data = MyData(id: "id", name: "name");
  print("data: $data");
  final dataWithNewName = data.copyWith(name: Undefinable("new_name"));
  print("dataWithNewName: $dataWithNewName");
  final dataWithNullName = data.copyWith(name: Undefinable(null));
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
    Undefinable<String?> name = const Undefinable.undefined(),
  }) {
    return MyData(
        id: id ?? this.id, name: name.valueOr(this.name));
  }

  @override
  String toString() {
    return [id, name].toString();
  }
}
