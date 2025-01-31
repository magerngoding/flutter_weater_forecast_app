import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weater_forecast/common/app_session.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreference extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreference mockSharedPreference;
  late AppSession appSession;

  setUp(() {
    mockSharedPreference = MockSharedPreference();
    appSession = AppSession(mockSharedPreference);
  });

  test(
    'should return city name when session is present',
    () async {
      // arrange
      when(() => mockSharedPreference.getString(any())).thenReturn('Zocco');

      // act
      final result = appSession.cityName;

      // assert
      verify(() => mockSharedPreference.getString('cityName'));
      expect(result, 'Zocco');
    },
  );

  test(
    'should return null name when session is not present',
    () async {
      // arrange
      when(() => mockSharedPreference.getString(any())).thenReturn(null);

      // act
      final result = appSession.cityName;

      // assert
      verify(() => mockSharedPreference.getString('cityName'));
      expect(result, null);
    },
  );

  test(
    'should return true when success cache session',
    () async {
      // arrange
      when(() => mockSharedPreference.setString(any(), any())).thenAnswer(
        (_) async => true,
      );

      // act
      final result = await appSession.saveCityName('Zocco');

      // assert
      verify(() => mockSharedPreference.setString('cityName', 'Zocco'));
      expect(result, true);
    },
  );

  test(
    'should return false when failed cache session',
    () async {
      // arrange
      when(() => mockSharedPreference.setString(any(), any())).thenAnswer(
        (_) async => false,
      );

      // act
      final result = await appSession.saveCityName('Zocco');

      // assert
      verify(() => mockSharedPreference.setString('cityName', 'Zocco'));
      expect(result, false);
    },
  );
}
