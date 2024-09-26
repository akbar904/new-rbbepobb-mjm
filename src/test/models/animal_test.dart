
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/models/animal.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should be instantiated with a name', () {
			final animal = Animal(name: 'Cat');
			expect(animal.name, 'Cat');
		});

		test('Animal model name should be a string', () {
			final animal = Animal(name: 'Dog');
			expect(animal.name, isA<String>());
		});
		
		test('Animal model should handle name change', () {
			final animal = Animal(name: 'Cat');
			expect(animal.name, 'Cat');
			animal.name = 'Dog';
			expect(animal.name, 'Dog');
		});
	});
}
