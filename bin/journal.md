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

## Phase 3: Central Dispatcher (StreamController)

In Phase 3, I modified the SmartFactory Sensor Monitor to use a StreamController as a central dispatcher for temperature readings.

Instead of processing the readings directly inside the await for loop, I now send each reading into the controller using controller.add(). The controller's stream listener processes the readings and displays normal temperatures or high-temperature warnings.

A StreamController provides more control over how events are added and distributed compared to a direct async generator. It allows the program to manage incoming data through a central pipeline.

Registering the listener before dispatching readings is important because it ensures the program is ready to receive and process events as they arrive.

I also closed the controller after all readings were dispatched to release resources and allow the program to finish cleanly.

## Phase 4: Fault Tolerance (Error Handling)

In Phase 4, I added error handling to the SmartFactory Sensor Monitor by simulating a sensor malfunction during the fourth temperature reading.

I used controller.addError() to send an error event through the stream instead of a normal temperature reading.

The onError callback caught the malfunction and displayed an alert message without crashing the program. The stream continued processing the remaining readings because cancelOnError was set to false.

A try-catch block is generally used to catch exceptions thrown during synchronous execution or within awaited asynchronous operations. In comparison, the onError callback handles error events delivered asynchronously through a stream subscription.

I also added an onDone callback to confirm that the stream closed successfully after all readings were processed.

