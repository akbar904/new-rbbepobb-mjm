
class Animal {
	String _name;

	Animal({required String name}) : _name = name;

	String get name => _name;

	set name(String newName) {
		_name = newName;
	}
}
