extends CanvasLayer

signal item_a_dispatched
signal item_b_dispatched
signal item_c_dispatched

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func close_menu() -> void:
    visible = false


func _on_item_a_item_dispatched() -> void:
    item_a_dispatched.emit()
    close_menu()


func _on_item_b_item_dispatched() -> void:
    item_b_dispatched.emit()
    close_menu()


func _on_item_c_item_dispatched() -> void:
    item_c_dispatched.emit()
    close_menu()
