@tool
extends RefCounted

@export var bool_property: bool = false
@export var string_property: String = "Hello, world!"
@export_multiline var multiline_string_property: String = "Hello, world!"
@export var int_property: int = 777
@export var float_property: float = 3.14
@export_range(-5.0, 5.0, 0.2) var float_range_property: float = 0.0
@export var vector2_property: Vector2 = Vector2.RIGHT
@export var vector3_property: Vector3 = Vector3.RIGHT
@export var vector4_property: Vector4 = Vector4.ONE
@export var transform3d_property: Transform3D

@export var color_property: Color = Color.WHITE
@export var string_name_property: StringName = "some_func"
@export var path_property: NodePath
@export var dictionary_property: Dictionary
@export var array_property: Array

# Typed arrays
@export var byte_array_property: PackedByteArray
@export var int32_array_property: PackedInt32Array
@export var int64_array_property: PackedInt64Array
@export var float32_array_property: PackedFloat32Array
@export var float64_array_property: PackedFloat64Array
@export var string_array_property: PackedStringArray
@export var vec2_array_property: PackedVector2Array
@export var vec3_array_property: PackedVector3Array
@export var color_array_property: PackedColorArray
