@uid("uid://nufhjtqxlv7v") # Generated automatically, do not modify.
@tool
extends Control

const DataObject = preload("res://addons/test_props/data_object.gd")

var prop_vbox: VBoxContainer
var data: DataObject
var map: Dictionary


func _init() -> void:
	custom_minimum_size = Vector2(200.0, 200.0)
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var panel_container := PanelContainer.new()
	add_child(panel_container)
	panel_container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var vbox := VBoxContainer.new()
	panel_container.add_child(vbox)

	var toolbar := HBoxContainer.new()
	vbox.add_child(toolbar)

	var header := Label.new()
	header.text = "Custom Inspector"
	header.theme_type_variation = "HeaderSmall"
	toolbar.add_child(header)

	toolbar.add_spacer(false)

	var dump_data_tool := Button.new()
	toolbar.add_child(dump_data_tool)
	dump_data_tool.text = "Dump Data Object"
	dump_data_tool.pressed.connect(_dump_data_object)

	var refresh_tool := Button.new()
	toolbar.add_child(refresh_tool)
	refresh_tool.text = "Refresh"
	refresh_tool.pressed.connect(_update_inspector)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = SIZE_EXPAND_FILL
	scroll.size_flags_horizontal = SIZE_EXPAND_FILL
	vbox.add_child(scroll)

	prop_vbox = VBoxContainer.new()
	scroll.add_child(prop_vbox)
	prop_vbox.size_flags_horizontal = SIZE_EXPAND_FILL

	# *** Populating properties ***
	data = DataObject.new()  # this is the object we will be editing in our custom inspector
	_update_inspector()


## Recreates all the editors necessary to edit the `data` properties
func _update_inspector() -> void:
	for ed in prop_vbox.get_children():
		ed.queue_free()

	map.clear()

	for prop in data.get_property_list():
		var ed: EditorProperty
		ed = EditorInspector.instantiate_property_editor(data, prop["type"], prop["name"],
				prop["hint"], prop["hint_string"], prop["usage"], false)
		prop_vbox.add_child(ed)
		ed.set_object_and_property(data, prop["name"])
		ed.label = prop["name"]
		ed.property_changed.connect(_prop_changed)
		ed.selected.connect(_prop_selected)
		ed.update_property()
		map[prop["name"]] = ed


## Prints all the properties of the `data` object to the console
func _dump_data_object() -> void:
	print("-----------------------------------------------------------------------------------------------")
	for prop in data.get_property_list():
		prints("Prop:", prop["name"], "Value:", data.get(prop["name"]))
	print("-----------------------------------------------------------------------------------------------")


func _prop_changed(p_property: String, p_value, p_field: StringName, p_changing: bool) -> void:
	data.set(p_property, p_value)


func _prop_selected(p_path:String, p_focusable: int) -> void:
	for ed in prop_vbox.get_children():
		if ed == map[p_path]:
			continue
		if ed.is_selected():
			ed.deselect()
