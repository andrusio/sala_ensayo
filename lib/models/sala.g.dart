// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sala.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sala _$SalaFromJson(Map<String, dynamic> json) => Sala(
      id: json['id'] as int?,
      nombre: json['nombre'] as String?,
      precio: (json['precio'] as num?)?.toDouble(),
      color: Color(json['color'] as int).withOpacity(1),
    );

Map<String, dynamic> _$SalaToJson(Sala instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'precio': instance.precio,
      'color': instance.color,
    };
