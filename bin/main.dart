Future<String> fetchSensorMetadata() async {
  await Future.delayed(const Duration(seconds: 2));

  return 'Sensor ID: 402 | Location: Warehouse-A';
}

// Phase 2: Generate temperature readings
Stream<double> temperatureStream() async* {
  List<double> temperatures = [22.5, 28.0, 36.5, 40.0, 25.0];

  for (double temperature in temperatures) {
    await Future.delayed(const Duration(seconds: 1));

    yield temperature;
  }
}

Future<void> main() async {
  print('=== SmartFactory Sensor Monitor ===');

  print('Connecting to sensor...');

  String metadata = await fetchSensorMetadata();

  print(metadata);
  print('Sensor initialization complete!');

  print('\n=== Live Temperature Readings ===');

  await for (double reading in temperatureStream()) {
    if (reading > 35.0) {
      double fahrenheit = reading * 1.8 + 32;

      print(
        'WARNING: High Temperature! '
            '${reading.toStringAsFixed(1)}°C / '
            '${fahrenheit.toStringAsFixed(1)}°F',
      );
    } else {
      print('Normal Temperature: ${reading.toStringAsFixed(1)}°C');
    }
  }

  print('\nTemperature monitoring complete!');
}