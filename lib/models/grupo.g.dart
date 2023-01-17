// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grupo _$GrupoFromJson(Map<String, dynamic> json) => Grupo(
      id: json['id'] as int?,
      nombre: json['nombre'] as String?,
      personas: (json['personas'] as List<dynamic>?)
          ?.map((e) => Persona.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GrupoToJson(Grupo instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'personas': instance.personas.map((e) => e.toJson()).toList(),
    };
