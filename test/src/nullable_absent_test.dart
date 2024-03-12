import 'package:nullable_absent/nullable_absent.dart';
import 'package:test/test.dart';

void main() {
  group('replace(oldValue)', () {
    test("Absent value can't replace anything", () {
      expect(const NullableAbsent(1).apply(NullableAbsent.absent()), 1);
      expect(const NullableAbsent("2").apply(NullableAbsent.absent()), "2");
      expect(const NullableAbsent(null).apply(NullableAbsent.absent()), null);
    });

    test("Present value can replace anything", () {
      expect(const NullableAbsent(1).apply(NullableAbsent(2)), 2);
      expect(const NullableAbsent("2").apply(NullableAbsent("1")), "1");
      expect(const NullableAbsent("2").apply(NullableAbsent(null)), null);
    });
  });
}
