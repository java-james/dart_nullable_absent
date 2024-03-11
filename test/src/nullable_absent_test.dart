import 'package:nullable_absent/nullable_absent.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test("Absent value can't replace anything", () {
      expect(const NullableAbsent.absent().replace(oldValue: 1), 1);
      expect(const NullableAbsent.absent().replace(oldValue: "1"), "1");
      expect(const NullableAbsent.absent().replace(oldValue: null), null);
    });

    test("Present value can replace anything", () {
      expect(const NullableAbsent(2).replace(oldValue: 1), 2);
      expect(const NullableAbsent("2").replace(oldValue: "1"), "2");
      const String? text = null;
      expect(const NullableAbsent(text).replace(oldValue: "2"), null);
    });
  });
}
