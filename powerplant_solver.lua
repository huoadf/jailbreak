-- Jailbreak Power Plant Auto Solver (Roblox Luau)
-- Pure Lua signal emulation (No VirtualInputManager or GetGuiInset dependencies)
-- Optimizations: getrenv() Enum bypass for sandboxed environments

-- Safe Enum retrieval and global environment injection to bypass sandboxed executor Enums
local RealEnum = Enum
if getrenv then
    pcall(function()
        local renv = getrenv()
        if renv and renv.Enum then
            RealEnum = renv.Enum
        end
    end)
end

-- Helper to safely get enum items
local function getEnumItem(enumName, itemName)
    local item = nil
    pcall(function() item = RealEnum[enumName][itemName] end)
    if not item then
        pcall(function() item = Enum[enumName][itemName] end)
    end
    return item
end

-- Clear any previously running instance to prevent threads from multiplying and crashing the VM on reload
if _G.PowerPlantSolverInstance then
    pcall(function()
        _G.PowerPlantSolverInstance:Unload()
    end)
end

-- Create instance manager structure
local currentSolver = {
    Running = true,
    Connections = {}
}
_G.PowerPlantSolverInstance = currentSolver

-- Helper to track and disconnect event connections safely
local function trackConnection(connection)
    table.insert(currentSolver.Connections, connection)
    return connection
end

-- Cache/reconstruct UserInputType enum items
local mockUserInputType = {
    MouseButton1 = getEnumItem("UserInputType", "MouseButton1"),
    MouseMovement = getEnumItem("UserInputType", "MouseMovement"),
    Touch = getEnumItem("UserInputType", "Touch"),
    Gamepad1 = getEnumItem("UserInputType", "Gamepad1")
}

-- Reconstruct items if completely missing
if not mockUserInputType.MouseButton1 then
    pcall(function()
        mockUserInputType.MouseButton1 = { Name = "MouseButton1", Value = 0, EnumType = "UserInputType" }
        mockUserInputType.MouseMovement = { Name = "MouseMovement", Value = 1, EnumType = "UserInputType" }
        mockUserInputType.Touch = { Name = "Touch", Value = 2, EnumType = "UserInputType" }
        mockUserInputType.Gamepad1 = { Name = "Gamepad1", Value = 3, EnumType = "UserInputType" }
    end)
end

-- Reconstruct KeyCode V for solver trigger
local mockKeyCode = {
    V = getEnumItem("KeyCode", "V")
}
if not mockKeyCode.V then
    pcall(function()
        mockKeyCode.V = { Name = "V", Value = 118, EnumType = "KeyCode" }
    end)
end

-- Construct EnumProxy to protect internal game script calls (e.g. connections) from throwing nil errors
local EnumProxy = setmetatable({}, {
    __index = function(self, key)
        if key == "UserInputType" then
            return mockUserInputType
        elseif key == "KeyCode" then
            local val = nil
            pcall(function() val = RealEnum.KeyCode end)
            if not val then
                pcall(function() val = Enum.KeyCode end)
            end
            if type(val) == "table" or type(val) == "userdata" then
                return val
            end
            return mockKeyCode
        end
        local val = nil
        pcall(function() val = RealEnum[key] end)
        if not val then
            pcall(function() val = Enum[key] end)
        end
        return val
    end
})

-- Inject proxy globally so that exploit APIs (like firesignal) and connections see it
if getgenv then
    pcall(function()
        getgenv().Enum = EnumProxy
    end)
end

_G.AutoSolve = false -- Default to false so user can configure sliders first without instant solving

-- Virtual Key (VK) codes mapping for Matcha sandboxed environments
local VK_MAP = {
    A = 0x41, B = 0x42, C = 0x43, D = 0x44, E = 0x45, F = 0x46, G = 0x47, H = 0x48,
    I = 0x49, J = 0x4A, K = 0x4B, L = 0x4C, M = 0x4D, N = 0x4E, O = 0x4F, P = 0x50,
    Q = 0x51, R = 0x52, S = 0x53, T = 0x54, U = 0x55, V = 0x56, W = 0x57, X = 0x58,
    Y = 0x59, Z = 0x5A, Space = 0x20, Enter = 0x0D, Escape = 0x1B, LeftShift = 0xA0,
    RightShift = 0xA1, LeftControl = 0xA2, RightControl = 0xA3, End = 0x23
}

_G.SolveKey = VK_MAP.V -- Default manual trigger key bind (V)
_G.InstantSolve = true -- Set false to visually drag the lines (legit mode)
_G.SolveDelay = 0.08 -- delay between drag steps (smooth 2-step interpolation)
_G.PathDelay = 0.15 -- delay between drawing different paths (fast transitions)
_G.MustFillAllCells = true -- whether all grid spaces must be filled
_G.UseOSMouse = true -- Set to true to physically move the mouse cursor using Matcha's external mouse APIs
_G.VerifyDraws = true -- Verify path completion and redraw missed paths at the end
_G.ShowDebugVisuals = true -- Set to true to show the path lines before/during solve
_G.MouseOffsetX = 0 -- manual horizontal offset calibration
_G.MouseOffsetY = 0 -- manual vertical offset calibration

-- Safe retrieval of Matcha external input APIs
local function getGlobal(name)
    local val = rawget(_G, name)
    if val ~= nil then return val end
    
    local success, envVal = pcall(function()
        return getgenv and getgenv()[name]
    end)
    if success and envVal ~= nil then return envVal end
    
    local success2, fenvVal = pcall(function()
        return getfenv()[name]
    end)
    if success2 and fenvVal ~= nil then return fenvVal end
    
    local success3, directVal = pcall(function()
        return getfenv(0)[name]
    end)
    if success3 and directVal ~= nil then return directVal end
    
    return nil
end

local matchaMove = getGlobal("mousemoveabs")
local matchaPress = getGlobal("mouse1press")
local matchaRelease = getGlobal("mouse1release")
local matchaClick = getGlobal("mouse1click")

-- Print API status for diagnostic purposes
print("[PowerPlantSolver] --- Matcha Input APIs Status ---")
print("  mousemoveabs:", tostring(matchaMove))
print("  mouse1press:", tostring(matchaPress))
print("  mouse1release:", tostring(matchaRelease))
print("  mouse1click:", tostring(matchaClick))
print("-------------------------------------------------")

-- Define safe wrapper for mousemoveabs to handle both 3-arg and 2-arg signatures
local function safeMouseMoveAbs(x, y)
    if not matchaMove then return false end
    
    -- Try standard 2-argument signature first
    local success, err = pcall(function()
        matchaMove(x, y)
    end)
    
    -- If it fails, fallback to 3-argument signature (leading 0)
    if not success then
        local success2, err2 = pcall(function()
            matchaMove(0, x, y)
        end)
        if not success2 then
            warn("[PowerPlantSolver] Both mousemoveabs signatures failed: " .. tostring(err2))
            return false
        end
    end
    return true
