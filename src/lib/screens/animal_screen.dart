
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/animal_cubit.dart';
import 'package:com.example.flutter_cubit_app/widgets/animal_widget.dart';

class AnimalScreen extends StatelessWidget {
	const AnimalScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Animal Screen'),
			),
			body: Center(
				child: BlocBuilder<AnimalCubit, AnimalState>(
					builder: (context, state) {
						return AnimalWidget(
							animal: state.animal,
							onTap: () => context.read<AnimalCubit>().toggleAnimal(),
						);
					},
				),
			),
		);
	}
}
