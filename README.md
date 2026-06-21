# Jailbreak Power Plant Auto-Solver

## Loadstring
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/huoadf/jailbreak/main/powerplant_solver.lua"))()
```

## How to Use
1. Execute the loadstring in your exploit.
2. Press **[RightControl]** to show or hide the UI menu.
3. Turn on **Auto Solve** in settings.
4. Interact with the terminal in game to solve automatically.

## Change UI Toggle Keybind
If you want to use a key other than **RightControl** (e.g. `RightShift` or `Insert`), define `_G.UIToggleKey` *before* running the loadstring:
```lua
_G.UIToggleKey = "Insert"
loadstring(game:HttpGet("https://raw.githubusercontent.com/huoadf/jailbreak/main/powerplant_solver.lua"))()
```
