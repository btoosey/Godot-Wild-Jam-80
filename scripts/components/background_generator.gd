extends Node2D

@export var fnl = FastNoiseLite.new()
@export var map_width: int
@export var map_height: int

func _ready() -> void:
	generate_map()

func generate_map() -> void:
	for x in map_width:
		for y in map_height:
			var noiseVal: float = fnl.get_noise_2d(x, y)
			if noiseVal >= 0.6:
				$TileMapLayer.set_cell(Vector2i(x, y), 0, Vector2i(0, 0))
			elif noiseVal >= 0.56:
				$TileMapLayer.set_cell(Vector2i(x, y), 0, Vector2i(1, 0))
			elif noiseVal >= -0.56:
				$TileMapLayer.set_cell(Vector2i(x, y), 0, Vector2i(3, 0))
			elif noiseVal >= -0.6:
				$TileMapLayer.set_cell(Vector2i(x, y), 0, Vector2i(7, 0))
			else:
				$TileMapLayer.set_cell(Vector2i(x, y), 0, Vector2i(8, 0))
