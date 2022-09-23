import 'package:req_res_api/req_res_api.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    group('fromJson', () {
      test('returns the correct User object', () {
        expect(
          User.fromJson(<String, dynamic>{
            'id': 1,
            'email': 'petertest@email.com',
            'first_name': 'Peter',
            'last_name': 'Test',
            'avatar': 'avatar',
          }),
          isA<User>()
              .having((u) => u.id, 'id', 1)
              .having((u) => u.email, 'email', 'petertest@email.com')
              .having((u) => u.firstName, 'first_name', 'Peter')
              .having((u) => u.lastName, 'last_name', 'Test')
              .having((u) => u.avatar, 'avatar', 'avatar'),
        );
      });
    });

    group('toJson', () {
      test('returns a json object from a [User] object', () {
        expect(
          const User(
                  id: 1,
                  email: 'petertest@email.com',
                  firstName: 'Peter',
                  lastName: 'Test',
                  avatar: 'avatar')
              .toJson(),
          {
            'id': 1,
            'email': 'petertest@email.com',
            'first_name': 'Peter',
            'last_name': 'Test',
            'avatar': 'avatar',
          },
        );
      });
    });
  });
}
