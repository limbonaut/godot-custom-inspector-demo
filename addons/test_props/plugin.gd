@uid("uid://m7ckiagabkyu") # Generated automatically, do not modify.
@tool
extends EditorPlugin

const BottomPanel = preload("res://addons/test_props/bottom_panel.gd")

var bottom_panel: BottomPanel

func _enter_tree() -> void:
	bottom_panel = BottomPanel.new()
	add_control_to_bottom_panel(bottom_panel, "CustomInspector")


func _exit_tree() -> void:
	remove_control_from_bottom_panel(bottom_panel)
	bottom_panel.queue_free()
