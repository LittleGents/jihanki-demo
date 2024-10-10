class_name Jihanki

extends Node2D

signal item_can_be_picked_up(item_node: Node2D, item_name: StringName)

@onready var items_menu: CanvasLayer = $ItemsMenu
@onready var area_2d: Area2D = $Area2D
@onready var item_dispatch_point: Marker2D = $ItemDispatchPoint
@onready var hand_click: Sprite2D = $HandClick

const APPLE = preload("res://objects/Apple.tscn")
const BANANA = preload("res://objects/Banana.tscn")
const CHERRY = preload("res://objects/Cherry.tscn")

var is_interactable: bool = false:
    set(new_value):
        is_interactable = new_value
        hand_click.visible = is_interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


# To be made a global utility function
func instantiate(scene: PackedScene, global_position: Vector2) -> Node2D:
    var instance = scene.instantiate()
    instance.global_position = global_position
    get_tree().get_current_scene().add_child(instance)
    return instance


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if not is_interactable:
        return

    if event.is_pressed():
        items_menu.visible = not items_menu.visible


func _on_items_menu_item_a_dispatched() -> void:
    item_can_be_picked_up.emit(
        instantiate(APPLE, item_dispatch_point.global_position),
        "apple",
    )


func _on_items_menu_item_b_dispatched() -> void:
    item_can_be_picked_up.emit(
        instantiate(BANANA, item_dispatch_point.global_position),
        "banana",
    )


func _on_items_menu_item_c_dispatched() -> void:
    item_can_be_picked_up.emit(
        instantiate(CHERRY, item_dispatch_point.global_position),
        "cherry",
    )
