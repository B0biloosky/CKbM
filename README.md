# How to use CKbM

### Configuring Constants

The constants are explained within the project in comments, but I'll explain them here aswell.
* `SAVE_PATH` determines where the keybinds will be saved on a user's computer. Configure the `SAVE_PATH` variable on line `4` to fit your preferences.
* `NONE_KEY` is the key that should be pressed to set a keybind's vvalue to `None`. Configure the `NONE_KEY` variable on line `5` to fit your needs.


### Adding keybinds

1. Determine what section you keybind should be placed in, by default the project has two sections, `ui` and `player`, but you can add more or remove some to fit your needs. Sections are a `VBoxContainer` as a child of the `Keybinds List` node.
2. Create the keybind, keybinds are `HBoxContainers` labeled `<section>_<name>`, the name is up to ou, but the section should be whatever section the keybind is in. I recommend just copy and pasting an existing keybind and changing the `Label` text to aviod having to copy a keybind's node structure and settings by hand.
3. Script `WatchKeybind()` function, on line `25` there is a function called ` _process()`, for any custom keybind that you added in the previous steps add a `WatchKeybind(<section>, <name>)` function where `<section>` is what section that keybind is in and `<name>` is the name of the keybind.
4. Script `LoadKeybind()` function, on line `44` there is a function called ` _LoadButtonPressed()`, for any custom keybind that you added in the previous steps add a `LoadKeybind(<section>, <name>)` function where `<section>` is what section that keybind is in and `<name>` is the name of the keybind.
5. Test, I didn't really test it that well, so its best to make sure that this actually works.
