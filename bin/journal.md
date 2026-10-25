# SmartFactory Sensor Monitor Journal

## Phase 1: Sensor Handshake (Futures)

In Phase 1, I created a Dart program that simulates connecting to a factory temperature sensor. I implemented the `fetchSensorMetadata()` function using a Future and added a 2-second delay to represent communication with the sensor.

I used the `await` keyword in the main function to make sure the sensor metadata was retrieved before the initialization message appeared.

Without `await`, the program would receive a Future object instead of the completed sensor information. An uncompleted Future represents a value that will become available later, while the completed value contains the actual sensor ID and location.

This phase helped me understand how asynchronous programming allows Dart to handle delayed operations.

## Phase 2: Live Temperature Stream (Async Generators)

In Phase 2, I created a temperatureStream() function using async* to generate five simulated temperature readings with a one-second delay between each reading.

I used an await for loop in main() to process the readings as they arrived. Temperatures above 35.0°C triggered a warning and were converted to Fahrenheit.

The yield keyword differs from return because yield sends multiple values over time through a Stream, while return completes a Future with a single result.

This phase demonstrated how asynchronous streams can process continuous sensor readings without waiting for all the data to become available at once.

