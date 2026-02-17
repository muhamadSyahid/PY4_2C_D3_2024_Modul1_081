class LoginController {
  final Map<String, String> _validUsers = {"admin": "123", "member": "456"};
  // final String _validUsername = "admin";
  // final String _validPassword = "123";

  bool login(String username, String password) {
    if (_validUsers.containsKey(username) &&
        _validUsers[username] == password) {
      return true;
    } else {
      return false;
    }
  }
}
