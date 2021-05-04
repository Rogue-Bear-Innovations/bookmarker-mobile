// Import the test package and Counter class
import '../api.dart';
import 'package:test/test.dart';

void main() {
  test('bookmark test', () {
    final b = Bookmark(id: 1);

    expect(b.id, 1);

    expect(b.description, null);
    b.description = "description";
    expect(b.description, "description");
  });

  test('register', () {
    final api = API();
    return api.register('email@test.com', '111111111111').then((token) {
      print(token);
      expect(token.length > 0, true);
    });
  });
}