end

-- Define safe click button helper
local function safeMouse1Click()
    if matchaClick then
        local success, err = pcall(matchaClick)
        if success then return true end
    end
    if matchaPress and matchaRelease then
        local success, err = pcall(function()
            matchaPress()
            task.wait(0.02)
            matchaRelease()
        end)
        if success then return true end
    end
    return false
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local StarterGui = game:GetService("StarterGui")

-- Unique namespace for status tracking
_G.Solving = false

local MouseButton1 = mockUserInputType.MouseButton1
local MouseMovement = mockUserInputType.MouseMovement

-- Helper function to display native Roblox or Matcha notifications
local function sendNotification(title, content)
    local msg = "[" .. tostring(title) .. "] " .. tostring(content)
    print(msg)
    
    local matchaNotify = getGlobal("notify")
    if matchaNotify then
        pcall(function()
            matchaNotify(content, title, 3.5)
        end)
    else
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = title,
                Text = content,
                Duration = 3.5
            })
        end)
    end
end

-- Helper: Fire GuiObject signals using firesignal or getconnections fallback
local function fireGuiSignal(signal, ...)
    if firesignal then
        pcall(firesignal, signal, ...)
    elseif getconnections then
        for _, connection in ipairs(getconnections(signal)) do
            if connection.Function then
                pcall(connection.Function, ...)
            end
        end
    end
end

