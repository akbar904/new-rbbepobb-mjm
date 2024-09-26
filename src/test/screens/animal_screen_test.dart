
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/screens/animal_screen.dart';
import 'package:com.example.flutter_cubit_app/cubits/animal_cubit.dart';
import 'package:com.example.flutter_cubit_app/widgets/animal_widget.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalScreen', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('should display initial animal state as Cat with clock icon', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState('Cat'));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('should display Dog with person icon when state is Dog', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState('Dog'));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalScreen(),
					),
				),
			);

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('should toggle animal on text tap', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState('Cat'));
			when(() => animalCubit.toggleAnimal()).thenAnswer((_) {
				animalCubit.emit(AnimalState('Dog'));
			});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalScreen(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			verify(() => animalCubit.toggleAnimal()).called(1);
		});
	});
}
