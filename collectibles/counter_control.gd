extends Control
class_name CounterControl

@onready var bone_counter: Counter = $HBoxContainer/Bones
@onready var kitten_counter: Counter = $HBoxContainer/Kittens

func set_level_counts(bone_max: int, kitten_max: int):
	bone_counter.set_max_count(bone_max)
	bone_counter.set_count(0)
	kitten_counter.set_max_count(kitten_max)
	kitten_counter.set_count(0)

func collect_bone(amount: int = 1):
	bone_counter.increment(amount)

func collect_kitten(amount: int = 1):
	kitten_counter.increment(amount)
