extends Node

const joker_scene: PackedScene = preload("res://Card/Joker/joker_card.tscn")

var abilities: Dictionary = {
	
	"jimbo": "res://Card/Joker/Abilities/jimbo.gd",
	"crimson_joker": "res://Card/Joker/Abilities/crimson_joker.gd",
	"dark_joker": "res://Card/Joker/Abilities/dark_joker.gd",
	"golden_joker": "res://Card/Joker/Abilities/golden_joker.gd",
	"azure_joker": "res://Card/Joker/Abilities/azure_joker.gd",
	"paraslug": "res://Card/Joker/Abilities/paraslug.gd"
}

func create_ability_node(path: String) -> JokerAbility:
	var new_joker: JokerAbility
	
	return new_joker


func create_joker(ability: String) -> JokerInstance:
	var new_joker: JokerInstance = joker_scene.instantiate()
	
	new_joker.ability_id = ability
	
	return new_joker
