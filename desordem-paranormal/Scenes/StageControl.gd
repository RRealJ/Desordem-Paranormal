extends Node2D


@onready var player: CharacterBody2D = get_tree().get_nodes_in_group("Player")[0]


func _ready() -> void:
	$enemy_test.TARGET = player
