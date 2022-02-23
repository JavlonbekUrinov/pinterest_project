import 'package:hive/hive.dart';
import 'package:pinterest_project/models/printerest_model.dart';

class HiveDB {
  static String DB_NAME = "flutter_b14";
  static var box = Hive.box(DB_NAME);

  static void storeUser(User user) async {
    box.put("user", user.toJson());
  }

  static User loadUser() {
    var user = new User.fromJson(box.get('user'));
    return user;
  }

  static void removeUser() async {
    box.delete("user");
  }
}