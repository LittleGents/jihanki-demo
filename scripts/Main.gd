extends Node2D

const SoldierScene = preload("res://objects/Soldier.tscn")

@onready var jihanki: Jihanki = $Jihanki
@onready var soldier_wait: Marker2D = $SoldierWait
@onready var soldier_exit: Marker2D = $SoldierExit
@onready var soldier_spawn: Marker2D = $SoldierSpawn

var soldier: Soldier

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    start_round()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func start_round() -> void:
    soldier = SoldierScene.instantiate()
    soldier.global_position = soldier_spawn.global_position
    add_child.call_deferred(soldier)
    soldier.tree_exited.connect(start_round.call_deferred)

    soldier.ready_to_pick_up.connect(func(): jihanki.is_interactable = true)
    soldier.go_to_position.call_deferred(soldier_wait.global_position)


func _on_jihanki_item_can_be_picked_up(item_node: Node2D, item_name: StringName) -> void:
    jihanki.is_interactable = false
    soldier.pick_up_and_leave(item_node, item_name, soldier_exit.global_position)
