extends TileMap


func walkable(xy):
	return get_cellv(world_to_map(xy)) in [0, 1]