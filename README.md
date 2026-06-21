# Jailbreak Scripts

This repository contains scripts for Roblox Jailbreak, kept in both clean and obfuscated formats.

## Power Plant Auto-Solver

### Loadstring (Obfuscated Version)
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/huoadf/jailbreak/main/powerplant_solver.lua"))()
```

### Files
* **[powerplant_solver.lua](powerplant_solver.lua)**: The obfuscated single-line version (used by the loadstring above).
* **[powerplant_solver_clean.lua](powerplant_solver_clean.lua)**: The clean, readable version of the solver.

### How to Use
1. Execute the loadstring in your exploit.
2. Press **[RightControl]** to show or hide the UI menu.
3. Turn on **Auto Solve** in settings.
4. Interact with the terminal in game to solve automatically.

### Customizing the UI Keybind
If you want to use a key other than **RightControl** (e.g. `RightShift` or `Insert`), define `_G.UIToggleKey` *before* running the loadstring:
```lua
_G.UIToggleKey = "Insert"
loadstring(game:HttpGet("https://raw.githubusercontent.com/huoadf/jailbreak/main/powerplant_solver.lua"))()
```
