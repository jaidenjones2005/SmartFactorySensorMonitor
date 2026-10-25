import 'dart:async';

// Phase 1: Sensor handshake
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

// Phase 3: Central dispatcher
Future<void> main() async {
  print('=== SmartFactory Sensor Monitor ===');

  print('Connecting to sensor...');

  String metadata = await fetchSensorMetadata();

  print(metadata);
  print('Sensor initialization complete!');

  print('\n=== Live Temperature Readings ===');

  // Create central StreamController
  final controller = StreamController<double>();

  // Listen for temperature readings
  controller.stream.listen((reading) {
    if (reading > 35.0) {
      double fahrenheit = reading * 1.8 + 32;

      print(
        'WARNING: High Temperature! '
            '${reading.toStringAsFixed(1)}°C / '
            '${fahrenheit.toStringAsFixed(1)}°F',
      );
    } else {
      print(
        'Normal Temperature: ${reading.toStringAsFixed(1)}°C',
      );
    }
  });

  // Dispatch readings through controller
  await for (double reading in temperatureStream()) {
    controller.add(reading);
  }

  // Close controller after all readings
  await controller.close();

  print('\nTemperature monitoring complete!');
}