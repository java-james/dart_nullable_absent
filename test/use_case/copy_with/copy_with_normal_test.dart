import 'package:nullable_absent/nullable_absent.dart';
import 'package:test/test.dart';

void main() {
  group('Normal class: copyWith', () {
    test('Create new instance', () {
      const data = Normal(intValue: 0, stringValue: "text");
      final copied = data.copyWith();
      expect(copied, data);
      expect(identical(data, copied), false);
    });

    group('Update with absent value', () {
      test('previous=0', () {
        const data = Normal(intValue: 0, stringValue: "text");
        final copied = data.copyWith(stringValue: "new_text");
        expect(copied, const Normal(intValue: 0, stringValue: "new_text"));
      });
      test('previous=null', () {
        const data = Normal(stringValue: "text");
        final copied = data.copyWith(stringValue: "new_text");
        expect(copied, const Normal(stringValue: "new_text"));
      });
    });

    group('Update with present value', () {
      test('previous=0', () {
        const data = Normal(intValue: 0, stringValue: "text");
        final copied = data.copyWith(intValue: NullableAbsent(1));
        expect(copied, const Normal(intValue: 1, stringValue: "text"));
      });
      test('previous=null', () {
        const data = Normal(stringValue: "text");
        final copied = data.copyWith(intValue: NullableAbsent(1));
        expect(copied, const Normal(intValue: 1, stringValue: "text"));
      });
    });
  });
}

class Normal {
  final int? intValue;
  final String stringValue;

  const Normal({this.intValue, required this.stringValue});

  Normal copyWith({
    NullableAbsent<int> intValue = const NullableAbsent.absent(),
    String? stringValue,
  }) {
    return Normal(
        intValue: NullableAbsent(this.intValue).apply(intValue),
        stringValue: stringValue ?? this.stringValue);
  }

  @override
  bool operator ==(Object other) =>
      other is Normal &&
      runtimeType == other.runtimeType &&
      intValue == other.intValue &&
      stringValue == other.stringValue;

  @override
  int get hashCode => "$intValue::$stringValue".hashCode;

  @override
  String toString() {
    return "[ int: $intValue, string: $stringValue ]";
  }
}
