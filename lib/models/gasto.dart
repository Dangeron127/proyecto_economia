class Gasto {
  final int? id;
  final String nombre;
  final double monto;
  final String categoria;
  final DateTime fecha;

  Gasto({this.id, required this.nombre, required this.monto, required this.categoria, required this.fecha});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'monto': monto,
      'categoria': categoria,
      'fecha': fecha.millisecondsSinceEpoch,
    };
  }

  factory Gasto.fromMap(Map<String, dynamic> map) {
    return Gasto(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      monto: map['monto'] as double,
      categoria: map['categoria'] as String,
      fecha: DateTime.fromMillisecondsSinceEpoch(map['fecha'] as int),
    );
  }
}