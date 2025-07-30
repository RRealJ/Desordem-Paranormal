extends Node



const PLAYER_COLLISION_LAYER= 2
const ENEMY_COLLISION_LAYER= 8
const OBSTACLE_COLLISION_LAYER= 11
const RAYCAST_ENEMY_COLLISION_LAYER= 12

const TILE_SIZE= 16

var player: CharacterBody2D
var enemies: Node2D
var obstacle_tile_map: TileMapLayer
var pathfinder: Pathfinder
