
import 'package:bloc/bloc.dart';

// AnimalState class representing the state of animal
class AnimalState {
	final String animal;

	AnimalState(this.animal);
}

// AnimalCubit class managing the state of the animal
class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit() : super(AnimalState('Cat'));

	void toggleAnimal() {
		if (state.animal == 'Cat') {
			emit(AnimalState('Dog'));
		} else {
			emit(AnimalState('Cat'));
		}
	}
}
