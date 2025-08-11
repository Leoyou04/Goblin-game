extends Control

const SAVE_PATH := "user://audio_settings.cfg"
const BUS_NAME := "Master"  # change to your bus name if needed
const MIN_DB := -80.0  # silence
const MAX_DB := 0.0    # unity

@onready var slider: HSlider = $VolumeSlider
var bus_idx: int = -1

func _ready() -> void:
	bus_idx = AudioServer.get_bus_index(BUS_NAME)

	slider.min_value = 25
	slider.max_value = 100
	slider.step = 1

	_load_volume()
	slider.connect("value_changed", Callable(self, "_on_VolumeSlider_value_changed"))

func _on_VolumeSlider_value_changed(value: float) -> void:
	var db: float = lerp(MIN_DB, MAX_DB, value / 100.0)
	AudioServer.set_bus_volume_db(bus_idx, db)
	_save_volume(value)

func _save_volume(value: float) -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("audio", "master_percent", value)
	var err: int = cfg.save(SAVE_PATH)
	if err != OK:
		push_error("Failed saving audio settings: %s" % err)

func _load_volume() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		var v: float = float(cfg.get_value("audio", "master_percent", slider.value))
		slider.value = v
		var db: float = lerp(MIN_DB, MAX_DB, v / 100.0)
		AudioServer.set_bus_volume_db(bus_idx, db)
	else:
		var current_db: float = AudioServer.get_bus_volume_db(bus_idx)
		current_db = clamp(current_db, MIN_DB, MAX_DB)
		slider.value = (current_db - MIN_DB) / (MAX_DB - MIN_DB) * 100.0
