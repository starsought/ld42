extends Node

export (PackedScene) var Menu
export (PackedScene) var Game

var menu
var game


func _ready():
	return_to_menu()


func start_game():
	print('instancing game...')
	game = Game.instance()
	add_child(game)
	game.connect('return_to_menu', self, 'return_to_menu')
	if menu:
		menu.queue_free()


func return_to_menu():
	print('instancing menu...')
	menu = Menu.instance()
	add_child(menu)
	menu.connect('start_game', self, 'start_game')
	if game:
		game.queue_free()