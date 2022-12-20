class Usuario {
  String uid;
  String name;
  String email;
  String? password;
  String estado;
  String rol;

  Usuario({
    required this.uid,
    required this.name,
    required this.email,
    this.password,
    required this.estado,
    required this.rol,
  });

  Usuario copyWith(
          {String? uid,
          String? name,
          String? email,
          String? password,
          String? estado,
          String? rol}) =>
      Usuario(
          uid: uid ?? this.uid,
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          estado: estado ?? this.estado,
          rol: rol ?? this.rol);
}
