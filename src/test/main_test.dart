
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/main.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('MainApp', () {
		testWidgets('displays AnimalScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MainApp());
			expect(find.byType(AnimalScreen), findsOneWidget);
		});
	});

	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(animal: "Dog")] when toggleAnimal is called',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState(animal: 'Dog')],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(animal: "Cat")] when toggleAnimal is called again',
			build: () => animalCubit,
			setUp: () {
				whenListen(animalCubit, Stream.fromIterable([AnimalState(animal: 'Dog')]));
			},
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState(animal: 'Cat')],
		);
	});

	group('AnimalScreen', () {
		testWidgets('displays AnimalWidget', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: AnimalScreen()));
			expect(find.byType(AnimalWidget), findsOneWidget);
		});
	});

	group('AnimalWidget', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState(animal: 'Cat'));
			await tester.pumpWidget(
				BlocProvider<AnimalCubit>(
					create: (_) => animalCubit,
					child: MaterialApp(home: AnimalWidget()),
				),
			);
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon when toggled', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState(animal: 'Dog'));
			await tester.pumpWidget(
				BlocProvider<AnimalCubit>(
					create: (_) => animalCubit,
					child: MaterialApp(home: AnimalWidget()),
				),
			);
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('toggles animal text and icon on tap', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState(animal: 'Cat'));
			when(() => animalCubit.toggleAnimal()).thenAnswer((_) async {
				when(() => animalCubit.state).thenReturn(AnimalState(animal: 'Dog'));
			});
			await tester.pumpWidget(
				BlocProvider<AnimalCubit>(
					create: (_) => animalCubit,
					child: MaterialApp(home: AnimalWidget()),
				),
			);
			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
