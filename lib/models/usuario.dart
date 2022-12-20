class Usuario {
  String uid;
  String name;
  String email;
  String? password;
  String rol;

  Usuario({
    required this.uid,
    required this.name,
    required this.email,
    this.password,
    required this.rol,
  });

  Usuario copyWith(
          {String? uid,
          String? name,
          String? email,
          String? password,
          String? rol}) =>
      Usuario(
          uid: uid ?? this.uid,
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          rol: rol ?? this.rol);
}
