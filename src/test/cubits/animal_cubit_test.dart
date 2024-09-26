
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/cubits/animal_cubit.dart';

// Mock dependencies if any, but only those directly used within lib/cubits/animal_cubit.dart
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is AnimalState with animal as Cat', () {
			expect(animalCubit.state.animal, 'Cat');
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState with animal as Dog] when toggleAnimal is called while state is Cat',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [isA<AnimalState>().having((state) => state.animal, 'animal', 'Dog')],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState with animal as Cat] when toggleAnimal is called while state is Dog',
			build: () => animalCubit,
			act: (cubit) {
				cubit.toggleAnimal(); // First toggle to Dog
				cubit.toggleAnimal(); // Second toggle back to Cat
			},
			expect: () => [
				isA<AnimalState>().having((state) => state.animal, 'animal', 'Dog'),
				isA<AnimalState>().having((state) => state.animal, 'animal', 'Cat'),
			],
		);
	});
}
