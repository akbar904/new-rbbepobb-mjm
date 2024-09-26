
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/animal_cubit.dart';
import 'screens/animal_screen.dart';

void main() {
	runApp(MainApp());
}

class MainApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: BlocProvider(
				create: (context) => AnimalCubit(),
				child: AnimalScreen(),
			),
		);
	}
}
