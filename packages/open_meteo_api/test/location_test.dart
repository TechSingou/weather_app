import 'package:open_meteo_api/open_meteo_api.dart';
import 'package:test/test.dart';

void main() {
  group('Location', () {
    group('fromJson', () {
      test('return correct Location object', () {
        expect(
          Location.fromJson(
            <String, dynamic>{
              'id': 4887398,
              'name': 'Chicago',
              'latitude': 41.85003,
              'longitude': -87.65005,
            },
          ),
          isA<Location>()
              .having((lo) => lo.id, 'id', 4887398)
              .having((lo) => lo.name, 'name', 'Chicago')
              .having((lo) => lo.longitude, 'longitude', -87.65005)
              .having((lo) => lo.latitude, 'latitude', 41.85003),
        );
      });
    });
  });
}
