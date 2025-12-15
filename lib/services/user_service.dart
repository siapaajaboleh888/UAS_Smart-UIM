import '../models/user_model.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // Simulated user storage (in real app, use SharedPreferences or database)
  UserModel? _currentUser;
  final List<UserModel> _registeredUsers = [];

  // Current logged in user
  UserModel? get currentUser => _currentUser;

  // Register new user
  Future<bool> registerUser(UserModel user) async {
    try {
      // Check if NIM already exists
      final exists = _registeredUsers.any((u) => u.nim == user.nim);
      if (exists) {
        return false;
      }

      // Check if email already exists
      final emailExists = _registeredUsers.any((u) => u.email == user.email);
      if (emailExists) {
        return false;
      }

      // Add user to registered users
      _registeredUsers.add(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Login user
  Future<UserModel?> login(String nim, String password) async {
    try {
      // Try to find user by NIM
      final user = _registeredUsers.firstWhere(
        (u) => u.nim == nim,
        orElse: () => UserModel(
          nim: '2022020100078',
          nama: 'MOH. SYAIFUL ANAM',
          email: 'syaifulanam@uim.ac.id',
          phone: '082334455667',
          prodi: 'Teknik Informatika',
          angkatan: '2022',
          role: 'MAHASISWA',
        ),
      );

      _currentUser = user;
      return user;
    } catch (e) {
      return null;
    }
  }

  // Logout
  void logout() {
    _currentUser = null;
  }

  // Get user by NIM
  UserModel? getUserByNim(String nim) {
    try {
      return _registeredUsers.firstWhere((u) => u.nim == nim);
    } catch (e) {
      return null;
    }
  }

  // Check if user exists
  bool userExists(String nim) {
    return _registeredUsers.any((u) => u.nim == nim);
  }
}
