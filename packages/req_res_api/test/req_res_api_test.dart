import 'package:mocktail/mocktail.dart';
import 'package:req_res_api/req_res_api.dart';
import 'package:http/http.dart' as http;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('ReqResApiClient', () {
    late http.Client httpClient;
    late ReqResApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = ReqResApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require httpClient to be created', () {
        expect(ReqResApiClient(), isNotNull);
      });
    });

    group('getUsers', () {
      test(
        'makes correct http request',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('{}');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);

          try {
            await apiClient.getUsers();
          } catch (_) {}
          final request = Uri.https(
            'reqres.in',
            '/api/users',
            {'page': '2'},
          );
          verify(
            () => httpClient.get(request),
          ).called(1);
        },
      );

      test(
        'throws UserRequestFailure for non-200 response',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(400);
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          expect(
            () async => apiClient.getUsers(),
            throwsA(isA<UsersRequestFailure>()),
          );
        },
      );

      test(
        'throws UsersNotFound on error response',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('{}');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          expectLater(
            apiClient.getUsers(),
            throwsA(isA<UsersNotFound>()),
          );
        },
      );

      test('throws UserNotFound on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"data": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expectLater(
          apiClient.getUsers(),
          throwsA(isA<UsersNotFound>()),
        );
      });

      test(
        'returns List<User> on valid response',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('''
{
  "data": [
     {      "id": 1,
            "email": "petertest@email.com",
            "first_name": "Peter",
            "last_name": "Test",
            "avatar": "avatar"
          }
  ]
}
''');

          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          final actual = await apiClient.getUsers();
          expect(
            actual[0],
            isA<User>()
                .having((u) => u.id, 'id', 1)
                .having((u) => u.email, 'email', 'petertest@email.com')
                .having((u) => u.firstName, 'first_name', 'Peter')
                .having((u) => u.lastName, 'last_name', 'Test')
                .having((u) => u.avatar, 'avatar', 'avatar'),
          );
        },
      );
    });

    group('login', () {
      const email = "eve.holt@reqres.in";
      const password = "cityslicka";

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.post(
              any(),
              body: {"email": email, "password": password},
            )).thenAnswer((_) async => response);
        try {
          apiClient.login(email: email, password: password);
        } catch (_) {}

        final request = Uri.https('reqres.in', '/api/login');
        final body = {
          "email": email,
          "password": password,
        };
        verify(() => httpClient.post(request, body: body)).called(1);
      });
    });
  });
}
