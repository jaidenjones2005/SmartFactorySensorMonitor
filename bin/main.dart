Future<String> fetchSensorMetadata() async {
  await Future.delayed(const Duration(seconds: 2));

  return 'Sensor ID: 402 | Location: Warehouse-A';
}

Future<void> main() async {
  print('=== SmartFactory Sensor Monitor ===');

  print('Connecting to sensor...');

  String metadata = await fetchSensorMetadata();

  print(metadata);

  print('Sensor initialization complete!');
}