
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/widgets/animal_widget.dart';

// Mock Cubit
class MockAnimalCubit extends MockCubit<String> implements AnimalCubit {}

void main() {
	group('AnimalWidget', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat text and clock icon when state is Cat', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn('Cat');

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalWidget(),
						),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog text and person icon when state is Dog', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn('Dog');

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalWidget(),
						),
					),
				),
			);

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('toggles animal state when text is tapped', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn('Cat');
			when(() => animalCubit.toggleAnimal()).thenAnswer((_) {});

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalWidget(),
						),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			verify(() => animalCubit.toggleAnimal()).called(1);
		});
	});
}
