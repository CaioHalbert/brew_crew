// classe que define os atributos para cadastrar um usuario

class User 
{
  final String uid;

  User({ this.uid });
}

class UserData
{
  final String uid;
  final String name;
  final String sugar;
  final int strength;

  UserData({ this.uid, this.name, this.sugar, this.strength });
}