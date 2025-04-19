extends CharacterBody2D

@export var stats: CPUStats : set = set_stats

@onready var sprite_2d: Sprite2D = $Sprite2D


func set_stats(value: CPUStats) -> void:
	stats = value

	if value == null:
		return

	if not is_node_ready():
		await ready

	sprite_2d.region_rect.position = Vector2(stats.skin_coordinates) * Main.CPU_SPRITE_SIZE
