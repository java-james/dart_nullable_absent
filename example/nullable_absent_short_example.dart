import 'package:nullable_absent/nullable_absent.dart';

void main() {
  final data = MyData(id: "id", name: "name");
  print("data: $data");
  final dataWithNewName = data.copyWith(name: $("new_name"));
  print("dataWithNewName: $dataWithNewName");

  final dataWithNullName = data.copyWith(name: $<String>(null));
  print("dataWithNullName: $dataWithNullName");

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
    return MyData(id: id ?? this.id, name: $(this.name).apply(name));
  }

  @override
  String toString() {
    return [id, name].toString();
  }
}
