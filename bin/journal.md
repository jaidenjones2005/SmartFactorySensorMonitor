# SmartFactory Sensor Monitor Journal

## Phase 1: Sensor Handshake (Futures)

In Phase 1, I created a Dart program that simulates connecting to a factory temperature sensor. I implemented the `fetchSensorMetadata()` function using a Future and added a 2-second delay to represent communication with the sensor.

I used the `await` keyword in the main function to make sure the sensor metadata was retrieved before the initialization message appeared.

Without `await`, the program would receive a Future object instead of the completed sensor information. An uncompleted Future represents a value that will become available later, while the completed value contains the actual sensor ID and location.

This phase helped me understand how asynchronous programming allows Dart to handle delayed operations.