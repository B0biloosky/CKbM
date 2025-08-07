extends Control

# CONSTANTS
const SAVE_PATH: String = "user://Keybinds.cfg" # Change to where you want the keybinds to be saved.         DEFAULT = "user://Keybinds.cfg"
const NONE_KEY: String = "Escape" # The key that if pressed while configuring a keybind, will set that binf to `None`.   DEFAULT = "KEY_ESCAPEEscape"

# Variables
var AnyKeyPressed: bool = false
var LastKeyPressed: String = "NONE"
var KeybindPath: String = ""
var CurrentKeybindSection: String = ""
var CurrentKeybindName: String = ""
var ActiveKeybind: String = "NONE"
var SettingKeybind: bool = false
var LoadPath: String = ""

# Save File
var KeybindsSaveFile = ConfigFile.new()

# Init
func _ready() -> void:
	GetKeybind("ui", "ui_select")

# Loop
func _process(delta: float) -> void:
	WatchKeybind("ui", "ui_select")
	WatchKeybind("ui", "ui_back")
	WatchKeybind("ui", "ui_up")
	WatchKeybind("ui", "ui_down")
	WatchKeybind("ui", "ui_left")
	WatchKeybind("ui", "ui_right")
	
	WatchKeybind("player", "player_up")
	WatchKeybind("player", "player_down")
	WatchKeybind("player", "player_left")
	WatchKeybind("player", "player_right")
	WatchKeybind("player", "player_jump")
	WatchKeybind("player", "player_crawl")

# Buttons
func _SaveButtonPressed() -> void:
	SaveKeybinds()

func _LoadButtonPressed() -> void:
	LoadKeybind("ui", "ui_select")
	LoadKeybind("ui", "ui_back")
	LoadKeybind("ui", "ui_up")
	LoadKeybind("ui", "ui_down")
	LoadKeybind("ui", "ui_left")
	LoadKeybind("ui", "ui_right")
	
	LoadKeybind("player", "player_up")
	LoadKeybind("player", "player_down")
	LoadKeybind("player", "player_left")
	LoadKeybind("player", "player_right")
	LoadKeybind("player", "player_jump")
	LoadKeybind("player", "player_crawl")

# Functions
func _input(event):
	if event is InputEventKey and event.pressed:
		AnyKeyPressed = true
		LastKeyPressed = OS.get_keycode_string(event.keycode)

func GetKeybind(Section: String, Name: String):
	pass

func SaveKeybinds():
	KeybindsSaveFile.save(SAVE_PATH)
	print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", 'Keybinds saved to "', SAVE_PATH, '".'))

func WatchKeybind(Section: String, Name: String):
	if !SettingKeybind:
		KeybindPath = str("Keybinds List/", Section, "/", Name, "/Button Sizer/Button")
		CurrentKeybindSection = Section
		CurrentKeybindName = Name
	
	if get_node(KeybindPath).button_pressed:
		print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", '"', KeybindPath, '" is pressed.'))
		
		get_node(KeybindPath).disabled = true
		ActiveKeybind = KeybindPath
		print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", 'Active keybind set to "', ActiveKeybind, '".'))
		
		SettingKeybind = true
		print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", 'SettingKeybind set to "true".'))
		
		AnyKeyPressed = false
	
	if SettingKeybind:
		SetKeybind(Section, Name)

func SetKeybind(Section: String, Name: String):
	if AnyKeyPressed:
		if LastKeyPressed == NONE_KEY:
			get_node(KeybindPath).text = " "
			KeybindsSaveFile.set_value(CurrentKeybindSection, CurrentKeybindName, " ")
			print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", 'Set keybind "', CurrentKeybindSection, ".", CurrentKeybindName, '" to " ".'))
			
			get_node(KeybindPath).disabled = false
			
			SettingKeybind = false
			print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", 'SettingKeybind set to "false".'))
		else:
			get_node(KeybindPath).text = LastKeyPressed
			KeybindsSaveFile.set_value(CurrentKeybindSection, CurrentKeybindName, LastKeyPressed)
			print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", 'Set keybind "', CurrentKeybindSection, ".", CurrentKeybindName, '" to "', LastKeyPressed, '".'))
			
			get_node(KeybindPath).disabled = false
			
			SettingKeybind = false
			print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", 'SettingKeybind set to "false".'))
	else:
		get_node(KeybindPath).text = "..."


func LoadKeybind(Section: String, Name: String):
	var err = KeybindsSaveFile.load("user://Keybinds.cfg")
	if err != OK:
		print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", "Could not load keybinds."))
		return
	print(str("[", Time.get_time_string_from_system(), "] [CKbM/INFO] ", 'Loaded keybind "', Section, ".", Name, '".'))
	
	LoadPath = str("Keybinds List/", Section, "/", Name, "/Button Sizer/Button")
	
	if str(KeybindsSaveFile.get_value(Section, Name)) == "<null>":
		get_node(LoadPath).text = " "
	else:
		get_node(LoadPath).text = str(KeybindsSaveFile.get_value(Section, Name))
