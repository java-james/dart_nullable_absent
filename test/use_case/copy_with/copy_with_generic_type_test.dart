import 'package:nullable_absent/nullable_absent.dart';
import 'package:test/test.dart';

void main() {
  group('Class contains generic types: copyWith', () {
    test('Create new instance', () {
      const data = G<int, String>(t1: 0, t2: "text");
      final copied = data.copyWith();
      expect(copied, data);
      expect(identical(data, copied), false);
    });

    group('Update with absent value', () {
      test('previous=0', () {
        const data = G<int, String>(t1: 0, t2: "text");
        final copied = data.copyWith(t2: "new_text");
        expect(copied, const G<int, String>(t1: 0, t2: "new_text"));
      });
      test('previous=null', () {
        const data = G<int, String>(t2: "text");
        final copied = data.copyWith(t2: "new_text");
        expect(copied, const G<int, String>(t2: "new_text"));
      });
    });

    group('Update with present value', () {
      test('previous=0', () {
        const data = G<int, String>(t1: 0, t2: "text");
        final copied = data.copyWith(t1: NullableAbsent(1));
        expect(copied, const G<int, String>(t1: 1, t2: "text"));
      });
      test('previous=null', () {
        const data = G<int, String>(t2: "text");
        final copied = data.copyWith(t1: NullableAbsent(1));
        expect(copied, const G<int, String>(t1: 1, t2: "text"));
      });
    });
  });
}

class G<T1 extends Object, T2 extends Object> {
  final T1? t1;
  final T2 t2;

  const G({this.t1, required this.t2});

  G<T1, T2> copyWith({
    NullableAbsent<T1> t1 = const NullableAbsent.absent(),
    T2? t2,
  }) {
    return G<T1, T2>(t1: NullableAbsent(this.t1).apply(t1), t2: t2 ?? this.t2);
  }

  @override
  bool operator ==(Object other) =>
      other is G<T1, T2> &&
      runtimeType == other.runtimeType &&
      t1 == other.t1 &&
      t2 == other.t2;

  @override
  int get hashCode => "$t1::$t2".hashCode;

  @override
  String toString() {
    return "[ t1: $t1, t2: $t2 ]";
  }
}
