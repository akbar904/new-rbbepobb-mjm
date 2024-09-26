
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/animal_cubit.dart';

class AnimalWidget extends StatelessWidget {
	const AnimalWidget({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AnimalCubit, String>(
			builder: (context, state) {
				String displayText;
				IconData displayIcon;

				if (state == 'Cat') {
					displayText = 'Cat';
					displayIcon = Icons.access_time;
				} else {
					displayText = 'Dog';
					displayIcon = Icons.person;
				}

				return GestureDetector(
					onTap: () => context.read<AnimalCubit>().toggleAnimal(),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(displayText),
							SizedBox(width: 8),
							Icon(displayIcon),
						],
					),
				);
			},
		);
	}
}
