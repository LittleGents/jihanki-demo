class_name Soldier

extends Node2D

signal ready_to_pick_up

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var item_holding_position: Marker2D = $ItemHoldingPosition
@onready var thinking_bubble: ThinkingBubble = $ThinkingBubble
@onready var happy_thinking_bubble: Sprite2D = $HappyThinkingBubble
@onready var sad_thinking_bubble: Sprite2D = $SadThinkingBubble

@onready var target_item_name: StringName = ["apple", "banana", "cherry"].pick_random()

var tween: Tween = null

var WALK_SPEED: float = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func stop_and_reset_animation() -> void:
    animated_sprite_2d.pause()
    animated_sprite_2d.frame = 0


func evaluate_walk_time(from: Vector2, to: Vector2) -> float:
    return from.distance_to(to) / WALK_SPEED


func go_to_position(destination: Vector2) -> void:
    animated_sprite_2d.play("walk")

    if tween != null and tween.is_running():
        tween.stop()

    tween = get_tree().create_tween()
    tween.tween_property(self, "global_position", destination, evaluate_walk_time(self.global_position, destination))
    tween.tween_callback(self.stop_and_reset_animation)
    tween.tween_callback(func():
        thinking_bubble.set_item(target_item_name)
        thinking_bubble.visible = true
    )
    tween.tween_callback(ready_to_pick_up.emit)


func pick_up_and_leave(item: Node2D, item_name: StringName, exit_destination: Vector2) -> void:
    thinking_bubble.visible = false

    animated_sprite_2d.play("walk")

    if tween != null and tween.is_running():
        tween.stop()

    tween = get_tree().create_tween()
    tween.tween_property(self, "global_position", item.global_position, evaluate_walk_time(self.global_position, item.global_position))
    tween.tween_callback(self.stop_and_reset_animation)
    tween.tween_callback(func():
        item.global_position = item_holding_position.global_position
    )
    tween.tween_callback(func():
        item.reparent(self)
        animated_sprite_2d.play("walk")
    ).set_delay(1)
    tween.tween_callback(func():
        if item_name == target_item_name:
            happy_thinking_bubble.visible = true
        else:
            sad_thinking_bubble.visible = true
    )
    tween.tween_property(self, "global_position", exit_destination, evaluate_walk_time(item.global_position, exit_destination))
    tween.tween_callback(self.queue_free).set_delay(1)