-- Diagnostic: Print PlayerGui hierarchy to troubleshoot fallback scanner
local function printGuiHierarchy()
    print("[PowerPlantSolver] --- PlayerGui Hierarchy Scan ---")
    local foundAny = false
    for _, gui in ipairs(PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            foundAny = true
            print(string.format("  ScreenGui found: Name='%s', Enabled=%s, VisibleDescendants=%d", gui.Name, tostring(gui.Enabled), #gui:GetDescendants()))
            -- If name matches FlowGui or contains Board, dump its descendants
            if string.find(string.lower(gui.Name), "flow") or string.find(string.lower(gui.Name), "puzzle") or gui:FindFirstChild("Board", true) then
                print(string.format("  Dumping structure for '%s':", gui.Name))
                for _, desc in ipairs(gui:GetDescendants()) do
                    local path = desc.Name
                    local p = desc.Parent
                    while p and p ~= gui do
                        path = p.Name .. "." .. path
                        p = p.Parent
                    end
                    print(string.format("    %s.%s (%s)", gui.Name, path, desc.ClassName))
                end
            end
        end
    end
    if not foundAny then
        print("  No ScreenGuis found in PlayerGui.")
    end
    print("[PowerPlantSolver] ---------------------------------")
end

-- 1. Helper: Locate the internal game state table from Garbage Collector (Upvalue Scanner)
local function getPuzzleFlowTable(suppressLogging)
    -- Helper to verify if a table is the active flowTable
    local function isPuzzleFlowTable(t)
        if type(t) ~= "table" then return false end
        return rawget(t, "GridClean") ~= nil or rawget(t, "Grid") ~= nil or rawget(t, "SetGrid") ~= nil or rawget(t, "GetCoordFromMouse") ~= nil
    end

    -- Option A: Attempt requiring the module directly and scanning its upvalues
    local success, PuzzleFlow = pcall(function()
        local rep = game:GetService("ReplicatedStorage")
        -- Search ReplicatedStorage for PuzzleFlow module script
        local module = rep:FindFirstChild("PuzzleFlow", true)
        if module and module:IsA("ModuleScript") then
            return require(module)
        end
    end)
    
    if success and type(PuzzleFlow) == "table" then
        if not suppressLogging then
            print("[PowerPlantSolver] PuzzleFlow module required successfully. Scanning upvalues...")
        end
        for k, v in pairs(PuzzleFlow) do
            if type(v) == "function" then
                local i = 1
                while true do
                    local name, val = debug.getupvalue(v, i)
                    if not name then break end
                    if isPuzzleFlowTable(val) then
                        if not suppressLogging then
                            print("[PowerPlantSolver] Found flowTable in module function upvalue:", name)
                        end
                        return val
                    end
                    i = i + 1
                end
            end
        end
    end
    
    -- Option B: Fallback to Matcha-specific getgc(names) scanning
    if getgc then
        if not suppressLogging then
            print("[PowerPlantSolver] Querying Matcha getgc for puzzle identifiers...")
        end
        -- Querying specific keys likely to belong to the flowTable instance or methods
        local names = {"SetGrid", "GetCoordFromMouse", "OnConnection", "Hide", "New", "new", "GridClean", "IsOpen"}
        local success2, list = pcall(getgc, names)
        
        if success2 and type(list) == "table" then
            for _, entry in ipairs(list) do
                -- If it is a function, search its upvalues
                if entry.type == "function" or type(entry.value) == "function" then
                    local func = entry.value or entry
                    if type(func) == "function" then
                        local i = 1
                        while true do
                            local name, val = debug.getupvalue(func, i)
                            if not name then break end
                            if isPuzzleFlowTable(val) then
                                if not suppressLogging then
                                    print("[PowerPlantSolver] Found flowTable in GC function upvalue:", name)
                                end
                                return val
                            end
                            i = i + 1
                        end
                    end
                -- If the value itself matches the structure, return it
                elseif type(entry.value) == "table" and isPuzzleFlowTable(entry.value) then
                    if not suppressLogging then
                        print("[PowerPlantSolver] Found flowTable directly in GC entries under key:", tostring(entry.key))
                    end
                    return entry.value
                end
            end
        elseif not suppressLogging then
            warn("[PowerPlantSolver] Matcha getgc query failed: " .. tostring(list))
        end
    end
    
    return nil
end

-- 2. Helper: Find the FlowGui ScreenGui (optionally checking if it's active)
local function findPuzzleGui(onlyActive)
    local flowGui = PlayerGui:FindFirstChild("FlowGui")
    if flowGui then
        local board = flowGui:FindFirstChild("Board")
        if board then
            local inner = board:FindFirstChild("Inner")
            if inner then
                local isActive = true
                if onlyActive then
                    isActive = false
                    pcall(function()
                        local size = board.AbsoluteSize
                        if size and size.X > 10 and size.Y > 10 then
                            isActive = true
                        end
                    end)
                end
                
                if isActive then
                    return flowGui, inner
                else
                    -- Primary FlowGui exists but is inactive. Skip scanning other GUIs.
                    return nil, nil
                end
            end
        end
    end
    -- Fallback: Scan any ScreenGui for a child named "Board" with "Inner"
    for _, gui in ipairs(PlayerGui:GetChildren()) do
        local board = gui:FindFirstChild("Board")
        if board then
            local inner = board:FindFirstChild("Inner")
            if inner then
                local isActive = true
                if onlyActive then
                    isActive = false
                    pcall(function()
                        local size = board.AbsoluteSize
                        if size and size.X > 10 and size.Y > 10 then
                            isActive = true
                        end
                    end)
                end
                
                if isActive then
                    return gui, inner
                end
            end
        end
    end
    return nil, nil
end

-- 3. Helper: Parse TextLabels inside Board.Inner named "X.Y"
local function parseGrid(innerFrame)
    local grid = {}
    local height = 0
    local width = 0
    for _, child in ipairs(innerFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            local x, y = string.match(child.Name, "^(%d+)%.(%d+)$")
            if x and y then
                x, y = tonumber(x), tonumber(y)
                if x > width then width = x end
                if y > height then height = y end
                if not grid[y] then grid[y] = {} end
                grid[y][x] = child
            end
        end
    end
    return grid, height, width
end

-- 4. Helper: Extract the number from a grid cell
local function getCellNumber(label)
    local text = label.Text
    if text and text ~= "" then
        local num = tonumber(text)
        if num then return num end
    end
    return nil
end

-- 5. Solver Algorithm: Fast backtracking search
local function solvePuzzle(gridMatrix, height, width, pairsList)
    -- Sort pairs by Manhattan distance (shortest first)
    table.sort(pairsList, function(a, b)
        local distA = math.abs(a.startPos.r - a.endPos.r) + math.abs(a.startPos.c - a.endPos.c)
        local distB = math.abs(b.startPos.r - b.endPos.r) + math.abs(b.startPos.c - b.endPos.c)
        return distA < distB
    end)
    
    local paths = {}
    for _, p in ipairs(pairsList) do
        paths[p.id] = { p.startPos }
    end
    
    local directions = {
        {r = -1, c = 0},
        {r = 1, c = 0},
        {r = 0, c = -1},
        {r = 0, c = 1}
    }
    
    local function search(pairIndex)
        if pairIndex > #pairsList then
            if _G.MustFillAllCells then
                -- Verify if all grid cells are filled
                for r = 1, height do
                    for c = 1, width do
                        if gridMatrix[r][c] == 0 then
                            return false
                        end
                    end
                end
            end
            return true
        end
        
        local pair = pairsList[pairIndex]
        local path = paths[pair.id]
        local current = path[#path]
        local target = pair.endPos
        
        -- Check if adjacent to target (finish path)
        local dist = math.abs(current.r - target.r) + math.abs(current.c - target.c)
        if dist == 1 then
            table.insert(path, target)
            if search(pairIndex + 1) then
                return true
            end
            table.remove(path) -- backtrack
        end
        
        -- Try moving to empty cells
        for _, dir in ipairs(directions) do
            local nr, nc = current.r + dir.r, current.c + dir.c
            if nr >= 1 and nr <= height and nc >= 1 and nc <= width then
                if gridMatrix[nr][nc] == 0 then
                    gridMatrix[nr][nc] = pair.id
                    table.insert(path, {r = nr, c = nc})
                    
                    if search(pairIndex) then
                        return true
                    end
                    
                    -- Backtrack
                    gridMatrix[nr][nc] = 0
                    table.remove(path)
                end
            end
        end
        
        return false
    end
    
    -- Initialize gridMatrix
    for r = 1, height do
        gridMatrix[r] = {}
        for c = 1, width do
            gridMatrix[r][c] = 0
        end
    end
    for _, p in ipairs(pairsList) do
        gridMatrix[p.startPos.r][p.startPos.c] = p.id
        gridMatrix[p.endPos.r][p.endPos.c] = p.id
    end
    
    if search(1) then
        return paths
    end
    return nil
end

-- 6. Helper: Get center coordinates of a GUI element in viewport space
local function getCenter(label)
    local pos = label.AbsolutePosition
    local size = label.AbsoluteSize
    return pos.X + size.X/2, pos.Y + size.Y/2
end

-- 7. Helper: Emulate clicking/activating a GUI Button using hybrid input
local function clickButton(btn)
    local x, y = getCenter(btn)
    
    local useOSMouse = _G.UseOSMouse and (matchaMove ~= nil)
    local useVIM = false
    local vim = nil
    if not useOSMouse then
        pcall(function()
            vim = game:GetService("VirtualInputManager")
            useVIM = (vim ~= nil)
        end)
    end
    
    print(string.format("[PowerPlantSolver] clickButton Target Center: X=%d, Y=%d (OSMouse=%s, VIM=%s)", x, y, tostring(useOSMouse), tostring(useVIM)))
    
    if useOSMouse then
        local success, err = pcall(function()
            local inset = Vector2.new(0, 0)
            pcall(function()
                inset = game:GetService("GuiService"):GetGuiInset()
            end)
            safeMouseMoveAbs(x + inset.X + (_G.MouseOffsetX or 0), y + inset.Y + (_G.MouseOffsetY or 0))
            task.wait(0.04)
            safeMouse1Click()
        end)
        if not success then
            warn("[PowerPlantSolver] clickButton OSMouse execution failed: " .. tostring(err))
        end
    elseif useVIM then
        local inset = Vector2.new(0, 0)
        pcall(function()
            inset = game:GetService("GuiService"):GetGuiInset()
        end)
        pcall(function()
            local vx, vy = x + inset.X + (_G.MouseOffsetX or 0), y + inset.Y + (_G.MouseOffsetY or 0)
            vim:SendMouseButtonEvent(vx, vy, 0, true, game, 0)
            task.wait(0.02)
            vim:SendMouseButtonEvent(vx, vy, 0, false, game, 0)
        end)
    else
        fireGuiSignal(btn.MouseButton1Down)
    end
end

-- 8. Helper: Click and drag path labels using physical mouse movement or event emulation
local function dragPath(gui, pathLabels)
    if #pathLabels < 2 then return end
    
    local useOSMouse = _G.UseOSMouse and (matchaMove ~= nil)
    local useVIM = false
    local vim = nil
    if not useOSMouse then
        pcall(function()
            vim = game:GetService("VirtualInputManager")
            useVIM = (vim ~= nil)
        end)
    end
    
    print(string.format("[PowerPlantSolver] dragPath starting for path size=%d (OSMouse=%s, VIM=%s)", #pathLabels, tostring(useOSMouse), tostring(useVIM)))
    
    if useOSMouse then
        local inset = Vector2.new(0, 0)
        pcall(function()
            inset = game:GetService("GuiService"):GetGuiInset()
        end)
        
        local coords = {}
        for _, label in ipairs(pathLabels) do
            local cx, cy = getCenter(label)
            table.insert(coords, {
                x = cx + inset.X + (_G.MouseOffsetX or 0),
                y = cy + inset.Y + (_G.MouseOffsetY or 0)
            })
        end
        
        local success, err = pcall(function()
            local startPt = coords[1]
            safeMouseMoveAbs(startPt.x, startPt.y)
            task.wait(0.06)
            if matchaPress then matchaPress() else safeMouse1Click() end
            task.wait(0.06)
            
            for i = 2, #coords do
                local prev = coords[i-1]
                local pt = coords[i]
                
                -- Check if puzzle is still open/active; if not, release mouse and abort
                local currentGui, _ = findPuzzleGui(true)
                if not currentGui then
                    if matchaRelease then pcall(matchaRelease) end
                    error("puzzle_closed")
                end
                
                -- Interpolate halfway to make the drag continuous and register 100% reliably
                local midX = prev.x + (pt.x - prev.x) / 2
                local midY = prev.y + (pt.y - prev.y) / 2
                safeMouseMoveAbs(midX, midY)
                task.wait(_G.SolveDelay / 2)
                
                safeMouseMoveAbs(pt.x, pt.y)
                task.wait(_G.SolveDelay / 2)
            end
            
            task.wait(0.16) -- Wait at final cell to ensure Roblox registers the endpoint position of long paths
            if matchaRelease then
                matchaRelease()
            end
        end)
        if not success then
            warn("[PowerPlantSolver] dragPath OSMouse execution failed: " .. tostring(err))
        end
        task.wait(0.05)
        
    elseif useVIM then
        local inset = Vector2.new(0, 0)
        pcall(function()
            inset = game:GetService("GuiService"):GetGuiInset()
        end)
        
        pcall(function()
            local startLabel = pathLabels[1]
            local sx, sy = getCenter(startLabel)
            sx, sy = sx + inset.X + (_G.MouseOffsetX or 0), sy + inset.Y + (_G.MouseOffsetY or 0)
            
            vim:SendMouseButtonEvent(sx, sy, 0, true, game, 0)
            task.wait(_G.SolveDelay)
            
            local lastX, lastY = sx, sy
            for i = 2, #pathLabels do
                -- Check if puzzle is still open/active; if not, release mouse and abort
                local currentGui, _ = findPuzzleGui(true)
                if not currentGui then
                    vim:SendMouseButtonEvent(lastX, lastY, 0, false, game, 0)
                    error("puzzle_closed")
                end
                
                local cx, cy = getCenter(pathLabels[i])
                cx, cy = cx + inset.X + (_G.MouseOffsetX or 0), cy + inset.Y + (_G.MouseOffsetY or 0)
                vim:SendMouseMoveEvent(cx, cy, game)
                lastX, lastY = cx, cy
                task.wait(_G.SolveDelay)
            end
            
            vim:SendMouseButtonEvent(lastX, lastY, 0, false, game, 0)
        end)
        task.wait(0.04)
        
    else
        -- Fallback: Silent event emulation (no physical movement)
        local startLabel = pathLabels[1]
        local sx, sy = getCenter(startLabel)
        local inputBeganObj = {
            UserInputType = MouseButton1,
            Position = Vector3.new(sx, sy, 0)
        }
        fireGuiSignal(gui.Board.InputBegan, inputBeganObj)
        task.wait(_G.SolveDelay)
        
        local success, err = pcall(function()
            for i = 2, #pathLabels do
                -- Check if puzzle is still open/active; if not, release mouse and abort
                local currentGui, _ = findPuzzleGui(true)
                if not currentGui then
                    local endLabel = pathLabels[i-1] or pathLabels[1]
                    local ex, ey = getCenter(endLabel)
                    local inputEndedObj = {
                        UserInputType = MouseButton1,
                        Position = Vector3.new(ex, ey, 0)
                    }
                    fireGuiSignal(gui.Board.InputEnded, inputEndedObj)
                    error("puzzle_closed")
                end
                
                local label = pathLabels[i]
                local cx, cy = getCenter(label)
                local inputChangedObj = {
                    UserInputType = MouseMovement,
                    Position = Vector3.new(cx, cy, 0)
                }
                fireGuiSignal(gui.Board.InputChanged, inputChangedObj)
                task.wait(_G.SolveDelay)
            end
            
            local endLabel = pathLabels[#pathLabels]
            local ex, ey = getCenter(endLabel)
            local inputEndedObj = {
                UserInputType = MouseButton1,
                Position = Vector3.new(ex, ey, 0)
            }
            fireGuiSignal(gui.Board.InputEnded, inputEndedObj)
        end)
        if not success then
            warn("[PowerPlantSolver] dragPath Event execution failed: " .. tostring(err))
        end
        task.wait(0.04)
    end
end

-- Helper to verify if a path is successfully connected (uses memory if available, fallback to GUI labels)
local function verifyPath(p, path, flowTable, pathLabels)
    -- 1. Try memory verification first
    if flowTable and flowTable.Grid then
        local endStep = path[#path]
        local gridMatrix = flowTable.Grid
        if gridMatrix and gridMatrix[endStep.r] then
            local val = gridMatrix[endStep.r][endStep.c]
            return val == p.guiId
        end
    end
    
    -- 2. Fallback: GUI Text Verification
    if pathLabels and #pathLabels >= 2 then
        local startCell = pathLabels[1]
        local testCell = pathLabels[#pathLabels - 1] -- cell right before endpoint
        if startCell and testCell then
            local startText = startCell.Text
            local testText = testCell.Text
            if startText and startText ~= "" and testText == startText then
                return true
            end
        end
        return false -- text does not match, meaning path did not connect
    end
    
    return true
end

local debugDrawings = {}

local function clearDebugVisuals()
    for _, obj in ipairs(debugDrawings) do
        pcall(function() obj:Remove() end)
    end
    debugDrawings = {}
end

local function drawDebugPath(paths, grid, pairsList)
    clearDebugVisuals()
    if not _G.ShowDebugVisuals then return end
    
    for _, p in ipairs(pairsList) do
        local path = paths[p.id]
        if path and #path > 1 then
            local color = Color3.fromHSV((p.guiId * 0.17) % 1, 0.8, 1)
            local coords = {}
            for _, step in ipairs(path) do
                local label = grid[step.r][step.c]
                if label then
                    local cx, cy = getCenter(label)
                    local inset = Vector2.new(0, 0)
                    pcall(function()
                        inset = game:GetService("GuiService"):GetGuiInset()
                    end)
                    table.insert(coords, Vector2.new(
                        cx + inset.X + (_G.MouseOffsetX or 0),
                        cy + inset.Y + (_G.MouseOffsetY or 0)
                    ))
                end
            end
            
            for i = 1, #coords do
                local pt = coords[i]
                local okCircle, circleObj = pcall(function()
                    local c = Drawing.new("Circle")
                    c.Position = pt
                    c.Radius = 6
                    c.Color = color
                    c.Filled = true
                    c.Transparency = 0.7
                    c.Visible = true
                    c.ZIndex = 3000
                    return c
                end)
                if okCircle and circleObj then
                    table.insert(debugDrawings, circleObj)
                end
                
                if i < #coords then
                    local nextPt = coords[i+1]
                    local okLine, lineObj = pcall(function()
                        local l = Drawing.new("Line")
                        l.From = pt
                        l.To = nextPt
                        l.Color = color
                        l.Thickness = 3
                        l.Transparency = 0.7
                        l.Visible = true
                        l.ZIndex = 2999
                        return l
                    end)
                    if okLine and lineObj then
                        table.insert(debugDrawings, lineObj)
                    end
                end
            end
        end
    end
end

-- 8. Fallback Execution: Solve using the ScreenGui and mouse drag emulation
local function solveActiveGuiPuzzle(gui, innerFrame, flowTable)
    local grid, height, width = parseGrid(innerFrame)
    if not grid or height == 0 or width == 0 then
        warn("[PowerPlantSolver] Fallback: Failed to parse grid layout")
        return false
    end
    
    print(string.format("[PowerPlantSolver] GUI Fallback: Grid detected (%dx%d)", width, height))
    
    -- Extract endpoints and map GUI numbers to internal 1-based IDs
    local pairsList = {}
    local pairMap = {}
    local nextInternalId = 1
    
    for r = 1, height do
        for c = 1, width do
            local label = grid[r][c]
            local num = getCellNumber(label)
            if num then
                local p = pairMap[num]
                if not p then
                    p = {guiId = num, id = nextInternalId, startPos = {r = r, c = c}}
                    nextInternalId = nextInternalId + 1
                    pairMap[num] = p
                    table.insert(pairsList, p)
                else
                    p.endPos = {r = r, c = c}
                end
            end
        end
    end
    
    -- Verification checks
    for _, p in ipairs(pairsList) do
        if not p.endPos then
            warn("[PowerPlantSolver] Fallback: Missing endpoint for pair: " .. tostring(p.guiId))
            return false
        end
    end
    
    local gridMatrix = {}
    local paths = solvePuzzle(gridMatrix, height, width, pairsList)
    if not paths then
        warn("[PowerPlantSolver] Fallback: No solution found with fill constraints. Retrying without fill constraints...")
        _G.MustFillAllCells = false
        paths = solvePuzzle(gridMatrix, height, width, pairsList)
        _G.MustFillAllCells = true -- reset
        
        if not paths then
            warn("[PowerPlantSolver] Fallback: No solution possible.")
            return false
        end
    end
    
    pcall(function()
        drawDebugPath(paths, grid, pairsList)
    end)
    
    local missedPaths = {}
    
    -- Draw solved paths (First Pass)
    for _, p in ipairs(pairsList) do
        local currentGui, _ = findPuzzleGui(true)
        if not currentGui then
            print("[PowerPlantSolver] Puzzle closed during first pass. Aborting.")
            return false
        end
        
        local path = paths[p.id]
        if path then
            local pathLabels = {}
            for _, step in ipairs(path) do
                table.insert(pathLabels, grid[step.r][step.c])
            end
            
            dragPath(gui, pathLabels)
            task.wait(_G.PathDelay or 0.15)
            
            if _G.VerifyDraws then
                task.wait(0.04) -- brief settle wait for GUI texts
                if not verifyPath(p, path, flowTable, pathLabels) then
                    print(string.format("[PowerPlantSolver] Path %d failed verification. Queued for redraw.", p.guiId))
                    table.insert(missedPaths, { p = p, path = path, labels = pathLabels })
                end
            end
        end
    end
    
    -- Second Pass: Redraw any missed paths at the end (retry up to 3 times)
    if _G.VerifyDraws and #missedPaths > 0 then
        local redrawAttempts = 0
        while #missedPaths > 0 and redrawAttempts < 3 do
            local currentGui, _ = findPuzzleGui(true)
            if not currentGui then
                print("[PowerPlantSolver] Puzzle closed during redraw pass. Aborting.")
                return false
            end
            
            redrawAttempts = redrawAttempts + 1
            task.wait(0.2) -- settle delay before redrawing
            
            local stillMissed = {}
            for _, missed in ipairs(missedPaths) do
                local currentGuiInner, _ = findPuzzleGui(true)
                if not currentGuiInner then
                    print("[PowerPlantSolver] Puzzle closed during redraw pass inner. Aborting.")
                    return false
                end
                
                print(string.format("[PowerPlantSolver] Redrawing missed path %d (Attempt %d/3)...", missed.p.guiId, redrawAttempts))
                dragPath(gui, missed.labels)
                task.wait(_G.PathDelay or 0.15)
                
                -- Verify again
                task.wait(0.05)
                if not verifyPath(missed.p, missed.path, flowTable, missed.labels) then
                    table.insert(stillMissed, missed)
                end
            end
            missedPaths = stillMissed
        end
    end
    
    return true
end

-- 9. Primary Execution: Instant Solve by writing directly to game memory
local function solveMemoryPuzzle(flowTable)
    if not flowTable.GridClean or not flowTable.Grid then
        return false
    end
    
    local gridMatrix = flowTable.GridClean
    local height = #gridMatrix
    local width = #gridMatrix[1]
    
    print(string.format("[PowerPlantSolver] Memory Bypass: Grid detected (%dx%d)", width, height))
    
    local pairsList = {}
    local pairMap = {}
    local nextInternalId = 1
    
    for r = 1, height do
        for c = 1, width do
            local val = gridMatrix[r][c]
            if val >= 0 then
                local p = pairMap[val]
                if not p then
                    p = {guiId = val, id = nextInternalId, startPos = {r = r, c = c}}
                    nextInternalId = nextInternalId + 1
                    pairMap[val] = p
                    table.insert(pairsList, p)
                else
                    p.endPos = {r = r, c = c}
                end
            end
        end
    end
    
    -- Verify endpoints
    for _, p in ipairs(pairsList) do
        if not p.endPos then
            warn("[PowerPlantSolver] Memory: Missing endpoint for pair: " .. tostring(p.guiId))
            return false
        end
    end
    
    -- Construct empty grid for solver (0 = empty)
    local solverGrid = {}
    for r = 1, height do
        solverGrid[r] = {}
        for c = 1, width do
            local val = gridMatrix[r][c]
            if val >= 0 then
                solverGrid[r][c] = val + 1
            else
                solverGrid[r][c] = 0
            end
        end
    end
    
    local paths = solvePuzzle(solverGrid, height, width, pairsList)
    if not paths then
        warn("[PowerPlantSolver] Memory: No solution found with fill constraints. Retrying without fill constraints...")
        _G.MustFillAllCells = false
        paths = solvePuzzle(solverGrid, height, width, pairsList)
        _G.MustFillAllCells = true
        
        if not paths then
            warn("[PowerPlantSolver] Memory: No solution possible.")
            return false
        end
    end
    
    -- Reset grid to clean state first
    flowTable:Reset()
    
    -- Write paths directly into game grid state
    for _, p in ipairs(pairsList) do
        local path = paths[p.id]
        if path then
            for _, step in ipairs(path) do
                flowTable.Grid[step.r][step.c] = p.guiId
            end
        end
    end
    
    -- Submit solution by calling game's internal OnConnection function
    if flowTable.OnConnection then
        task.wait(0.02)
        local success, err = pcall(function()
            flowTable.OnConnection()
        end)
        if not success then
            warn("[PowerPlantSolver] Memory: OnConnection execution failed: " .. tostring(err))
            return false
        end
    else
        warn("[PowerPlantSolver] Memory: OnConnection function is missing.")
        return false
    end
    
    -- Close GUI
    task.wait(0.02)
    pcall(function()
        flowTable:Hide()
    end)
    
    return true
end

-- Background pre-scan for flowTable at script startup (runs while player walks to terminal)
task.spawn(function()
    task.wait(1.0)
    if currentSolver.Running then
        print("[PowerPlantSolver] Running background GC pre-scan...")
        local flowTable = getPuzzleFlowTable(true)
        if flowTable then
            _G.MemoryAvailable = true
            print("[PowerPlantSolver] Pre-scan complete: Memory mode available.")
        else
            _G.MemoryAvailable = false
            print("[PowerPlantSolver] Pre-scan complete: Memory mode unavailable. Defaulting to instant GUI fallback.")
        end
    end
end)

-- 10. Core Solver Trigger: Solves either via memory bypass or GUI fallback
local lastIsOpen = false
local UserInputService = game:GetService("UserInputService")

local function triggerSolve()
    if _G.Solving then return false end
    
    sendNotification("Power Plant Solver", "Solving puzzle...")
    
    local solved = false
    
    -- Query the flowTable ONCE here to prevent repetitive getgc scans (if memory mode is available)
    local flowTable = nil
    if _G.InstantSolve and _G.MemoryAvailable ~= false then
        flowTable = getPuzzleFlowTable(false)
        if not flowTable then
            _G.MemoryAvailable = false
            print("[PowerPlantSolver] Memory hook check: flowTable NOT found in GC. Disabling memory mode scans.")
        end
    elseif _G.InstantSolve then
        print("[PowerPlantSolver] Memory hook check: flowTable NOT found in GC (cached).")
    end
    
    -- 1. Try memory solve first
    if _G.InstantSolve and flowTable then
        local isOpen = flowTable.IsOpen
        print("[PowerPlantSolver] Memory hook check: flowTable found, IsOpen=" .. tostring(isOpen))
        if isOpen then
            _G.Solving = true
            task.wait(0.02)
            
            local success, err = pcall(function()
                return solveMemoryPuzzle(flowTable)
            end)
            
            if success and err then
                sendNotification("Power Plant Solver", "Puzzle solved instantly via memory bypass!")
                solved = true
            else
                warn("[PowerPlantSolver] Memory solve failed/errored: " .. tostring(err or "Returned false"))
            end
            _G.Solving = false
        end
    end
    
    -- 2. Fallback to GUI solve if not solved
    if not solved then
        local gui, innerFrame = findPuzzleGui(true)
        local isVisible = (gui ~= nil)
        print(string.format("[PowerPlantSolver] GUI check: FlowGui found=%s, Visible=%s", tostring(gui ~= nil), tostring(isVisible)))
        
        if isVisible then
            _G.Solving = true
            task.wait(0.01) -- minimal settle delay
            
            -- Auto-reset
            local resetBtn = gui.Board:FindFirstChild("Reset")
            if resetBtn then
                print("[PowerPlantSolver] Resetting board before GUI solving...")
                clickButton(resetBtn)
                task.wait(0.05) -- reduced delay after click
            end
            
            local success, err = pcall(function()
                return solveActiveGuiPuzzle(gui, innerFrame, flowTable)
            end)
            
            if success and err then
                sendNotification("Power Plant Solver", "Puzzle solved via GUI simulation fallback!")
                solved = true
            else
                warn("[PowerPlantSolver] GUI fallback solve failed/errored: " .. tostring(err or "Returned false"))
                sendNotification("Power Plant Solver", "Failed to solve puzzle.")
            end
            _G.Solving = false
        else
            printGuiHierarchy() -- Print PlayerGui diagnostics if GUI not found
        end
    end
    
    if not solved then
        sendNotification("Power Plant Solver", "No active puzzle GUI or state found.")
    end
    
    return solved
end

-- Connect Keybind Trigger
local keybindConn = nil
if UserInputService and UserInputService.InputBegan then
    pcall(function()
        keybindConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not currentSolver.Running then return end
            
            local keyVal = 0
            local keyName = ""
            
            -- Robust extraction of Name and Value from KeyCode to support all executor types
            pcall(function()
                if input.KeyCode then
                    keyVal = input.KeyCode.Value or tonumber(input.KeyCode) or 0
                    inputKeyName = input.KeyCode.Name or ""
                end
            end)
            if type(keyVal) ~= "number" then keyVal = 0 end
            if type(keyName) ~= "string" then keyName = "" end
            
            if keyName == "" and input.KeyCode then
                local str = tostring(input.KeyCode)
                keyName = str:match("([^.]+)$") or str
            end
            
            -- Resolve VK mapping for keyName
            local resolvedVk = 0
            if keyName ~= "" and VK_MAP[keyName] then
                resolvedVk = VK_MAP[keyName]
            end
            
            -- Diagnostic log to trace key presses
            if keyVal ~= 0 then
                print(string.format("[PowerPlantSolver] Input detected key: 0x%X (Name: %s, Target SolveKey: 0x%X, resolvedVk: 0x%X)", keyVal, keyName, _G.SolveKey, resolvedVk))
            end
            
            -- Trigger solve if raw key code or mapped key name matches the configured SolveKey
            if keyVal == _G.SolveKey or (resolvedVk ~= 0 and resolvedVk == _G.SolveKey) then
                print("[PowerPlantSolver] Solve hotkey matched! Triggering solve...")
                triggerSolve()
            end
        end)
        trackConnection(keybindConn)
    end)
end

-- Helper to locate Rayfield ScreenGui in CoreGui, gethui, or PlayerGui
-- Helper to verify if the Rayfield UI is active (works for both standard ScreenGui and Drawing-based rayfield_matcha)
local function isUiActive()
    -- 1. Check if it's the Drawing UI (rayfield_matcha)
    if _G.__Rayfield then
        return true
    end
    
    -- 2. Check if it's the ScreenGui UI (standard Rayfield)
    local name = "Rayfield"
    local gethuiFn = (getgenv and getgenv().gethui) or gethui
    if gethuiFn then
        local gui = nil
        pcall(function() gui = gethuiFn():FindFirstChild(name) end)
        if gui then return true end
    end
    
    local coreGui = game:GetService("CoreGui")
    if coreGui then
        local gui = nil
        pcall(function() gui = coreGui:FindFirstChild(name) end)
        if gui then return true end
        
        local robloxGui = nil
        pcall(function() robloxGui = coreGui:FindFirstChild("RobloxGui") end)
        if robloxGui then
            local gui2 = nil
            pcall(function() gui2 = robloxGui:FindFirstChild(name) end)
            if gui2 then return true end
        end
    end
    
    local player = game:GetService("Players").LocalPlayer
    local playerGui = player and player:FindFirstChild("PlayerGui")
    if playerGui then
        local gui = playerGui:FindFirstChild(name)
        if gui then return true end
    end
    
    return false
end

local uiLoaded = false

-- Loop Runner for Auto-Solve Mode (Safe polling with 0% CPU footprint)
task.spawn(function()
    task.wait(1.5) -- wait for game variables/GC to settle
    if currentSolver.Running then
        sendNotification("Power Plant Solver", "Auto-solver active. Awaiting puzzle terminal...")
    end
    
    local lastIsOpen = false
    local lastUiCheck = 0
    while currentSolver.Running do
        task.wait(0.05) -- Check 20 times a second (extremely lightweight, instant detection!)
        if not currentSolver.Running then break end
        
        -- Check UI presence every 0.5 seconds to force-stop background threads if UI is deleted
        local now = os.clock()
        if now - lastUiCheck > 0.5 then
            lastUiCheck = now
            if uiLoaded and not isUiActive() then
                print("[PowerPlantSolver] Rayfield UI destroyed/not found. Force stopping background solver.")
                currentSolver:Unload()
                break
            end
        end
        
        local gui, innerFrame = findPuzzleGui(true) -- only returns active GUI
        local isOpen = (gui ~= nil)
        if not isOpen then
            pcall(clearDebugVisuals)
        end
        
        if _G.AutoSolve and isOpen and not lastIsOpen then
            task.wait(0.02) -- minimal delay before starting solve
            if currentSolver.Running then
                triggerSolve()
            end
        end
        lastIsOpen = isOpen
    end
end)

--// Rayfield UI Initialization
local Rayfield = nil
local isMatcha = (getGlobal("mousemoveabs") ~= nil)

if isMatcha then
    -- Always load rayfield_matcha from GitHub for universal compatibility
    local ok, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/huoadf/jailbreak/main/rayfield_matcha/rayfield_matcha.lua"))()
        Rayfield = _G.Rayfield
    end)
    if not ok or not Rayfield then
        warn("[PowerPlantSolver] Failed to load rayfield_matcha from GitHub on Matcha: " .. tostring(err))
    end
end

-- Fallback to online Rayfield if not loaded yet (or if on standard Roblox)
if not Rayfield then
    local ok, err = pcall(function()
        Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)
    if not ok or not Rayfield then
        warn("[PowerPlantSolver] Failed to load online Rayfield: " .. tostring(err))
        
        -- Last resort fallback to rayfield_matcha from GitHub
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/huoadf/jailbreak/main/rayfield_matcha/rayfield_matcha.lua?t=" .. os.time()))()
            Rayfield = _G.Rayfield
        end)
    end
end

if Rayfield then
    local toggleKey = _G.UIToggleKey or "RightControl"
    local Window = Rayfield:CreateWindow({
        Name = "Jailbreak Power Plant Solver",
        LoadingTitle = "Power Plant Solver",
        LoadingSubtitle = "Matcha Auto-Solver",
        Theme = "Default",
        ToggleUIKeybind = VK_MAP[toggleKey] or VK_MAP["RightControl"],
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "MatchaConfigs",
            FileName = "PowerPlantSolver"
        }
    })
    
    -- The library's own render loop handles the toggle natively via ck(State.ToggleKey).
    -- We only need to sync the chosen key into State.ToggleKey — no second polling loop needed.
    local uiToggleVK = VK_MAP["RightControl"] -- default VK code

    local function updateUIToggleKeybind(newKey)
        -- Safely convert to string name (e.g. "RightControl")
        local keyStr = tostring(newKey)
        pcall(function()
            if typeof(newKey) == "EnumItem" or type(newKey) == "table" or type(newKey) == "userdata" then
                keyStr = newKey.Name or keyStr
            end
        end)
        if keyStr:find("%.") then
            keyStr = keyStr:match("([^.]+)$") or keyStr
        end

        toggleKey = keyStr
        _G.UIToggleKey = keyStr

        -- Resolve to VK code and push it into the library
        local vk = VK_MAP[keyStr]
        if vk then
            uiToggleVK = vk
        end

        -- Primary: SetToggleKey method
        pcall(function()
            if _G.Rayfield and _G.Rayfield.SetToggleKey then
                _G.Rayfield:SetToggleKey(uiToggleVK)
            end
        end)
        -- Fallback: write directly into exposed State table
        pcall(function()
            if _G.__RayfieldState then
                _G.__RayfieldState.ToggleKey = uiToggleVK
            end
        end)

        print("[PowerPlantSolver] UI Toggle key -> " .. keyStr .. " (VK 0x" .. string.format("%X", uiToggleVK) .. ")")
    end

    updateUIToggleKeybind(toggleKey)

    
    -- Method to unload script resources safely
    function currentSolver:Unload()
        if not self.Running then return end
        self.Running = false
        
        pcall(clearDebugVisuals)
        
        -- Disconnect game connections
        for _, conn in ipairs(self.Connections) do
            pcall(function() conn:Disconnect() end)
        end
        table.clear(self.Connections)
        
        -- Destroy Rayfield UI Window
        pcall(function()
            if Rayfield then
                Rayfield:Destroy()
            end
        end)
        
        print("[PowerPlantSolver] Script successfully unloaded and cleaned up.")
    end

    -- Tab Creation
    local SolverTab = Window:CreateTab("Solver", "sliders-horizontal")
    local SettingsTab = Window:CreateTab("Settings", "settings")
    local ConfigTab = Window:CreateTab("Config", "folder-open")
    
    -- 1. Solver Tab
    SolverTab:CreateSection("Core Features")
    
    SolverTab:CreateToggle({
        Name = "Auto Solve",
        CurrentValue = _G.AutoSolve,
        Flag = "AutoSolve",
        Callback = function(val)
            _G.AutoSolve = val
            if val then
                local gui = findPuzzleGui(true)
                if gui and not _G.Solving then
                    task.spawn(triggerSolve)
                end
            end
        end
    })
    
    SolverTab:CreateButton({
        Name = "Trigger Manual Solve",
        Callback = function()
            triggerSolve()
        end
    })
    
    SolverTab:CreateKeybind({
        Name = "Solve Hotkey",
        CurrentKeybind = "V",
        Flag = "SolveHotkey",
        CallOnChange = true,
        Callback = function(key)
            pcall(function()
                local keyStr = tostring(key)
                local vkCode = VK_MAP[keyStr]
                if vkCode then
                    _G.SolveKey = vkCode
                    print("[PowerPlantSolver] Solve Keybind changed to: " .. keyStr .. " (VK: " .. string.format("0x%X", vkCode) .. ")")
                else
                    warn("[PowerPlantSolver] Keybind mapping not found in VK_MAP for: " .. tostring(keyStr))
                end
            end)
        end
    })
    
    SolverTab:CreateKeybind({
        Name = "UI Toggle Hotkey",
        CurrentKeybind = _G.UIToggleKey or "RightControl",
        Flag = "UIToggleHotkey",
        CallOnChange = true,
        Callback = function(key)
            updateUIToggleKeybind(key)
        end
    })
    
    -- 2. Settings Tab
    SettingsTab:CreateSection("Timings & Speeds")
    
    SettingsTab:CreateSlider({
        Name = "Drag Speed (Cell Delay)",
        Range = {0, 300},
        Increment = 5,
        Suffix = " ms",
        CurrentValue = math.floor(_G.SolveDelay * 1000),
        Flag = "SolveDelay",
        Callback = function(val)
            _G.SolveDelay = val / 1000
        end
    })
    
    SettingsTab:CreateSlider({
        Name = "Path Delay (Delay between lines)",
        Range = {0, 500},
        Increment = 10,
        Suffix = " ms",
        CurrentValue = math.floor(_G.PathDelay * 1000),
        Flag = "PathDelay",
        Callback = function(val)
            _G.PathDelay = val / 1000
        end
    })
    
    SettingsTab:CreateSection("Automation Options")
    
    SettingsTab:CreateToggle({
        Name = "Use Physical Mouse (OSMouse)",
        CurrentValue = _G.UseOSMouse,
        Flag = "UseOSMouse",
        Callback = function(val)
            _G.UseOSMouse = val
        end
    })
    
    SettingsTab:CreateToggle({
        Name = "Instant Memory Solve (Bypass)",
        CurrentValue = _G.InstantSolve,
        Flag = "InstantSolve",
        Callback = function(val)
            _G.InstantSolve = val
        end
    })
    
    SettingsTab:CreateToggle({
        Name = "Force Fill All Cells",
        CurrentValue = _G.MustFillAllCells,
        Flag = "MustFillAllCells",
        Callback = function(val)
            _G.MustFillAllCells = val
        end
    })
    
    SettingsTab:CreateToggle({
        Name = "Verify & Redraw Missed Paths",
        CurrentValue = _G.VerifyDraws,
        Flag = "VerifyDraws",
        Callback = function(val)
            _G.VerifyDraws = val
        end
    })
    
    SettingsTab:CreateSection("OSMouse Calibration")
    
    SettingsTab:CreateSlider({
        Name = "Mouse X Offset (Horizontal)",
        Range = {-100, 100},
        Increment = 1,
        Suffix = " px",
        CurrentValue = _G.MouseOffsetX,
        Flag = "MouseOffsetX",
        Callback = function(val)
            _G.MouseOffsetX = val
        end
    })
    
    SettingsTab:CreateSlider({
        Name = "Mouse Y Offset (Vertical)",
        Range = {-100, 100},
        Increment = 1,
        Suffix = " px",
        CurrentValue = _G.MouseOffsetY,
        Flag = "MouseOffsetY",
        Callback = function(val)
            _G.MouseOffsetY = val
        end
    })
    
    SettingsTab:CreateToggle({
        Name = "Show Debug Path Visuals",
        CurrentValue = _G.ShowDebugVisuals,
        Flag = "ShowDebugVisuals",
        Callback = function(val)
            _G.ShowDebugVisuals = val
            if not val then
                pcall(clearDebugVisuals)
            end
        end
    })
    
    -- 3. Config Tab
    ConfigTab:CreateSection("Configuration Files")
    
    local customConfigName = "PowerPlantSolver"
    ConfigTab:CreateInput({
        Name = "Configuration Name",
        PlaceholderText = "Enter filename...",
        Flag = "ConfigFileName",
        Callback = function(text)
            if text and text ~= "" then
                customConfigName = text
                pcall(function()
                    Rayfield.ConfigFileName = text
                end)
            end
        end
    })
    
    ConfigTab:CreateButton({
        Name = "Save Current Config",
        Callback = function()
            pcall(function()
                Rayfield:SaveConfiguration()
                Rayfield:Notify({
                    Title = "Config Saved",
                    Content = "Successfully saved config: " .. customConfigName,
                    Duration = 3
                })
            end)
        end
    })
    
    ConfigTab:CreateButton({
        Name = "Load Current Config",
        Callback = function()
            pcall(function()
                Rayfield:LoadConfiguration()
            end)
        end
    })
    
    ConfigTab:CreateSection("Cleanup")
    
    ConfigTab:CreateButton({
        Name = "Unload Script (Safely Close)",
        Callback = function()
            currentSolver:Unload()
            pcall(function()
                Rayfield:Notify({
                    Title = "Script Unloaded",
                    Content = "Auto-solver connections disconnected successfully.",
                    Duration = 3
                })
            end)
        end
    })
    
    Rayfield:Notify({
        Title = "Power Plant Solver Loaded",
        Content = "Auto-solver UI is ready. Press [" .. toggleKey .. "] to toggle menu.",
        Duration = 4
    })
else
    warn("[PowerPlantSolver] Could not load Rayfield UI library.")
    
    -- Fallback unload function if UI failed to load
    function currentSolver:Unload()
        self.Running = false
        pcall(clearDebugVisuals)
        for _, conn in ipairs(self.Connections) do
            pcall(function() conn:Disconnect() end)
        end
        table.clear(self.Connections)
        print("[PowerPlantSolver] Script successfully unloaded (UI Fallback).")
    end
end

uiLoaded = true
