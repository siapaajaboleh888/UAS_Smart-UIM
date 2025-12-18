import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // Storage keys
  static const String _keyCurrentUser = 'current_user';
  static const String _keyRegisteredUsers = 'registered_users';

  // Current logged in user
  UserModel? _currentUser;
  final List<UserModel> _registeredUsers = [];
  bool _isInitialized = false;

  UserModel? get currentUser => _currentUser;
  List<UserModel> get registeredUsers => List.unmodifiable(_registeredUsers);

  // Public initialize method - MUST be called on app start
  Future<void> initialize() async {
    if (_isInitialized) return;
    print('🚀 Initializing UserService...');
    await _loadData();
    await _initializeDefaultUsers();
    _isInitialized = true;
    print('✅ UserService initialized with ${_registeredUsers.length} users');
  }

  // Initialize and load data (private)
  Future<void> _initialize() async {
    if (_isInitialized) return;
    await initialize();  // Call public method
  }

  // Initialize default users if needed
  Future<void> _initializeDefaultUsers() async {
    // Add default user if no users exist
    if (_registeredUsers.isEmpty) {
      final defaultUser = UserModel.withPassword(
        nim: '2022020100078',
        nama: 'MOH. SYAIFUL ANAM',
        email: 'syaifulanam@uim.ac.id',
        phone: '082334455667',
        prodi: 'Teknik Informatika',
        angkatan: '2022',
        password: 'anam1234', // Default password
        role: 'MAHASISWA',
      );
      _registeredUsers.add(defaultUser);
      await _saveData();
      print('✅ Initialized default user: ${defaultUser.nama}');
      print('   Email: ${defaultUser.email}');
      print('   Password: anam1234');
    }
  }

  // Load data from SharedPreferences
  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load registered users FIRST
      final registeredUsersJson = prefs.getString(_keyRegisteredUsers);
      if (registeredUsersJson != null) {
        final List<dynamic> usersList = jsonDecode(registeredUsersJson);
        _registeredUsers.clear();
        _registeredUsers.addAll(
          usersList.map((json) => UserModel.fromMap(json)).toList(),
        );
        print('✅ Loaded ${_registeredUsers.length} registered users');
        for (var user in _registeredUsers) {
          print('   - ${user.nama} (${user.nim})');
        }
      }
      
      // Load current user
      final currentUserJson = prefs.getString(_keyCurrentUser);
      if (currentUserJson != null) {
        _currentUser = UserModel.fromMap(jsonDecode(currentUserJson));
        print('✅ Loaded current user: ${_currentUser?.nama}');
      }
    } catch (e) {
      print('❌ Error loading user data: $e');
    }
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Save current user
      if (_currentUser != null) {
        await prefs.setString(
          _keyCurrentUser,
          jsonEncode(_currentUser!.toMap()),
        );
        print('✅ Saved current user: ${_currentUser!.nama}');
      } else {
        await prefs.remove(_keyCurrentUser);
      }
      
      // Save registered users
      final usersJson = _registeredUsers.map((user) => user.toMap()).toList();
      await prefs.setString(
        _keyRegisteredUsers,
        jsonEncode(usersJson),
      );
      print('✅ Saved ${_registeredUsers.length} registered users');
    } catch (e) {
      print('❌ Error saving user data: $e');
    }
  }

  // Register new user
  Future<bool> registerUser(UserModel user) async {
    try {
      // Initialize if needed
      await _initialize();
      
      // Check if NIM already exists
      final exists = _registeredUsers.any((u) => u.nim == user.nim);
      if (exists) {
        print('❌ User with NIM ${user.nim} already exists');
        return false;
      }

      // Check if email already exists
      final emailExists = _registeredUsers.any((u) => u.email == user.email);
      if (emailExists) {
        print('❌ User with email ${user.email} already exists');
        return false;
      }

      // Add user to registered users
      _registeredUsers.add(user);
      print('✅ Registered new user: ${user.nama} (${user.nim})');
      
      // Save to persistent storage
      await _saveData();
      
      return true;
    } catch (e) {
      print('❌ Error registering user: $e');
      return false;
    }
  }

  // Login user
  Future<UserModel?> login(String emailOrNim, String password) async {
    try {
      // ALWAYS reload data to get latest
      print('🔄 Reloading user data...');
      await _loadData();
      
      print('🔍 Looking for user with: $emailOrNim');
      print('📊 Total registered users: ${_registeredUsers.length}');
      
      // Try to find user by email or NIM
      UserModel? user;
      
      try {
        user = _registeredUsers.firstWhere(
          (u) {
            final matches = u.email.toLowerCase() == emailOrNim.toLowerCase() || 
                          u.nim == emailOrNim;
            if (matches) {
              print('✅ Found matching user: ${u.nama} (${u.nim})');
            }
            return matches;
          },
        );
      } catch (e) {
        print('❌ User not found in registered users');
        print('💡 Available users:');
        for (var u in _registeredUsers) {
          print('   - ${u.email} | ${u.nim}');
        }
        // User not found - return null (login failed)
        return null;
      }

      // User found - now verify password
      print('🔐 Verifying password...');
      if (!user.verifyPassword(password)) {
        print('❌ Invalid password');
        return null;
      }

      // Password correct - set as current user
      _currentUser = user;
      await _saveData();
      
      print('✅ Login successful: ${user.nama}');
      return user;
    } catch (e) {
      print('❌ Error during login: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    _currentUser = null;
    await _saveData();
    print('✅ Logged out');
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

  // Clear all data (for testing)
  Future<void> clearAllData() async {
    _currentUser = null;
    _registeredUsers.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCurrentUser);
    await prefs.remove(_keyRegisteredUsers);
    print('✅ All data cleared');
  }

  // Get total registered users count
  int get totalUsers => _registeredUsers.length;
  
  // Update user photo
  Future<bool> updateUserPhoto(String photoPath) async {
    try {
      if (_currentUser == null) return false;
      
      // Create a new user instance with updated photo
      final updatedUser = UserModel(
        nim: _currentUser!.nim,
        nama: _currentUser!.nama,
        email: _currentUser!.email,
        phone: _currentUser!.phone,
        prodi: _currentUser!.prodi,
        angkatan: _currentUser!.angkatan,
        role: _currentUser!.role,
        passwordHash: _currentUser!.passwordHash,
        photoPath: photoPath,
      );
      
      // Update current user
      _currentUser = updatedUser;
      
      // Update in registered users list
      final index = _registeredUsers.indexWhere((u) => u.nim == _currentUser!.nim);
      if (index != -1) {
        _registeredUsers[index] = updatedUser;
      }
      
      // Save changes
      await _saveData();
      print('✅ Updated user photo: $photoPath');
      
      return true;
    } catch (e) {
      print('❌ Error updating user photo: $e');
      return false;
    }
  }
  
  // Debug: Print all users
  void printAllUsers() {
    print('📋 All registered users (${_registeredUsers.length}):');
    for (var user in _registeredUsers) {
      print('   - ${user.nama} | ${user.email} | ${user.nim}');
    }
  }
}
