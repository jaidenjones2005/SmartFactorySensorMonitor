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

// Phases 3-5: Controller, error handling, and validation
Future<void> main() async {
  print('=== SmartFactory Sensor Monitor ===');
  print('Connecting to sensor...');

  final stopwatch = Stopwatch()..start();

  String metadata = await fetchSensorMetadata();

  stopwatch.stop();

  print(metadata);
  print('Sensor initialization complete!');

  // Test 1: Handshake delay
  print('\n=== Test 1: Sensor Handshake ===');

  if (stopwatch.elapsedMilliseconds >= 1900) {
    print('PASS: Sensor handshake completed after the delay.');
  } else {
    print('FAIL: Sensor handshake completed too quickly.');
  }

  print('\n=== Live Temperature Readings ===');

  final controller = StreamController<double>();

  int successfulReadings = 0;
  int errorCount = 0;
  int warningCount = 0;

  // Listen for readings and errors
  controller.stream.listen(
        (reading) {
      successfulReadings++;

      if (reading > 35.0) {
        warningCount++;

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
    },
    onError: (error) {
      errorCount++;
      print('ALERT: Pipeline caught an error -> $error');
    },
    onDone: () {
      print('Sensor pipeline closed.');
    },
    cancelOnError: false,
  );

  // Dispatch readings
  int counter = 0;

  await for (double reading in temperatureStream()) {
    counter++;

    if (counter == 4) {
      controller.addError(
        Exception('Sensor Malfunction: Signal Lost'),
      );
    } else {
      controller.add(reading);
    }
  }

  await controller.close();

  // Test 2: Successful readings
  print('\n=== Test 2: Temperature Readings ===');

  if (successfulReadings == 4) {
    print('PASS: Four temperature readings processed.');
  } else {
    print('FAIL: Unexpected reading count.');
  }

  // Test 3: High-temperature warnings
  print('\n=== Test 3: Temperature Warnings ===');

  if (warningCount == 1) {
    print('PASS: High-temperature warning triggered.');
  } else {
    print('FAIL: Incorrect warning count.');
  }

  // Test 4: Error handling
  print('\n=== Test 4: Error Handling ===');

  if (errorCount == 1) {
    print('PASS: Sensor malfunction handled successfully.');
  } else {
    print('FAIL: Error handling test failed.');
  }

  // Test 5: Pipeline completion
  print('\n=== Test 5: Pipeline Completion ===');

  if (controller.isClosed) {
    print('PASS: StreamController closed successfully.');
  } else {
    print('FAIL: StreamController remains open.');
  }

  print('\n=== Phase 5 Complete ===');
}