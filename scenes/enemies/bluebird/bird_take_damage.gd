extends CharacterBody2D

signal on_damage_taken


func take_damage():
	on_damage_taken.emit()
