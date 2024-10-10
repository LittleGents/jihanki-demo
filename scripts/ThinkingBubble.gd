class_name ThinkingBubble

extends Sprite2D

@onready var apple: Sprite2D = $Apple
@onready var banana: Sprite2D = $Banana
@onready var cherry: Sprite2D = $Cherry

var current_item: Sprite2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func set_item(name: StringName) -> void:
    if current_item != null:
        current_item.visible = false

    match name:
        "apple":
            current_item = apple
        "banana":
            current_item = banana
        "cherry":
            current_item = cherry
        _:
            current_item = null

    if current_item != null:
        current_item.visible = true
