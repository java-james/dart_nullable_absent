import 'package:undefinable/undefinable.dart';
import 'package:test/test.dart';

// Top-level Person class for copyWith tests
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

void main() {
  group('Undefinable construction and state', () {
    test('undefined and defined constructors', () {
      final undef = Undefinable<String>.undefined();
      final defined = Undefinable<String>.defined('hello');
      final definedNull = Undefinable<String?>.defined(null);

      expect(undef.isUndefined, isTrue);
      expect(defined.isDefined, isTrue);
      expect(definedNull.isDefined, isTrue);
      expect(definedNull.isNull, isTrue);
    });

    test('value throws if undefined', () {
      final undef = Undefinable<int>.undefined();
      expect(() => undef.value, throwsStateError);
    });
  });

  group('valueOr and valueOrNull', () {
    test('valueOr returns fallback if undefined', () {
      final undef = Undefinable<String>.undefined();
      expect(undef.valueOr('fallback'), 'fallback');
    });

    test('valueOr returns value if defined', () {
      final defined = Undefinable<String>.defined('actual');
      expect(defined.valueOr('fallback'), 'actual');
    });

    test('valueOrNull returns null if undefined', () {
      final undef = Undefinable<int>.undefined();
      expect(undef.valueOrNull, isNull);
    });

    test('valueOrNull returns value if defined', () {
      final defined = Undefinable<int>.defined(42);
      expect(defined.valueOrNull, 42);
    });
  });

  group('valueOrFn', () {
    test('valueOrFn returns fn result if undefined', () {
      final undef = Undefinable<int>.undefined();
      expect(undef.valueOrFn((v) => 99), 99);
    });

    test('valueOrFn returns value if defined', () {
      final defined = Undefinable<int>.defined(7);
      expect(defined.valueOrFn((v) => 99), 7);
    });
  });

  group('Extension toUndefinable', () {
    test('toUndefinable creates defined', () {
      final value = 'abc'.toUndefinable<String>();
      expect(value.isDefined, isTrue);
      expect(value.value, 'abc');
    });
  });

  group('Helper functions', () {
    test('createUndefined and createDefined', () {
      final undef = createUndefined<int>();
      final defined = createDefined<int>(123);
      expect(undef.isUndefined, isTrue);
      expect(defined.isDefined, isTrue);
      expect(defined.value, 123);
    });
  });

  group('copyWith pattern', () {
    test('copyWith does not change fields if undefined', () {
      final p = Person(name: 'Alice', age: 30);
      final updated = p.copyWith();
      expect(updated.name, 'Alice');
      expect(updated.age, 30);
    });

    test('copyWith sets field to null', () {
      final p = Person(name: 'Alice', age: 30);
      final updated = p.copyWith(name: Undefinable<String?>.defined(null));
      expect(updated.name, isNull);
      expect(updated.age, 30);
    });

    test('copyWith sets field to new value', () {
      final p = Person(name: 'Alice', age: 30);
      final updated = p.copyWith(age: Undefinable<int?>.defined(99));
      expect(updated.name, 'Alice');
      expect(updated.age, 99);
    });
  });
}
