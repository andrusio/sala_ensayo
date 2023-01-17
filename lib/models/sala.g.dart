// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sala.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sala _$SalaFromJson(Map<String, dynamic> json) => Sala(
      id: json['id'] as int?,
      nombre: json['nombre'] as String?,
      precioHora: (json['precioHora'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SalaToJson(Sala instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'precioHora': instance.precioHora,
    };
