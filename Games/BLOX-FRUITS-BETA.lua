local unpackValues = unpack or table.unpack
local scriptArgs = { ... }
local userConfig = scriptArgs[2]
local loader = scriptArgs[1]
local config = userConfig or {
	JoinTeam = "Pirates",
	Translator = true
}
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalizationService = game:GetService("LocalizationService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local CurrentCamera = workspace.CurrentCamera
local Stepped = RunService.Stepped
local LocalPlayer = Players.LocalPlayer
local Data = LocalPlayer:WaitForChild("Data")
Data:WaitForChild("LastSpawnPoint")
Data:WaitForChild("SpawnPoint")
local Fragments = Data:WaitForChild("Fragments")
local Subclass = Data:WaitForChild("Subclass")
local FruitCap = Data:WaitForChild("FruitCap")
local Level = Data:WaitForChild("Level")
local Beli = Data:WaitForChild("Beli")
local Map = workspace:WaitForChild("Map")
local NPCs = workspace:WaitForChild("NPCs")
local Boats = workspace:WaitForChild("Boats")
local SeaBeasts = workspace:WaitForChild("SeaBeasts")
local Enemies = workspace:WaitForChild("Enemies")
local Characters = workspace:WaitForChild("Characters")
local _WorldOrigin = workspace:WaitForChild("_WorldOrigin")
local Locations = _WorldOrigin:WaitForChild("Locations")
_WorldOrigin:WaitForChild("PlayerSpawns")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local _ENV = (getgenv or getrenv or getfenv)()
local _ = game.HttpGet
local tbl = {}
local enabledOptionsStore = {}
local rzFunctions = _ENV.rz_Functions or {}
local rzFarmFunctions = _ENV.rz_FarmFunctions or {}
local rz_Settings = _ENV.rz_Settings
if not rz_Settings then
    local new = Vector3.new
    rz_Settings = {
		AutoBuso = true,
		BringMobs = true,
		BringDistance = 250,
		FarmMode = "Up",
		FarmTool = "Melee",
		FarmDistance = 15,
		FarmPos = new(0, 15, 0),
		SeaSkills = {},
		boatSelected = {},
		fishSelected = {}
	}
end
local settings = rz_Settings
local rz_EnabledOptions = _ENV.rz_EnabledOptions
if not rz_EnabledOptions then
    rz_EnabledOptions = setmetatable({}, {
		__newindex = function(_, arg2, arg3)
        rawset(enabledOptionsStore, arg2, arg3 or nil)
        table.clear(rzFarmFunctions)

        for _, v in ipairs(rzFunctions) do
            if rawget(enabledOptionsStore, v.Name) then
                table.insert(rzFarmFunctions, v)
            end
        end
    end,
		__index = enabledOptionsStore
	})
end
local enabledOptions = rz_EnabledOptions
local PlayerGui = LocalPlayer.PlayerGui
if not LocalPlayer.Team and not LocalPlayer:FindFirstChild("Main") then
    local num3 = 0

    while not LocalPlayer.Team and not LocalPlayer:FindFirstChild("Main") do
        if tick() - num3 >= 0.5 then
            pcall(function(arg1)
                local ChooseTeam = PlayerGui["Main (minimal)"]:WaitForChild("ChooseTeam")
                local findResult = arg1:find("pirate")
                local result2 = getconnections(ChooseTeam.Container[not findResult and "Marines" or "Pirates"].Frame.TextButton.Activated)

                for i = 1, #result2 do
                    result2[i].Function()
                end
            end, string.lower(config.JoinTeam or "Pirates"))
            num3 = tick()
        end

        task.wait()
    end
end
_ENV.rz_Functions = rzFunctions
_ENV.rz_Settings = settings
_ENV.rz_EnabledOptions = enabledOptions
_ENV.rz_FarmFunctions = rzFarmFunctions
local connections = rz_connections or {}
_ENV.rz_connections = connections
for _, v in ipairs(connections) do
    v:Disconnect()
end
table.clear(connections)
local library
local Module
local MoveCharacter
local tbl2 = {
	Marines = function()
    Module.FireRemote("SetTeam", "Marines")
end,
	Pirates = function()
    Module.FireRemote("SetTeam", "Pirates")
end
}
local tbl3 = {}
local function getTaggedList(arg12)
    local taggedList = CollectionService:GetTagged(arg12)

    table.insert(connections, CollectionService:GetInstanceAddedSignal(arg12):Connect(function(arg13)
        table.insert(taggedList, arg13)
    end))

    return taggedList
end
tbl3.Chests = getTaggedList("_ChestTagged")
tbl3.Berries = getTaggedList("BerryBush")
local tbl4 = {
	AllCodes = function()
    local result3 = loader.get("{Utils}BloxFruits/Codes.txt")
    local parts = string.split(string.gsub(result3, "\n", ""), "~")

    for i = 1, #parts do
        Remotes.Redeem:InvokeServer(parts[i])
    end
end,
	GetTimer = function(arg14)
    local floor2 = math.floor(arg14)
    local floor3 = math.floor(arg14 / 60)
    local floor4 = math.floor(arg14 / 60 / 60) * 60
    local val = floor2 - floor3 * 60
    local val2 = floor3 - floor4

    return (val2 < 10 and "0" .. tostring(val2) or val2) .. ":" .. (val < 10 and "0" .. tostring(val) or val)
end
}
local Core2 = {
	Managers = {}
}
local Managers = Core2.Managers
function Managers.TweenManager()
    local tbl5 = {
		QueueNumber = 1,
		InDebounce = false
	}
    local tweenModule = Module.RunFunctions.TweenModule()
    local tbl6 = {
		["Sky Island 1"] = Vector3.new(-4652, 873, -1754),
		["Sky Island 2"] = Vector3.new(-7895, 5547, -380),
		["Under Water Island"] = Vector3.new(61164, 15, 1820),
		["Under Water Island Entrace"] = Vector3.new(3865, 20, -1926)
	}
    local tbl7 = {
		["Flamingo Mansion"] = Vector3.new(-317, 331, 597),
		["Flamingo Room"] = Vector3.new(2283, 15, 867),
		["Cursed Ship"] = Vector3.new(923, 125, 32853),
		["Zombie Island"] = Vector3.new(-6509, 83, -133)
	}
    local vector3 = Vector3.new(-12464, 376, -7566)
    local vector3_2 = Vector3.new(5651, 1015, -350)
    local vector3_3 = Vector3.new(28286, 14897, 103)
    local vector3_4 = Vector3.new(-5090, 319, -3146)
    local vector3_5 = Vector3.new(2953, 2282, -7217)
    local val3 = ({
		tbl6,
		tbl7,
		{
			Mansion = vector3,
			["Hydra Island"] = vector3_2,
			["Temple of Time"] = vector3_3,
			["Sea Castle"] = vector3_4,
			["Great Tree"] = vector3_5
		}
	})[Module.GameData.Sea]
    local Unlocked = Module.Inventory.Unlocked
    local Sea = Module.GameData.Sea
    local IsAlive = Module.IsAlive
    local FireRemote = Module.FireRemote
    local Tween = Module.Tween
    local num4 = 0
    local num5 = 0
    local val4
    local p16Position
    local val5
    local cFrame = CFrame.new(28610, 14897, 105)
    local vector = Vector3.yAxis * -25.2
    local function helper(arg15)
        if Entarce == "Spawn Point" then
            return not LocalPlayer.Character:GetAttribute("InCombat")
        end

        local val6 = Sea == 3

        if val6 then
            val6 = arg15 == "Hydra Island"

            if not val6 then
                val6 = arg15 == "Sea Castle" or arg15 == "Mansion"
            end
        end

        if val6 then
            return Unlocked["Valkyrie Helm"]
        end

        if Sea == 2 then
            if arg15 == "Flamingo Mansion" or arg15 == "Flamingo Room" then
                return Unlocked["Swan Glasses"] or Level.Value >= 1750
            end

            if arg15 == "Zombie Island" or arg15 == "Cursed Ship" then
                return Level.Value >= 1000
            end
        end

        return true
    end
    local function helper2(arg16)
        local val7
        local huge = math.huge
        local val8
        for k, v in pairs(val3) do
            local val9 = k

            if helper(val9) then
                local Magnitude = (arg16 - v).Magnitude

                if Magnitude < huge then
                    huge = Magnitude
                    val8 = v
                    val7 = val9
                end
            end
        end

        return val8, val7
    end
    local function helper3()
        tbl5.MoveCharacter(cFrame, nil, true)
        tbl5:InteractWithNpc(cFrame, "RaceV4Progress", "TeleportBack")
    end
    local function helper4()
        local val10 = tbl5

        tbl5.QueueNumber = tbl5.QueueNumber + 1
        val10.InDebounce = false
    end
    function tbl5.GetLastPosition(_)
        return p16Position
    end
    function tbl5.TweenToCFrameQueue(self3, arg22, arg32)
        if not IsAlive(LocalPlayer.Character) then
            return false
        end

        if self3.InDebounce and arg22[self3.QueueNumber] then
            return MoveCharacter(arg22[self3.QueueNumber] + vector)
        end

        if #arg22 == 1 then
            self3.MoveCharacter(arg22[1], arg32)

            return
        end

        if #arg22 > 1 then
            if self3.QueueNumber > #arg22 then
                self3.QueueNumber = 1
            end

            local PrimaryPart = LocalPlayer.Character.PrimaryPart
            local val11 = arg22[self3.QueueNumber]

            if PrimaryPart and (PrimaryPart.Position - val11.Position).Magnitude < 5 then
                self3.InDebounce = true
                task.delay(0.8, helper4)

                return
            end

            self3.MoveCharacter(val11, arg32)
        end
    end
    function tbl5.InteractWithNpc(_, arg23, ...)
        if LocalPlayer:DistanceFromCharacter(arg23.Position) < 5 then
            return FireRemote(...)
        end
    end
    function tbl5.MoveCharacter(arg17, arg24, arg33, arg4)
        if not IsAlive(LocalPlayer.Character) or not LocalPlayer.Character.PrimaryPart then
            return false
        end

        if tick() - num5 <= 1 and arg17 == val4 then
            return false
        end

        if not arg33 then
            p16Position = arg17.Position
        end

        local Character = LocalPlayer.Character
        local Humanoid = Character.Humanoid
        local PrimaryPart = Character.PrimaryPart

        if Humanoid.Sit then
            Humanoid.Sit = false

            return
        end

        if PrimaryPart.Anchored then
            tweenModule:stopTween(PrimaryPart)

            return
        end

        num5 = tick()
        val4 = arg17
        _ENV.OnFarm = true

        local val12 = settings.TweenSpeed or 220
        local p16Position2 = arg17.Position
        local Magnitude = (PrimaryPart.Position - p16Position2).Magnitude

        if Magnitude < (not arg24 and 120 or 10) then
            PrimaryPart.CFrame = arg17

            return tweenModule:stopTween(PrimaryPart)
        end

        if Character:FindFirstChild("TempSafeZone") then
            return tweenModule:stopTween(PrimaryPart)
        end

        local val13, val14 = helper2(p16Position2)

        if val13 and (val13 < Magnitude and (p16Position2 - val13).Magnitude + 300) then
            if val14 == "Great Tree" then
                return helper3()
            end

            if tick() - num4 >= 6 or val14 ~= val5 then
                tweenModule:stopTween(PrimaryPart)
                task.wait(0.2)

                local val15 = if not ((p16Position2 - val13).Magnitude < 50) then val13 + (p16Position2 - PrimaryPart.Position).Unit * 40 else p16Position2

                val5 = val14
                num4 = tick()

                return FireRemote("requestEntrance", val15)
            end
        end

        if arg24 then
            return tweenModule.new(PrimaryPart, Magnitude / arg24, "CFrame", arg17)
        end

        if not arg4 then
            local PrimaryPartPosition = PrimaryPart.Position
            local cFrame2 = CFrame.new(PrimaryPartPosition.X, p16Position2.Y, PrimaryPartPosition.Z)

            if (PrimaryPartPosition - cFrame2.Position).Magnitude > 75 then
                tweenModule:stopTween(PrimaryPart)
                task.wait(0.1)
                PrimaryPart.CFrame = cFrame2
                task.wait(0.5)
            end
        end

        if Magnitude < 380 then
            tweenModule.new(PrimaryPart, Magnitude / (val12 * 2), "CFrame", arg17)

            return
        end

        tweenModule.new(PrimaryPart, Magnitude / val12, "CFrame", arg17)
    end
    table.insert(connections, Tween:GetPropertyChangedSignal("Parent"):Connect(function()
        if not Tween.Parent and IsAlive(LocalPlayer.Character) then
            local Character = LocalPlayer.Character
            local FindFirstChild = Character.FindFirstChild

            tweenModule:stopTween(FindFirstChild(Character, "HumanoidRootPart"))
        end
    end))
    MoveCharacter = tbl5.MoveCharacter

    return tbl5
end
function Managers.QuestManager()
    local Sea = Module.GameData.Sea
    local cFrame = CFrame.new(0, 0, 2.5)
    local tbl8 = {
		QuestList = {},
		EnemyList = {},
		QuestPos = {},
		Sea = Sea,
		takeQuestDebounce = false,
		_Position = cFrame
	}
    local Quest = LocalPlayer.PlayerGui:WaitForChild("Main").Quest
    local QuestTitleTitle = Quest.Container.QuestTitle.Title
    local GuideModule = ReplicatedStorage:WaitForChild("GuideModule")
    local Quests = ReplicatedStorage:WaitForChild("Quests")
    local tbl9 = {
		GuideModule = GuideModule,
		Quests = Quests
	}

    local function helper5(arg18)
        local ok, result = pcall(function()
            return require(tbl9[arg18])
        end)

        if not ok then
            warn(("falha a o carregar Module [ %s ] [ %s ]").format("falha a o carregar Module [ %s ] [ %s ]", arg18, result))
        end

        return ok and result or fetcher.load("{Utils}BloxFruits/GameModules/" .. arg18 .. ".lua")()
    end

    local result4 = helper5("GuideModule")
    local result5 = helper5("Quests")
    local EnemyLocations = Module.EnemyLocations
    local _ = Module.EnemySpawned
    local IsBoss = Module.IsBoss

    task.spawn(function()
        if result4.Data.IsFakeData then
            return nil
        end

        for _, v in pairs(result4.Data.NPCList) do
            tbl8.QuestPos[v.NPCName] = CFrame.new(v.Position)
        end

        setmetatable(result4.Data.NPCList, {
			__newindex = function(arg19, arg25, arg34)
            tbl8.QuestPos[arg34.NPCName] = CFrame.new(arg34.Position)

            return (rawset(arg19, arg25, arg34))
        end
		})
    end)
    task.spawn(Module.RunFunctions.Quests, tbl8, result5, function(arg110)
        local tbl10 = {}
        local tbl11 = {}
        local _next = next
        local Task = arg110.Task
        local val16
        while true do
            local val17

            val16, val17 = _next(Task, val16)

            if not val16 then
                break
            end

            tbl11 = EnemyLocations[val16] or {}
            EnemyLocations[val16] = tbl11
            table.insert(tbl10, val16)
        end

        return tbl10, tbl11
    end)

    function tbl8.GetQuest(self4)
        if self4.oldLevel == Level.Value and self4.CurrentQuest then
            if self4.oldBoss and Module.Enemies.IsSpawned(self4.oldBoss) then
                return self4.oldBossQuest
            end

            return self4.CurrentQuest
        end
        local val18
        local val19
        local val20
        self4.oldLevel = Level.Value
        local Sea2 = self4.Sea
        local clamp = math.clamp
        local LevelValue = Level.Value
        local val21 = Sea2 == 1 and 700
        if not val21 then
            val21 = if Sea2 ~= 2 then Level.Value else 1500
        end
        local result6 = clamp(LevelValue, 0, val21)
        for _, v in ipairs(self4.QuestList) do
            local Level2 = v.Enemy.Level
            local val22 = v.Enemy.Name[1]

            if not IsBoss(val22) then
                if result6 < Level2 then
                    self4.oldBoss = val18
                    self4.oldBossQuest = val20
                    self4.CurrentQuest = val19

                    return val19
                end

                val19 = v

                continue
            end

            val18 = Level2 <= result6 and (Level2 >= result6 - 50 and val22)
            val20 = v
        end
        self4.oldBoss = val18
        self4.oldBossQuest = val20
        self4.CurrentQuest = val19

        return val19
    end
    function tbl8.GetQuestPosition(self5, arg26)
        if result4.Data.IsFakeData then
            local val23 = result4.Data.NPCs[arg26]

            if val23 then
                val23 = NPCs:FindFirstChild(val23) or ReplicatedStorage.NPCs:FindFirstChild(val23)
            end

            return val23 and val23:GetPivot()
        end

        return self5.QuestPos[result4.Data.LastClosestNPC]
    end
    function tbl8.VerifyQuest(_, arg27)
        if not Quest.Visible then
            return false
        end

        local gsub2 = string.gsub(QuestTitleTitle.Text, "-", ""):lower()

        if type(arg27) == "string" then
            return string.find(gsub2, string.gsub(arg27, "-", ""):lower())
        end

        for _, v in ipairs(arg27) do
            if string.find(gsub2, string.gsub(v, "-", ""):lower()) then
                return v
            end
        end
    end
    function tbl8.StartQuest(self6, arg28, arg35, arg42)
        local val24 = arg42

        if arg42 then
            val24 = LocalPlayer:DistanceFromCharacter(arg42.Position) >= 5
        end

        if val24 then
            local val25 = arg42 * self6._Position

            MoveCharacter(val25)

            return "Teleporting to NPC: " .. arg28
        end

        if self6.takeQuestDebounce then
            local flag = not self6.Debounce

            if not flag then
                flag = tick() - self6.Debounce >= 75 or self6.InDebounceQuest ~= arg35 .. arg28
            end

            if flag then
                settings.RunningMethod = "Getting Quest: " .. arg28
                task.wait(0.5)
                Module.FireRemote("StartQuest", arg28, arg35)

                local val26 = arg35 .. arg28
                local timestamp = tick()

                self6.InDebounceQuest = val26
                self6.Debounce = timestamp

                return settings.RunningMethod, task.wait(0.5)
            end

            return "Quest Debounce: " .. tbl4.GetTimer(75 - (tick() - self6.Debounce))
        end

        task.wait(0.5)
        Module.FireRemote("StartQuest", arg28, arg35)

        return "Getting Quest: " .. arg28, task.wait(0.5)
    end

    return tbl8
end
function Managers.FarmManager()
    local vector2 = Vector2.new()
    local tbl12 = {
		CanFarm = {},
		EnemyLocation = {},
		ClickPosition = vector2,
		axisDebounce = 0
	}
    local IsAlive = Module.IsAlive
    local EnemySpawned = Module.EnemySpawned
    local EnemyLocations = Module.EnemyLocations
    local EquipTool = Module.EquipTool
    local num6 = 0

    tbl12.Materials = ({
		{
			"Leather + Scrap Metal",
			"Magma Ore",
			"Fish Tail",
			"Angel Wings"
		},
		{
			"Leather + Scrap Metal",
			"Magma Ore",
			"Mystic Droplet",
			"Radiactive Material",
			"Vampire Fang"
		},
		{
			"Leather + Scrap Metal",
			"Fish Tail",
			"Gunpowder",
			"Mini Tusk",
			"Conjured Cocoa",
			"Dragon Scale"
		}
	})[Module.GameData.Sea]
    tbl12.Enemies = {
		Elites = {
			"Deandre",
			"Diablo",
			"Urban"
		},
		Bones = {
			"Reborn Skeleton",
			"Living Zombie",
			"Demonic Soul",
			"Posessed Mummy"
		},
		Katakuri = {
			"Head Baker",
			"Baking Staff",
			"Cake Guard",
			"Cookie Crafter"
		},
		Ectoplasm = {
			"Ship Deckhand",
			"Ship Engineer",
			"Ship Steward",
			"Ship Officer"
		}
	}
    tbl12.FarmModes = {
		Star = function(arg111, arg29)
        local val27 = arg29.CFrame + arg111:GetNextAxis()

        if LocalPlayer:DistanceFromCharacter(val27.Position) >= 5 then
            MoveCharacter(val27)
        end
    end,
		Orbit = function(_, arg210, arg36)
        local p37Parent = arg210.Parent
        local num7 = 0
        local elapsed = task.wait()
        local RunningOption = settings.RunningOption

        while true do
            local val28 = arg36 or settings.FarmMode == "Orbit"

            if val28 then
                val28 = enabledOptions[RunningOption]

                if val28 then
                    val28 = arg210 and IsAlive(p37Parent)
                end
            end

            if not val28 then
                break
            end

            if tick() - num6 >= 1 then
                EquipTool()
            end

            EnableBuso()

            local FarmDistance = settings.FarmDistance

            num7 += 3.5 * elapsed
            MoveCharacter(CFrame.new(math.cos(num7) * FarmDistance, 8, math.sin(num7) * FarmDistance) + arg210.Position)
            elapsed = task.wait(not settings.SmoothMode and 0 or 0.1)
        end
    end,
		Up = function(_, arg211)
        local val29 = arg211.CFrame + settings.FarmPos

        if LocalPlayer:DistanceFromCharacter(val29.Position) >= 5 then
            MoveCharacter(val29)
        end
    end
	}

    local tbl13 = {}
    local tbl14 = { CFrame.new(-7742, 5634, -1564) }
    local tbl15 = {
		CFrame.new(-1257, 54, 4091),
		CFrame.new(-1100, 77, 1152),
		CFrame.new(-364, 116, 5692)
	}
    local cFrame = CFrame.new(-5408, 11, 8456)
    local tbl16 = { CFrame.new(-5241, 50, -4713) }
    local _CFrame = CFrame
    local tbl17 = {
		cFrame,
		unpackValues(tbl16)
	}
    local tbl18 = {
		_CFrame.new(60931, 19, 1574),
		false,
		CFrame.new(-10679, 398, -8975)
	}
    local tbl19 = {
		false,
		CFrame.new(-3350, 282, -10527)
	}
    local tbl20 = {
		false,
		CFrame.new(-73, 149, -112)
	}
    local tbl21 = { CFrame.new(-6030, 6, -1281) }
    local _CFrame2 = CFrame
    local tbl22 = {
		false,
		unpackValues(tbl21)
	}
    local tbl23 = {
		false,
		false,
		_CFrame2.new(-394, 135, 5981)
	}
    local tbl24 = {
		false,
		false,
		CFrame.new(-13510, 584, -6986)
	}
    local tbl25 = {
		false,
		false,
		CFrame.new(400, 81, -12257)
	}
    local tbl26 = {
		false,
		false,
		CFrame.new(6689, 378, 331)
	}
    local tbl27 = {
		["Angel Wings"] = tbl14,
		["Leather + Scrap Metal"] = tbl15,
		["Magma Ore"] = tbl17,
		["Fish Tail"] = tbl18,
		["Mystic Droplet"] = tbl19,
		["Radiactive Material"] = tbl20,
		["Vampire Fang"] = tbl22,
		Gunpowder = tbl23,
		["Mini Tusk"] = tbl24,
		["Conjured Cocoa"] = tbl25,
		["Dragon Scale"] = tbl26
	}
    local tbl28 = {
		["Leather + Scrap Metal"] = {
			{
				"Pirate",
				"Brute",
				"Scrap Metal",
				"Pirate Millionaire"
			},
			{
				true,
				true,
				true
			}
		},
		["Angel Wings"] = {
			{
				"Royal Soldier",
				"Royal Squad"
			},
			{
				true,
				false,
				false
			}
		},
		["Magma Ore"] = {
			{
				"Military Soldier",
				"Lava Pirate"
			},
			{
				true,
				true,
				false
			}
		},
		["Fish Tail"] = {
			{
				"Fishman Warrior",
				"Fishman Captain",
				"Fishman Raider"
			},
			{
				true,
				false,
				true
			}
		},
		["Conjured Cocoa"] = {
			{
				"Cocoa Warrior",
				"Chocolate Bar Battler"
			},
			{
				false,
				false,
				true
			}
		},
		["Mystic Droplet"] = {
			{ "Water Fighter" },
			{
				false,
				true,
				false
			}
		},
		["Radiactive Material"] = {
			{ "Factory Staff" },
			{
				false,
				true,
				false
			}
		},
		["Vampire Fang"] = {
			{ "Vampire" },
			{
				false,
				true,
				false
			}
		},
		Gunpowder = {
			{ "Pistol Billionaire" },
			{
				false,
				false,
				true
			}
		},
		["Mini Tusk"] = {
			{ "Mythological Pirate" },
			{
				false,
				false,
				true
			}
		},
		["Dragon Scale"] = {
			{ "Dragon Crew Archer" },
			{
				false,
				false,
				true
			}
		}
	}

    function tbl12.ToolDebounce()
        num6 = tick()
    end
    function tbl12.GotoTargetCFrame(arg112)
        MoveCharacter(arg112)
        EnableBuso()
        EquipTool()
    end
    function tbl12.GetNextAxis(self7)
        if tick() - self7.axisDebounce <= 0.4 then
            return self7.nextAxis
        end

        local val30 = Vector3[not (math.random() <= 0.5) and "zAxis" or "xAxis"]
        local random2 = math.random() <= 0.5 and settings.FarmDistance or -settings.FarmDistance
        local vector4 = Vector3.yAxis * 8
        local val31 = val30 * random2 + vector4

        self7.axisDebounce = tick()
        self7.nextAxis = val31

        return val31
    end
    function tbl12.Mastery(_, arg212, arg37)
        local Health = arg37.Health

        for _, child in ipairs(Enemies:GetChildren()) do
            if child.PrimaryPart then
                local Humanoid = child:FindFirstChildOfClass("Humanoid")
                local val32 = Humanoid

                if Humanoid then
                    val32 = Humanoid.Health > 0 and Health >= Humanoid.Health
                end

                if val32 then
                    Health = Humanoid.Health
                    arg37 = Humanoid
                    arg212 = child.PrimaryPart
                end
            end
        end

        local val33 = arg212.CFrame + settings.FarmPos
        local val34 = arg37.Health / arg37.MaxHealth * 100
        local val35 = val34 <= settings.mHealth and settings.mTool or "Melee"

        EquipTool(val35, true)

        local p44Parent = arg212.Parent

        Module:BringEnemies(p44Parent)
        EnableBuso()

        if LocalPlayer:DistanceFromCharacter(val33.Position) >= 2.5 then
            MoveCharacter(val33)
        end

        local val36 = val34 <= settings.mHealth

        if val36 then
            val36 = LocalPlayer:DistanceFromCharacter(val33.Position) < 5
        end

        if val36 then
            Module.Hooking:SetTarget(arg212, arg212.Parent, true)
            Module.UseSkills(arg212, settings.MasterySkills)
        end
    end
    function tbl12.attack(arg113, arg213, arg38, arg43)
        local Humanoid = arg113:FindFirstChild("Humanoid")

        if not Humanoid then
            return nil
        end

        if enabledOptions.Mastery and Humanoid.MaxHealth < 40000 then
            local PrimaryPart = arg113.PrimaryPart

            tbl12:Mastery(PrimaryPart, Humanoid)

            return true
        end

        if arg213 then
            Module:BringEnemies(arg113, arg38)
        end

        if tick() - num6 >= 1 then
            EquipTool()
        end

        EnableBuso()
        tbl12.FarmModes[arg43 or settings.FarmMode](tbl12, arg113.PrimaryPart, arg43)

        local SmoothMode = settings.SmoothMode

        if SmoothMode then
            SmoothMode = arg43 or settings.FarmMode ~= "Orbit"
        end

        if SmoothMode then
            local elapsed = task.wait(0.1)

            if elapsed then
                elapsed = IsAlive(arg113)

                if elapsed then
                    elapsed = arg113.PrimaryPart and enabledOptions[settings.RunningOption]
                end
            end

            if elapsed then
                local val37 = _ENV

                settings.RunningMethod = "Killing: " .. arg113.Name
                val37.OnFarm = true
                tbl12.attack(arg113, arg213, arg38, arg43)
            end
        end

        return true
    end
    function tbl12.Material(self8, arg214)
        local val38 = tbl27[arg214] and tbl27[arg214][Module.GameData.Sea]
        local val39 = tbl28[arg214]

        if val39 then
            local EnemyLocation = self8.EnemyLocation
            local CanFarm = self8.CanFarm

            if CanFarm[arg214] == nil then
                if val39[2][Module.GameData.Sea] then
                    CanFarm[arg214] = true
                else
                    CanFarm[arg214] = false
                end
            end

            if not CanFarm[arg214] then
                return nil
            end

            if EnemyLocation[arg214] == nil then
                for _, v in ipairs(val39[1]) do
                    local val40 = EnemyLocations[v]

                    if val40 and #val40 > 0 then
                        EnemyLocation[arg214] = val40
                    end
                end

                if not EnemyLocation[arg214] then
                    EnemyLocation[arg214] = false
                end
            end

            for _, v in ipairs(val39[1]) do
                local result7 = EnemySpawned(v)

                if result7 and result7.PrimaryPart then
                    self8.attack(result7, true, true)

                    return "Killing: " .. v
                end
            end

            if EnemyLocation[arg214] then
                Managers.TweenManager:TweenToCFrameQueue(EnemyLocation[arg214])
            else
                MoveCharacter(val38)
            end

            return "Farming Material: " .. arg214
        end
    end
    function tbl12.GetNpcVectorCFrame(_, arg215)
        if tbl13[arg215] then
            return tbl13[arg215]:GetPivot()
        end

        local found = NPCs:FindFirstChild(arg215) or ReplicatedStorage.NPCs:FindFirstChild(arg215)

        if found then
            tbl13[arg215] = found

            return found:GetPivot()
        end
    end

    return tbl12
end
function Managers.RaidManager()
    if Module.GameData.Sea ~= 2 and Module.GameData.Sea ~= 3 then
        return nil
    end

    if Module.GameData.Sea ~= 2 then
    end

    local cFrame = CFrame.new(-5033, 315, -2950)
    local Timer = LocalPlayer.PlayerGui:WaitForChild("Main").Timer
    local val41 = if Module.GameData.Sea ~= 2 then Module.GameData.Sea == 3 and "Boat Castle.RaidSummon2.Button.Main" else "CircleIsland.RaidSummon2.Button.Main"

    return {
		RaidPosition = cFrame,
		requests = {},
		Require = 0,
		Timer = Timer,
		Button = val41,
		IsRaiding = function(_)
        return enabledOptions.Raid and LocalPlayer:GetAttribute("IslandRaiding")
    end,
		GetRaidIsland = function(_)
        return Module:GetRaidIsland()
    end,
		CanStartRaid = function(_)
        return Level.Value >= 1200 and VerifyTool("Special Microchip")
    end,
		start = function(arg114)
        if not arg114:IsRaiding() and arg114:CanStartRaid() then
            local parts = arg114.Button:split(".")
            local val42 = Map

            for i = 1, #parts do
                if val42 then
                    val42 = val42:FindFirstChild(parts[i])
                end
            end

            if val42 and val42:FindFirstChild("ClickDetector") then
                fireclickdetector(val42.ClickDetector)
                task.wait(1)

                return
            end

            return MoveCharacter(arg114.RaidPosition)
        end
    end
	}
end
function Managers.ItemsManager()
    local tbl29 = {}
    local Sea = Module.GameData.Sea
    local IsSpawned = Module.Enemies.IsSpawned
    local EnemySpawned = Module.EnemySpawned
    local EnemyLocations = Module.EnemyLocations
    local EquipTool = Module.EquipTool
    local FireRemote = Module.FireRemote
    local IsAlive = Module.IsAlive
    local Count = Module.Inventory.Count
    local Unlocked = Module.Inventory.Unlocked

    if Sea == 3 then
        tbl29.CursedDualKatana = {}
        tbl29.SkullGuitar = {}
        local val43
        tbl29.DojoTrainer = {}
        local val44
        local val45
        local val46
        local val47
        local val48
        local val49
        local cFrame = CFrame.new(5867, 1208, 872)
        local cFrame3 = CFrame.new(5771, 1209, 804)
        local function helper6()
            if val44 and val44.Value > 0 then
                return val44
            end

            local huge = math.huge

            val44 = nil

            for _, child in ipairs(LocalPlayer.QuestHaze:GetChildren()) do
                if child.Value > 0 then
                    local Position = child:GetAttribute("Position")
                    local result8 = typeof(Position) == "Vector3" and LocalPlayer:DistanceFromCharacter(Position)

                    if result8 and result8 <= huge then
                        val44 = child
                        huge = result8
                    end
                end
            end

            return val44
        end
        local function helper7(arg115, arg216)
            local flag2 = not arg216 and "Pedestal" or "Torch"

            for i = 1, 3 do
                local found2 = arg115:FindFirstChild(flag2 .. i)
                local val50 = found2

                if found2 then
                    val50 = found2:FindFirstChild("ProximityPrompt") and found2.ProximityPrompt.Enabled
                end

                if val50 then
                    return found2
                end
            end
        end
        function val49(arg116)
            local huge = math.huge
            local val51
            for _, child in ipairs(ReplicatedStorage.NPCs:GetChildren()) do
                local val52 = child.Name == "Luxury Boat Dealer"

                if val52 then
                    val52 = not arg116[child] and child.PrimaryPart
                end

                if val52 then
                    local distanceFromCharacterResult = LocalPlayer:DistanceFromCharacter(child.PrimaryPart.Position)

                    if distanceFromCharacterResult <= huge then
                        val51 = child
                        huge = distanceFromCharacterResult
                    end
                end
            end

            return val51
        end
        function val43(arg117, arg217)
            local result9 = helper7(arg117, true)

            if not result9 then
                result9 = arg117:FindFirstChild("Exit")
            end

            local val53 = result9

            if result9 then
                val53 = LocalPlayer:DistanceFromCharacter(result9.Position) <= 1000
            end

            if val53 then
                local result10 = EnemySpawned(arg217)

                if result10 and result10.PrimaryPart then
                    local PrimaryPartCFrame = result10.PrimaryPart.CFrame
                    local FarmPos = settings.FarmPos

                    MoveCharacter(PrimaryPartCFrame + FarmPos)

                    return true, Module.KillAura(125)
                end

                local val54 = result9.Name ~= "Exit"

                if val54 then
                    val54 = LocalPlayer:DistanceFromCharacter(result9.Position) < 5
                end

                if val54 then
                    fireproximityprompt(result9.ProximityPrompt)
                else
                    MoveCharacter(result9.CFrame)
                end
            end

            return true
        end
        local CursedDualKatana = tbl29.CursedDualKatana
        CursedDualKatana.Tushita = {
			function(arg118, _)
            if not LocalPlayer:FindFirstChild("BoatQuest") then
                return
            end

            if not val45 or arg118.BoatsDealer[val45] then
                local luxuryBoatDealer = NPCs:FindFirstChild("Luxury Boat Dealer")
                local flag3 = not luxuryBoatDealer

                if not flag3 then
                    flag3 = not luxuryBoatDealer.PrimaryPart or arg118.BoatsDealer[luxuryBoatDealer]
                end

                if flag3 then
                    val45 = val49(arg118.BoatsDealer)
                else
                    val45 = luxuryBoatDealer
                end
            end

            local val55 = val45 and val45.PrimaryPart

            if val55 then
                if LocalPlayer:DistanceFromCharacter(val55.Position) < 5 then
                    if FireRemote("CDKQuest", "BoatQuest", val45, "Check") then
                        FireRemote("CDKQuest", "BoatQuest", val45)
                    end

                    arg118.BoatsDealer[val45] = true

                    return
                end

                return true, MoveCharacter(val55.CFrame)
            end

            task.wait(0.5)
        end,
			function(_, arg218)
            return arg218.PirateRaid()
        end,
			function(arg119, _)
            if Map:FindFirstChild("HeavenlyDimension") then
                return val43(Map.HeavenlyDimension, arg119.Heaven)
            end

            if IsSpawned("Cake Queen") then
                local result11 = EnemySpawned("Cake Queen")

                if result11 and result11.PrimaryPart then
                    Managers.FarmManager.attack(result11, true)
                else
                    MoveCharacter(arg119.CakeQueen)
                end

                return true
            end
        end
		}
        CursedDualKatana.Yama = {
			function(arg120, _)
            if not VerifyTool("Yama") then
                return FireRemote("LoadItem", "Yama")
            end

            local result12 = EnemySpawned("Forest Pirate")

            EquipTool("Yama")

            if result12 and result12.PrimaryPart then
                Module.AttackCooldown = tick()
                MoveCharacter(result12.PrimaryPart.CFrame * CFrame.new(0, 0, -2))
            else
                MoveCharacter(arg120.ForestPirate)
            end

            return true
        end,
			function(_, _)
            if not LocalPlayer:FindFirstChild("QuestHaze") then
                return
            end

            local result13 = helper6()

            if result13 then
                local Name = result13.Name
                local result14 = EnemySpawned(Name)

                if result14 and result14.PrimaryPart then
                    Managers.FarmManager.attack(result14, true)
                elseif EnemyLocations[Name] then
                    Managers.TweenManager:TweenToCFrameQueue(EnemyLocations[Name])
                else
                    MoveCharacter(result13:GetAttribute("Position"))
                end

                return true
            end
        end,
			function(arg121, arg219)
            if Map:FindFirstChild("HellDimension") then
                return val43(Map.HellDimension, arg121.Hell)
            end

            if IsSpawned("Soul Reaper") then
                local result15 = EnemySpawned("Soul Reaper")

                if result15 and result15.PrimaryPart then
                    if LocalPlayer:DistanceFromCharacter(result15.PrimaryPart.Position) > 6 then
                        MoveCharacter(result15.PrimaryPart.CFrame * CFrame.new(0, 0, -2))
                    end

                    return true
                end

                return
            end

            return arg219.SoulReaper() or arg219.Bones()
        end
		}
        function CursedDualKatana.FinalQuest(arg122, _)
            if not VerifyTool("Tushita") and not VerifyTool("Yama") then
                return FireRemote("LoadItem", "Yama")
            end

            if IsSpawned("Cursed Skeleton Boss") then
                local result16 = EnemySpawned("Cursed Skeleton Boss")

                if result16 and result16.PrimaryPart then
                    EquipTool("Sword", true)
                    Managers.FarmManager.ToolDebounce()
                    Managers.FarmManager.attack(result16, true)

                    return true
                end

                return false
            end

            if LocalPlayer.PlayerGui.Main.Dialogue.Visible then
                VirtualUser:ClickButton1(Vector2.new(10000, 10000))
            end

            local result17 = helper7(Map.Turtle.Cursed)

            if result17 then
                if LocalPlayer:DistanceFromCharacter(result17.Position) < 5 then
                    fireproximityprompt(result17.ProximityPrompt)
                else
                    MoveCharacter(result17.CFrame)
                end

                return true
            end

            local distanceFromCharacterResult2 = LocalPlayer:DistanceFromCharacter(arg122.CursedSkeleton[1].Position)

            if distanceFromCharacterResult2 > 6 then
                MoveCharacter(arg122.CursedSkeleton[1], distanceFromCharacterResult2 <= 100 and 40)
            else
                MoveCharacter(arg122.CursedSkeleton[2])
            end

            task.wait(0.5)

            return true
        end
        local DojoTrainer = tbl29.DojoTrainer
        local tbl30 = {
			NPC = "Dojo Trainer",
			Command = "ClaimQuest"
		}
        local tbl31 = {
			NPC = "Dojo Trainer",
			Command = "RequestQuest"
		}
        local tbl32 = {
			NPC = "Dragon Wizard",
			Command = "Speak"
		}
        local tbl33 = {
			NPC = "Dragon Wizard",
			Command = "DragonRace"
		}
        local tbl34 = {
			NPC = "Dragon Wizard",
			Command = "LearnTether"
		}
        local tbl35 = {
			NPC = "Dragon Wizard",
			Command = "Ascension",
			Action = "Begin"
		}
        local tbl36 = {
			NPC = "Dragon Wizard",
			Command = "Ascension",
			Action = "Complete"
		}
        local result18 = CreateDictionary({ "Terrorshark" }, true)
        local result19 = CreateDictionary({
			"Piranha",
			"Shark"
		}, true)
        local result20 = CreateDictionary({ "Terrorshark" }, true)
        local rFInteractDragonQuest = Net:WaitForChild("RF/InteractDragonQuest")
        DojoTrainer.Progress = {}
        DojoTrainer.BeltQuest = nil
        local tbl37 = {
			White = 20,
			Green = 360,
			Purple = 3,
			Red = 1,
			Yellow = 8,
			Blue = 1,
			Black = 3
		}
        local function helper8(arg123)
            return arg123.CraftVolcanicMagnet() or arg123.FullyVolcano(true, true)
        end
        local function helper9(arg124)
            local val56 = Unlocked["Dragon Egg"]

            if not val56 then
                val56 = val48.CanTransform or val48.CanTransformFree
            end

            if val56 then
                return DojoTrainer:InteractWithNpcDraco(tbl33)
            end

            if not val48.TetherLearned then
                return DojoTrainer:InteractWithNpcDraco(tbl34)
            end

            return helper8(arg124)
        end
        local function helper10(arg125, arg220)
            if arg125 == "V2" or arg125 == "V3" then
                return DojoTrainer:InteractWithNpcDraco(tbl35)
            end

            if arg125 == "V2InProgress" then
                if Count["Fire Flower"] >= 5 then
                    return DojoTrainer:InteractWithNpcDraco(tbl36)
                end

                return "FireFlowers"
            end

            if arg125 == "V3InProgress" then
                if DojoTrainer.DracoV3Completed then
                    return DojoTrainer:InteractWithNpcDraco(tbl36)
                end

                return arg220.Sea(result20, false)
            end

            if arg125 == "V2TurnInReady" or arg125 == "V3TurnInReady" then
                if Data.Level.Value >= (arg125 ~= "V3TurnInReady" and 1000000 or 3000000) then
                    return self:InteractWithNpcDraco(tbl36)
                end

                return arg220.Level()
            end
        end
        function DojoTrainer.BeltWhite(_, arg221)
            return arg221.Level()
        end
        function DojoTrainer.BeltGreen(arg126)
            if LocalPlayer:GetAttribute("DangerLevel") >= 600 and arg126.GreenTimer then
                arg126.Progress.Green = arg126.Progress.Green + (tick() - arg126.GreenTimer)
            end

            arg126.GreenTimer = tick()

            return Managers.SeaManager:DriveBoat("inf")
        end
        function DojoTrainer.BeltPurple(arg127, arg222)
            if not arg127.PurpleProgress then
                arg127.StartPurpleProgress = arg127.Progress.Purple
                arg127.PurpleProgress = Module:GetProgress("EliteProgress", "EliteHunter", "Progress")

                return
            end

            if not arg222.EliteHunter() then
                arg127.Progress.Purple = arg127.StartPurpleProgress + (Module:GetProgress("EliteProgress", "EliteHunter", "Progress") - arg127.PurpleProgress)

                return
            end

            return true
        end
        function DojoTrainer.BeltRed(_, arg223)
            return arg223.Sea(result18, false)
        end
        function DojoTrainer.BeltYellow(_, arg224)
            return arg224.Sea(result19, false)
        end
        function DojoTrainer.BeltBlue(arg128, arg225)
            if not IsAlive(LocalPlayer.Character) then
                return
            end

            local val57 = val46

            if val57 then
                val57 = val46.Parent == LocalPlayer.Character or val46.Parent == LocalPlayer.Backpack
            end

            if val57 then
                arg128.Progress.Blue = 1
            elseif val46 and val46.Parent ~= workspace then
                val46 = nil
            end

            if val46 then
                return arg225.Fruits(val46)
            end

            local Tool = workspace:FindFirstChildOfClass("Tool")

            if Tool and Tool:GetAttribute("DroppedBy") ~= LocalPlayer.Name then
                val46 = Tool

                return
            end

            if Tool then
                Tool.Parent = Map
            end
        end
        function DojoTrainer.BeltBlack(arg129, arg226)
            if not arg129.BlackProgress then
                arg129.BlackProgress = arg129.Progress.Black - Count["Dinosaur Bones"]

                return
            end

            arg129.Progress.Black = Count["Dinosaur Bones"] - arg129.BlackProgress

            return helper8(arg226)
        end
        function DojoTrainer.CollectBeltReward(self9, arg227)
            if Unlocked["Dojo Belt (" .. arg227 .. ")"] then
                self9.Progress[arg227] = nil

                return false
            end

            if LocalPlayer:DistanceFromCharacter(cFrame.Position) <= 5 then
                rFInteractDragonQuest:InvokeServer(tbl30)
            else
                MoveCharacter(cFrame)
            end

            return true
        end
        function DojoTrainer.UpdateBeltProgress(self10, arg228, arg39)
            if arg228 == self10.BeltQuest then
                self10.Progress[arg228] = (self10.Progress[arg228] or 0) + arg39

                return
            end

            local val58 = arg228 == "Red"

            if val58 then
                val58 = val48 and val48.AvailableVQuest == "V3InProgress"
            end

            if val58 then
                self10.DracoV3Completed = true
            end
        end
        function DojoTrainer.GetBelt(self11, arg229, arg310)
            local BeltName = arg229.BeltName
            local val59 = self11["Belt" .. BeltName]

            if not val59 then
                return false
            end

            if Unlocked["Dojo Belt (" .. BeltName .. ")"] then
                return self11:InteractWithDojoTrainer()
            end

            if not self11.Progress[BeltName] or not arg229.UpdatedProgress then
                self11.Progress[BeltName] = arg229.Progress
                arg229.UpdatedProgress = true
            end

            if self11.Progress[BeltName] >= tbl37[BeltName] then
                return self11:CollectBeltReward(BeltName)
            end

            self11.BeltQuest = BeltName

            if val59(self11, arg310) then
                return "Belt Quest: " .. BeltName
            end
        end
        function DojoTrainer.InteractWithDojoTrainer(_)
            if LocalPlayer:DistanceFromCharacter(cFrame.Position) <= 5 then
                val47 = rFInteractDragonQuest:InvokeServer(tbl31)
            else
                MoveCharacter(cFrame)
            end

            return "Getting Belt Quest"
        end
        function DojoTrainer.InteractWithDragonWizard(_)
            if LocalPlayer:DistanceFromCharacter(cFrame3.Position) <= 5 then
                val48 = rFInteractDragonQuest:InvokeServer(tbl32)
            else
                MoveCharacter(cFrame3)
            end

            return "Getting Draco Quest"
        end
        function DojoTrainer.InteractWithNpcDraco(_, arg230)
            if LocalPlayer:DistanceFromCharacter(cFrame3.Position) <= 5 then
                if rFInteractDragonQuest:InvokeServer(arg230) then
                    val48 = nil
                end
            else
                MoveCharacter(cFrame3)
            end

            return true
        end
        function DojoTrainer.Train(self12, arg231)
            if type(val47) == "table" then
                if val47.Timeout or val47.Completed then
                    return nil
                end

                if val47.Quest then
                    return self12:GetBelt(val47.Quest, arg231)
                end

                return
            end

            return self12:InteractWithDojoTrainer()
        end
        function DojoTrainer.EvoDracoRace(self13, arg232)
            if not Unlocked["Dojo Belt (Black)"] then
                return arg232.DojoTrainer()
            end

            if type(val48) ~= "table" then
                return self13:InteractWithDragonWizard()
            end

            if not val48.TetherLearned and not val48.CanLearnTether then
                return false
            end

            if not val48.FoundPrehistoric then
                return helper8(arg232)
            end

            if Data.Race.Value ~= "Draco" then
                return helper9(arg232)
            end

            if val48.AvailableVQuest then
                return helper10(val48.AvailableVQuest, arg232)
            end
        end
        local _ = tbl29.SkullGuitar
    end

    return tbl29
end
function Managers.EspManager()
    local tbl38 = {}

    tbl38.__index = tbl38

    function tbl38.__newindex(arg130, arg233, arg311)
        if arg233 == "Enabled" then
            task.spawn(arg130.ToggleEsp, arg130, arg311)

            return
        end

        rawset(arg130, arg233, arg311)
    end

    local Folder = Instance.new("Folder", CoreGui)

    Folder.Name = "redzHub-EspFolder"

    local FolderName = CoreGui:FindFirstChild(Folder.Name)

    if FolderName and FolderName ~= Folder then
        FolderName:Destroy()
    end

    local BoxHandleAdornment = Instance.new("BoxHandleAdornment")
    local val60 = BoxHandleAdornment

    val60.Size = Vector3.new(1, 0, 1, 0)
    val60.AlwaysOnTop = true
    val60.ZIndex = 10
    val60.Transparency = 0

    local BillboardGui = Instance.new("BillboardGui", val60)

    BillboardGui.Size = UDim2.new(0, 100, 0, 150)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true

    local TextLabel = Instance.new("TextLabel", BillboardGui)

    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0, 0, 0, -50)
    TextLabel.Size = UDim2.new(0, 100, 0, 100)
    TextLabel.TextSize = 10
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    TextLabel.Text = "..."
    TextLabel.ZIndex = 15
    TextLabel.RichText = true

    local color3 = Color3.fromRGB(255, 255, 255)
    local tbl39 = {}

    local function helper11(arg131)
        if arg131:IsA("BasePart") then
            return arg131
        end

        if arg131:IsA("Model") then
            return arg131.PrimaryPart or arg131:GetPivot()
        end

        if arg131.Parent:IsA("Model") then
            return arg131.Parent.PrimaryPart or arg131.Parent:GetPivot()
        end
    end

    function tbl38.SetCustomEspDisplay(self14, arg234)
        self14.CustomEspDisplay = arg234

        return self14
    end
    function tbl38.SetObjects(self15, arg235)
        self15.GetObjectsAction = arg235

        return self15
    end
    function tbl38.GetInstance(self16, arg236)
        self16.OnlyOneInstanceAction = arg236

        return self16
    end
    function tbl38.SetInstanceName(self17, arg237, arg312)
        self17.EspsNames[arg237] = arg312

        return self17
    end
    function tbl38.SetAllInstancesName(arg132, arg238)
        arg132.CustomInstanceName = arg238

        return arg132
    end
    function tbl38.WaitChildsAdded(self18)
        self18._WaitChildsAdded = true

        return self18
    end
    function tbl38.SetEspColor(self19, arg239)
        self19.EspColor = arg239

        return self19
    end
    function tbl38.SetAlwaysValidate(self20)
        self20.AlwaysValidateInstance = true

        return self20
    end
    function tbl38.Validator(self21, arg240)
        self21.ValidateInstance = arg240

        return self21
    end
    function tbl38.ChangeEspSize(self22, arg241)
        self22.EspSize = arg241

        for i = 1, #tbl39 do
            for _, v in pairs(tbl39[i].EspObjects) do
                v.BoxHandleAdornment.BillboardGui.TextLabel.TextSize = arg241
            end
        end

        return self22
    end
    function tbl38.StartRunningEsp(arg133, arg242)
        local Instance2 = arg242.Instance
        local BoxHandleAdornment2 = arg242.BoxHandleAdornment
        local TextLabel2 = BoxHandleAdornment2.BillboardGui.TextLabel
        local _ = arg133.EspFolder
        local isAResult = Instance2:IsA("Model")
        local val61
        while task.wait(not settings.SmoothMode and 0 or 0.25) do
            if not BoxHandleAdornment2 or not BoxHandleAdornment2.Parent then
                return arg133:Clear(arg242)
            end

            if arg133.AlwaysValidateInstance and not arg133.ValidateInstance(Instance2) then
                return arg133:Clear(arg242)
            end

            if not Instance2:IsDescendantOf(workspace) and not Instance2:IsDescendantOf(ReplicatedStorage) then
                return arg133:Clear(arg242)
            end

            val61 = val61 or helper11(Instance2)

            if not val61 then
                return arg133:Clear(arg242)
            end

            local floor5 = math.floor(LocalPlayer:DistanceFromCharacter(val61.Position) / 5)
            local val62 = isAResult and Instance2:FindFirstChildOfClass("Humanoid")

            if val62 then
                TextLabel2.Text = ("%s<font color='rgb(160, 160, 160)'> [ %im ]</font>\n<font color='rgb(25, 240, 25)'>[%i/%i]</font>"):format(Instance2.Name, floor5, math.floor(val62.Health), (math.floor(val62.MaxHealth)))
            elseif arg133.CustomEspDisplay then
                TextLabel2.Text = arg133.CustomEspDisplay(Instance2, floor5)
            else
                local CustomInstanceName = arg133.CustomInstanceName

                if not CustomInstanceName then
                    CustomInstanceName = arg133.EspsNames[Instance2] or Instance2.Name
                end

                TextLabel2.Text = ("%s < %i >").format("%s < %i >", CustomInstanceName, floor5)
            end
        end
    end
    function tbl38.Create(self23, arg243)
        if self23.EspObjects[arg243] then
            return
        end

        local tbl40 = {
			Instance = arg243,
			BoxHandleAdornment = nil
		}
        local clone = BoxHandleAdornment:Clone()
        local BillboardGui2 = clone.BillboardGui
        local TextLabel3 = BillboardGui2.TextLabel

        BillboardGui2.Adornee = arg243:IsA("BasePart") or (arg243:IsA("Model") and arg243 or arg243.Parent)

        local result21 = type(self23.EspColor) == "function" and self23.EspColor(arg243)

        if not result21 then
            result21 = self23.EspColor or color3
        end

        TextLabel3.TextColor3 = result21
        TextLabel3.Text = self23.CustomInstanceName or "..."
        TextLabel3.TextSize = self23.EspSize or TextLabel3.TextSize
        clone.Parent = self23.EspFolder
        self23.EspObjects[arg243] = tbl40
        tbl40.BoxHandleAdornment = clone
        task.spawn(self23.StartRunningEsp, self23, tbl40)

        return tbl40
    end
    function tbl38.Clear(self24, arg244)
        if arg244 then
            self24.EspObjects[arg244.Instance] = nil

            if arg244.BoxHandleAdornment then
                arg244.BoxHandleAdornment:Destroy()

                return
            end
        else
            table.clear(self24.EspObjects)
            self24.EspFolder:ClearAllChildren()
        end
    end
    function tbl38.ToggleEsp(arg134, arg245)
        local str = "redzHub_Esp_" .. arg134.SpecialTag

        _ENV[str] = arg245

        if not arg245 then
            return arg134:Clear()
        end

        while _ENV[str] do
            local GetObjectsAction = arg134.GetObjectsAction

            if arg134.OnlyOneInstanceAction then
                local result22 = arg134.OnlyOneInstanceAction()

                if result22 then
                    arg134:Create(result22)
                end
            elseif GetObjectsAction then
                local result23 = typeof(GetObjectsAction) == "Instance" and GetObjectsAction:GetChildren() or GetObjectsAction
                local ValidateInstance = arg134.ValidateInstance
                local EspObjects = arg134.EspObjects

                for i = 1, #result23 do
                    local val63 = result23[i]
                    local flag4 = not EspObjects[val63]

                    if flag4 then
                        flag4 = not ValidateInstance or ValidateInstance(val63)
                    end

                    if flag4 then
                        arg134:Create(val63)
                    end
                end
            end

            if not CreatedNew and arg134._WaitChildsAdded then
                GetObjectsAction.ChildAdded:Wait()
            end

            task.wait(0.25)
        end
    end
    function tbl38.new(arg135)
        local Folder2 = Instance.new("Folder", Folder)

        Folder2.Name = arg135

        local proxy = setmetatable({
			SpecialTag = arg135,
			EspObjects = {},
			EspsNames = {},
			EspFolder = Folder2
		}, tbl38)

        table.insert(tbl39, proxy)

        return proxy
    end

    return tbl38
end
function Managers.SeaManager()
    if Module.GameData.Sea == 1 then
        return
    end

    local tbl41 = {
		Weapons = {
			"Melee",
			"Blox Fruit",
			"Sword",
			"Gun"
		},
		Selected = "Melee",
		Debounce = 0
	}
    local tbl42 = {
		CFrame.new(94, 10, 2951),
		CFrame.new(-5288, 5, -701)
	}
    local tbl43 = {
		CFrame.new(-6123, 16, -2247),
		CFrame.new(-16917, 9, 510)
	}
    local val64 = Module.GameData.Sea - 1
    local tbl44 = {
		MoveDebounce = 0,
		NextNumber = 1,
		MyBoat = nil,
		SelectedBoat = "BeastHunter",
		OthersBoats = {
			"BeastHunter",
			"Guardian",
			"Lantern",
			"Sleigh",
			"PirateGrandBrigade",
			"MarineGrandBrigade"
		},
		Spawns = ({
			tbl42,
			tbl43
		})[val64]
	}
    local tbl45 = {
		Vector3.new(1, 0, 0),
		Vector3.new(0, 0, 1),
		Vector3.new(-1, 0, 0),
		Vector3.new(0, 0, -1),
		Vector3.new(0, 0, 0)
	}
    local val65 = ({
		{
			CFrame.new(-43, 21, 5054),
			CFrame.new(1744, 21, 4393),
			CFrame.new(1003, 21, 3598),
			CFrame.new(-935, 21, 3813)
		},
		{
			inf = -100000000,
			["6"] = -43200,
			["5"] = -38200,
			["4"] = -34000,
			["3"] = -30000,
			["2"] = -26000,
			["1"] = -22000
		}
	})[Module.GameData.Sea - 1]
    local tbl46 = {
		RandomWeapons = tbl41,
		Boats = tbl44,
		SeaBeastDirections = tbl45,
		SeaPositions = val65
	}
    local SubclassNetwork = Remotes:WaitForChild("SubclassNetwork")

    if Module.GameData.Sea == 3 then
        for k, v in pairs(tbl46.SeaPositions) do
            tbl46.SeaPositions[k] = {
				CFrame.new(v, 19, 500),
				CFrame.new(v - 3000, 19, 500),
				CFrame.new(v - 3000, 19, 2000),
				CFrame.new(v, 19, -1000)
			}
        end
    end

    local IsAlive = Module.IsAlive
    local FireRemote = Module.FireRemote
    local Count = Module.Inventory.Count
    local _ = Module.Inventory.Unlocked
    local UseSkills = Module.UseSkills
    local EquipTool = Module.EquipTool
    local Tween = Module.Tween
    local Sea = Module.GameData.Sea
    local flag5 = false
    local vector5 = Vector3.yAxis * 40
    local vector6 = Vector3.yAxis * 20
    local num8 = 0
    local num9 = 1

    local function helper12(arg136)
        if arg136 then
            arg136 = not arg136:FindFirstChild("Humanoid") or arg136.Humanoid.Value > 0
        end

        return arg136
    end
    local function helper13(arg137)
        return arg137:FindFirstChild("Owner") and arg137.Owner.Value == LocalPlayer
    end
    local function helper14(arg138)
        if arg138:GetAttribute("Repairing") then
            return
        end

        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        arg138.AncestryChanged:Wait()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end
    local function helper15(arg139, arg246)
        if arg246 <= tick() - num8 then
            num8 = tick()
            num9 = math.random(arg139)
        end

        return num9
    end
    local function helper16(arg140, arg247)
        if flag5 and flag5.Position.Y > -2 then
            return true
        end

        if arg247.Position.Y > -2 then
            flag5 = arg247

            return true
        end

        for _, child in ipairs(Enemies:GetChildren()) do
            if not (arg140 == child.Name and IsAlive(child)) then
                continue
            end

            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")
            local val66 = HumanoidRootPart

            if HumanoidRootPart then
                val66 = HumanoidRootPart.Position.Y > -2

                if val66 then
                    val66 = LocalPlayer:DistanceFromCharacter(HumanoidRootPart.Position) <= 500
                end
            end

            if val66 then
                flag5 = HumanoidRootPart

                return true
            end
        end
    end

    function tbl46.GetRandomWeapon(self25)
        local RandomWeapons = self25.RandomWeapons
        local Debounce = RandomWeapons.Debounce

        if tick() - Debounce >= 2 then
            local Weapons = RandomWeapons.Weapons
            local find2 = table.find(Weapons, RandomWeapons.Selected) + 1
            local val67 = Weapons[find2] or Weapons[1]

            while not VerifyToolTip(val67) do
                find2 = ((if not (find2 > #Weapons) then find2 else 0)) + 1
                val67 = RandomWeapons.Weapons[find2]
            end

            local timestamp = tick()

            RandomWeapons.Selected = val67
            RandomWeapons.Debounce = timestamp

            return val67
        end

        return RandomWeapons.Selected
    end
    function tbl46.GetMyBoat(self26)
        if not IsAlive(LocalPlayer.Character) then
            return
        end

        local SeatPart = LocalPlayer.Character.Humanoid.SeatPart
        local val68 = SeatPart

        if SeatPart then
            val68 = SeatPart.Name == "VehicleSeat" and helper12(SeatPart.Parent)
        end

        if val68 then
            return SeatPart.Parent, SeatPart.Parent.PrimaryPart
        end

        local MyBoat = self26.Boats.MyBoat
        local result24 = helper12(MyBoat)

        if result24 then
            result24 = MyBoat.Parent

            if result24 then
                result24 = LocalPlayer:DistanceFromCharacter((MyBoat.PrimaryPart or MyBoat:GetPivot()).Position) <= 12000
            end
        end

        if result24 then
            return MyBoat, MyBoat.PrimaryPart
        end

        for _, child in ipairs(Boats:GetChildren()) do
            local result25 = helper13(child)

            if result25 then
                result25 = helper12(child)

                if result25 then
                    result25 = LocalPlayer:DistanceFromCharacter((child.PrimaryPart or child:GetPivot()).Position) <= 8000
                end
            end

            if result25 then
                if child.Name ~= self26.Boats.SelectedBoat then
                    self26.Boats.SelectedBoat = child.Name
                end

                self26.Boats.MyBoat = child

                return child, child.PrimaryPart
            end
        end
    end
    function tbl46.GetClosestBoatDealer(_, arg248, arg313)
        if #arg313 < 2 then
            return arg313[1]
        end
        local p152Position = arg248.Position
        local val69
        local huge = math.huge
        for _, v in ipairs(arg313) do
            local Magnitude = (p152Position - v.Position).Magnitude

            if Magnitude < huge then
                huge = Magnitude
                val69 = v
            end
        end

        return val69
    end
    function tbl46.BuyNewBoat(self27)
        if not IsAlive(LocalPlayer.Character) then
            return
        end

        local _ = LocalPlayer.Character.Humanoid
        local SelectedBoat = self27.Boats.SelectedBoat
        local OthersBoats = self27.Boats.OthersBoats
        local ClosestBoatDealer = self27:GetClosestBoatDealer(LocalPlayer.Character:GetPivot(), self27.Boats.Spawns)

        if LocalPlayer:DistanceFromCharacter(ClosestBoatDealer.Position) >= 10 then
            return true, MoveCharacter(ClosestBoatDealer)
        end

        repeat
            if FireRemote("BuyBoat", SelectedBoat) == 1 then
                return
            end

            SelectedBoat = OthersBoats[table.find(OthersBoats, SelectedBoat) + 1]
        until SelectedBoat == nil

        return true
    end
    function tbl46.RepairBoat(self28, arg249)
        if not arg249 then
            arg249 = self28:GetMyBoat()
        end

        if not IsAlive(LocalPlayer.Character) or not arg249 then
            return
        end

        local Character = LocalPlayer.Character
        local Humanoid = arg249.Humanoid
        local GetAttribute = arg249.GetAttribute
        local _RepairHammer = Character:FindFirstChild("_RepairHammer")

        arg249:SetAttribute("_Repairing", Humanoid.Value < (GetAttribute(arg249, "MaxHealth") or Humanoid.Value))

        if not arg249:GetAttribute("_Repairing") and _RepairHammer then
            return true, SubclassNetwork.UseSubclass:InvokeServer({
				Action = "RequestHammer"
			})
        end

        if _RepairHammer and _RepairHammer:WaitForChild("Marker") then
            local WorldCFrame = _RepairHammer.Marker.Value.WorldCFrame
            local vector7 = Vector3.xAxis * 10

            MoveCharacter(WorldCFrame + vector7)

            return true, task.spawn(helper14, _RepairHammer)
        end

        if arg249:FindFirstChild("VehicleSeat") then
            local val70 = arg249.VehicleSeat.CFrame + Vector3.yAxis * 20

            if LocalPlayer:DistanceFromCharacter(val70.Position) <= 5 then
                SubclassNetwork.UseSubclass:InvokeServer({
					Action = "RequestHammer"
				})
            else
                MoveCharacter(val70)
            end
        end

        self28:StopMovingBoat(arg249)

        return true
    end
    function tbl46.CanRepair(self29, arg250)
        if not arg250 then
            arg250 = self29:GetMyBoat()
        end

        if settings.RepairBoat and arg250 then
            local Humanoid = arg250.Humanoid

            if Subclass.Value ~= "Shipwright" or Count["Wooden Plank"] == 0 then
                return false
            end

            local _Repairing = arg250:GetAttribute("_Repairing")

            if not _Repairing then
                local GetAttribute = arg250.GetAttribute

                _Repairing = Humanoid.Value < (GetAttribute(arg250, "MaxHealth") or Humanoid.Value / 1.2)
            end

            if _Repairing then
                return true
            end
        end
    end
    function tbl46.MoveBoat(self30, arg251, arg314, arg44)
        local Boats2 = self30.Boats

        if tick() - Boats2.MoveDebounce >= 0.5 then
            Module:RemoveBoatCollision(arg251.Parent)

            local val71 = Tween
            local Unit = (arg314.Position - arg251.Position).Unit

            if not arg44 then
                arg44 = settings.BoatSpeed
            end

            val71.Velocity = Unit * arg44
            Boats2.MoveDebounce = tick()
        end
    end
    function tbl46.GetCordinateCFrame(self31, arg252, arg315)
        if not arg252 and Sea == 3 then
            arg252 = settings.SeaLevel
        end

        local val72 = arg252 and self31.SeaPositions[arg252] or self31.SeaPositions
        local Boats3 = self31.Boats

        if #val72 == 1 then
            return val72[1]
        end

        if Boats3.NextNumber > #val72 then
            Boats3.NextNumber = 1
        end

        local val73 = val72[Boats3.NextNumber]

        if (arg315.Position - val73.Position).Magnitude < 75 then
            Boats3.NextNumber = Boats3.NextNumber + 1

            return val72[Boats3.NextNumber] or val72[1]
        end

        return val73
    end
    function tbl46.StopMovingBoat(_)
        Tween.Velocity = Vector3.zero
    end
    function tbl46.DriveBoat(self32, arg253)
        if not IsAlive(LocalPlayer.Character) then
            return
        end

        local Humanoid = LocalPlayer.Character.Humanoid
        local val74, val75 = self32:GetMyBoat()

        if val74 then
            local VehicleSeat = val74:FindFirstChild("VehicleSeat")

            if VehicleSeat and VehicleSeat ~= Humanoid.SeatPart then
                if LocalPlayer:DistanceFromCharacter(VehicleSeat.Position) <= 100 then
                    VehicleSeat:Sit(Humanoid)
                end

                return true, MoveCharacter(VehicleSeat.CFrame)
            end

            if VehicleSeat and val75 then
                if typeof(arg253) ~= "CFrame" then
                    arg253 = self32:GetCordinateCFrame(arg253, val75)
                end

                if (val75.Position - arg253.Position).Magnitude < 50 then
                    return true, self32:StopMovingBoat()
                end

                return true, self32:MoveBoat(val75, arg253)
            end

            return
        end

        return self32:BuyNewBoat()
    end
    function tbl46.GetSeaEvents(self33, arg254, arg316, arg45)
        for i = 1, #arg254 do
            local val76 = arg254[i]
            local val77 = arg316[val76] or arg45 and (arg45[val76] and self33:GetSeaEvent(val76))

            if val77 then
                return val77
            end
        end
    end
    function tbl46.GetSeaBeast(self34)
        local SeaBeast = self34.SeaBeast
        if IsAlive(SeaBeast) and SeaBeast.Parent == SeaBeasts then
            return SeaBeast
        end
        if not SeaBeasts:FindFirstChildOfClass("Model") then
            return nil
        end
        local num10 = 5000
        local val78
        for _, child in ipairs(SeaBeasts:GetChildren()) do
            local distanceFromCharacterResult3 = LocalPlayer:DistanceFromCharacter((child.PrimaryPart or child:GetPivot()).Position)

            if IsAlive(child) and distanceFromCharacterResult3 < num10 then
                num10 = distanceFromCharacterResult3
                val78 = child
            end
        end
        self34.SeaBeast = val78

        return val78
    end
    function tbl46.GetSeaEvent(self35, arg255)
        if arg255 == "Sea Beast" then
            return self35:GetSeaBeast()
        end

        local val79, val80 = Enemies:FindFirstChild(arg255)

        while val79 and not IsAlive(val79) do
            val80 = val80 or {}
            table.insert(val80, val79)
            val79.Name = "Died"
            val79 = Enemies:FindFirstChild(arg255)
        end

        if val80 then
            for i = 1, #val80 do
                val80[i].Name = arg255
            end
        end

        return val79
    end
    function tbl46.attackSeaEvent(self36, arg256)
        if arg256:GetAttribute("IsBoat") then
            return self36:attackSeaBoat(arg256)
        end

        if arg256.Parent == SeaBeasts then
            return self36:attackSeaBeast(arg256)
        end

        return self36:attackSeaEnemy(arg256)
    end
    function tbl46.attackSeaBoat(self37, arg257)
        if not arg257.PrimaryPart then
            return
        end

        local val81 = arg257.PrimaryPart.CFrame + vector6

        EnableBuso()
        MoveCharacter(val81)
        self37:StopMovingBoat()

        if LocalPlayer:DistanceFromCharacter(val81.Position) < 35 then
            local PrimaryPart = arg257.PrimaryPart
            local SeaSkills = settings.SeaSkills

            UseSkills(PrimaryPart, SeaSkills)

            local GetRandomWeapon = self37.GetRandomWeapon

            EquipTool(GetRandomWeapon(self37), true)
        end
    end
    function tbl46.attackSeaEnemy(self38, arg258)
        if not arg258:FindFirstChild("HumanoidRootPart") then
            return
        end

        local HumanoidRootPart = arg258.HumanoidRootPart
        local HumanoidRootPartCFrame = HumanoidRootPart.CFrame
        local val82 = arg258.Name == "Terrorshark" or arg258.Name == "Shark"

        if val82 then
            val82 = LocalPlayer:DistanceFromCharacter(HumanoidRootPartCFrame.Position) <= 250
        end

        local val83 = if not val82 then HumanoidRootPartCFrame + vector5 else HumanoidRootPartCFrame + Vector3.yAxis * ((not helper16(arg258.Name, HumanoidRootPart) and 0 or 155) + 45)

        MoveCharacter(val83)
        EquipTool()
        EnableBuso()
        self38:StopMovingBoat()
    end
    function tbl46.attackSeaBeast(self39, arg259)
        if not arg259:FindFirstChild("HumanoidRootPart") then
            return
        end

        local SeaBeastDirections = self39.SeaBeastDirections
        local val84 = SeaBeastDirections[helper15(#SeaBeastDirections, 1.5)] * 60
        local HumanoidRootPartPosition = arg259.HumanoidRootPart.Position
        local cframe = CFrame.new(HumanoidRootPartPosition.X, 25, HumanoidRootPartPosition.Z) + val84

        EnableBuso()
        MoveCharacter(cframe)
        self39:StopMovingBoat()

        local GetRandomWeapon = self39.GetRandomWeapon

        EquipTool(GetRandomWeapon(self39), true)
        UseSkills(cframe, settings.SeaSkills)
    end

    return tbl46
end
function Managers.FruitManager()
    local tbl47 = {
		RandomDebounce = 0,
		MoneyToReroll = 0
	}
    local IsAlive = Module.IsAlive
    local Count = Module.Inventory.Count
    local _ = Module.Inventory.Unlocked

    function tbl47.GetRealFruitName(_, arg260)
        local gsub3 = string.gsub(arg260.Name, " Fruit", "")

        return gsub3 .. "-" .. gsub3
    end
    function tbl47.CanStoreFruit(self40, arg261)
        return Count[self40:GetRealFruitName(arg261)] < FruitCap.Value
    end
    function tbl47.StoreFruit(self41, arg262)
        return Module.FireRemote("StoreFruit", self41:GetRealFruitName(arg262), arg262)
    end
    function tbl47.IsFruit(_, arg263)
        return string.sub(arg263.Name, -6, -1) == " Fruit" and arg263:GetAttribute("DroppedBy")
    end
    function tbl47.GetInventoryItems(_)
        local children = LocalPlayer.Backpack:GetChildren()
        local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")

        if Tool then
            table.insert(children, Tool)
        end

        return children
    end
    function tbl47.CanBuyMicrochip(self42)
        if not IsAlive(LocalPlayer.Character) then
            return false
        end

        if LocalPlayer:GetAttribute("IslandRaiding") then
            return false
        end

        if LocalPlayer.Backpack:FindFirstChild("Microchip") or LocalPlayer.Character:FindFirstChild("Microchip") then
            return false
        end

        local GetInventoryItems = self42.GetInventoryItems

        for _, v in ipairs(GetInventoryItems(self42)) do
            if v:IsA("Tool") and self42:IsFruit(v) then
                return true
            end
        end

        return -1
    end
    function tbl47.GetStorableFruit(self43, arg264)
        if not IsAlive(LocalPlayer.Character) then
            return false
        end

        local GetInventoryItems = self43.GetInventoryItems

        for _, v in ipairs(GetInventoryItems(self43)) do
            if arg264 == v.Name then
                continue
            end

            if not IsAlive(LocalPlayer.Character) then
                return
            end

            local isAResult2 = v:IsA("Tool")

            if isAResult2 then
                isAResult2 = self43:IsFruit(v) and self43:CanStoreFruit(v)
            end

            if isAResult2 then
                return v
            end

            if settings.SmoothMode then
                task.wait()
            end
        end
    end
    function tbl47.RerollRandomFruit(self44)
        if Level.Value < 50 then
            return Level:GetPropertyChangedSignal("Value"):Wait()
        end

        if Beli.Value < self44.MoneyToReroll then
            return Beli:GetPropertyChangedSignal("Value"):Wait()
        end

        if tick() - self44.RandomDebounce >= 1 then
            local result26 = Module.FireRemote("Cousin", "Buy")

            if result26 == 1 then
                self44.RandomDebounce = tick() + 7200

                return
            end

            if result26 == 2 then
                local _, _, moneyToReroll = Module.FireRemote("Cousin", "Check")

                self44.MoneyToReroll = moneyToReroll or 0

                return
            end

            if type(result26) == "string" and result26:match("%d%d:%d%d") then
                local val85, val86 = result26:match("(%d+):(%d+)")
                local num = tonumber(val85)
                local num2 = tonumber(val86)

                if num and num2 then
                    local val87 = num * 60 * 60

                    self44.RandomDebounce = tick() + (val87 + num2 * 60)

                    return
                end
            else
                self44.RandomDebounce = tick() + 5
            end
        end
    end

    return tbl47
end
function Core2.RunModules(self45)
    local _next = next
    local Managers2 = self45.Managers
    local val88
    while true do
        local val89

        val88, val89 = _next(Managers2, val88)

        if not val88 then
            break
        end

        local ok, result = pcall(val89)

        if ok then
            self45.Managers[val88] = result
            _ENV[val88] = result
        else
            _ENV[val88] = nil
            warn("falha ao carregar Module [ redz hub ]: " .. val88 .. " : " .. result)
        end
    end
end
function Core2.Initialize(_)
    library = fetcher.load("{Owner}Library/refs/heads/main/V5/Source.lua")()
    Module = fetcher.load("{Utils}BloxFruits/Module.luau", " return Module")(settings, connections)
    Core2:RunModules()
end
function Core2.LoadTabs(_, arg265)
    local makeTabResult = arg265:MakeTab({
		"Discord",
		"Info"
	})
    local makeTabResult2 = arg265:MakeTab({
		"Farm",
		"Home"
	})
    local makeTabResult3 = arg265:MakeTab({
		"Sea",
		"Waves"
	})
    local MakeTab = arg265.MakeTab
    local MakeTab2 = arg265.MakeTab
    local result27 = MakeTab(arg265, {
		"Islands",
		"PalmTree"
	})
    local result28 = MakeTab2(arg265, {
		"Quests/Items",
		"Swords"
	})
    local makeTabResult4 = arg265:MakeTab({
		"Fruit/Raid",
		"Cherry"
	})
    local MakeTab3 = arg265.MakeTab
    local makeTabResult5 = arg265:MakeTab({
		"Stats",
		"Signal"
	})
    local makeTabResult6 = arg265:MakeTab({
		"Teleport",
		"Locate"
	})
    local MakeTab4 = arg265.MakeTab
    local result29 = MakeTab3(arg265, {
		"Status",
		"scroll"
	})
    local result30 = MakeTab4(arg265, {
		"Visual",
		"User"
	})

    return {
		Discord = makeTabResult,
		MainFarm = makeTabResult2,
		Sea = makeTabResult3,
		Islands = result27,
		Items = result28,
		FruitRaid = makeTabResult4,
		Stats = makeTabResult5,
		Teleport = makeTabResult6,
		Status = result29,
		Visual = result30,
		Shop = arg265:MakeTab({
			"Shop",
			"ShoppingCart"
		}),
		Misc = arg265:MakeTab({
			"Misc",
			"Settings"
		})
	}
end
function Core2.InstallPlugin(_)
    return {
		Toggle = Module.RunFunctions.LibraryToggle(enabledOptions, tbl)
	}
end
function Core2.GetTranslation(_, arg266)
    local tbl48 = {
		BR = "Portuguese.json",
		VN = "Vietnamese.json",
		TH = "Thai.json"
	}

    if tbl48[arg266] then
        local val90 = HttpService
        local tbl49 = { loader.get("{Translator}BloxFruits/" .. tbl48[arg266]) }

        return val90:JSONDecode(unpackValues(tbl49))
    end
end
function Core2.Translator(self46, arg267)
    if not config.Translator then
        return arg267
    end

    local ok, result, isCached = pcall(function()
        if readfile and pcall(readfile, "PlayerCountry.txt") then
            local savedCountry = readfile("PlayerCountry.txt")

            if type(savedCountry) == "string" then
                return savedCountry, true
            end
        end

        return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
    end)
    local val91 = ok

    if ok then
        val91 = result

        if result then
            val91 = isCached ~= true and writefile
        end
    end

    if val91 then
        pcall(writefile, "PlayerCountry.txt", result)
    end

    local val92 = ok and self46:GetTranslation(result)

    if val92 then
        return Module.RunFunctions.Translator(arg267, val92)
    end

    return arg267
end
function Core2.LoadLibrary(arg141)
    local makeWindowResult = library:MakeWindow({
		"redz Hub : Blox Fruits",
		"by real_redz",
		"redzHub-BloxFruits.json"
	})
    arg141:Translator(makeWindowResult)
    local installPluginResult = arg141:InstallPlugin(makeWindowResult)
    local loadTabsResult = arg141:LoadTabs(makeWindowResult)
    local FruitManager = arg141.Managers.FruitManager
    local _ = arg141.Managers.QuestManager
    local FarmManager = arg141.Managers.FarmManager
    local FireRemote = Module.FireRemote
    local Count = Module.Inventory.Count
    local Unlocked = Module.Inventory.Unlocked
    local Sea = Module.GameData.Sea
    local Toggle = installPluginResult.Toggle
    local MainFarm = loadTabsResult.MainFarm
    local tbl50 = {
		Image = "rbxassetid://15298567397",
		BackgroundTransparency = 0
	}
    makeWindowResult:SelectTab(MainFarm)
    local _UDim = UDim
    local AddMinimizeButton = makeWindowResult.AddMinimizeButton
    local result31 = _UDim.new(0, 6)
    AddMinimizeButton(makeWindowResult, {
		Button = tbl50,
		Corner = {
			CornerRadius = result31
		}
	})
    loadTabsResult.Discord:AddDiscordInvite({
		Name = "redz Hub | Community",
		Description = "Join our discord community to receive Information about the next update, leaks, and Information about Blox Fruits!",
		Logo = "rbxassetid://17382040552",
		Invite = "https://discord.gg/7aR7kNVt4g"
	})
    local MainFarm2 = loadTabsResult.MainFarm
    local tbl51 = {
		Bigger = 380,
		Large = 450,
		Medium = 620,
		Small = 760
	}
    local tbl52 = {
		{
			"Z",
			"X",
			"C",
			"V",
			"F"
		},
		CreateDictionary({
			"Z",
			"X",
			"C",
			"V"
		}, true)
	}
    local val93
    local function helper17()
        local tbl53 = {}

        for k, _ in pairs(Module.Bosses) do
            local val94 = k

            if Module.Enemies.IsSpawned(val94) then
                table.insert(tbl53, val94)
            end
        end

        val93:Set(tbl53)
    end
    MainFarm2:AddDropdown({
		"Select Tool",
		{
			"Melee",
			"Sword",
			"Blox Fruit",
			"Gun"
		},
		"Melee",
		{
			settings,
			"FarmTool"
		},
		"FarmTool"
	})
    MainFarm2:AddDropdown({
		"UI Scale",
		{
			"Small",
			"Medium",
			"Large",
			"Bigger"
		},
		"Large",
		function(arg142)
        pcall(library.SetScale, library, tbl51[arg142] or 450)
    end,
		"UIScale"
	})
    MainFarm2:AddSection("Farm")
    Toggle(MainFarm2, {
		"Auto Farm Level",
		"Level Farm"
	}, "Level")
    Toggle(MainFarm2, {
		"Auto Farm Nearest",
		"Farm Nearest Mobs"
	}, "Nearest")
    if Sea ~= 1 then
        if Sea == 2 then
            Toggle(MainFarm2, {
				"Auto Factory",
				"Spawns Every 1:30 [hours, minutes]"
			}, "Factory")
            MainFarm2:AddSection("Ectoplasm")
            Toggle(MainFarm2, { "Auto Farm Ectoplasm" }, "Ectoplasm")
        elseif Sea == 3 then
            Toggle(MainFarm2, {
				"Auto Pirates Sea",
				"Auto Finish Pirate Raid in Sea Castle"
			}, "PirateRaid")
            MainFarm2:AddSection("Bones")
            Toggle(MainFarm2, { "Auto Farm Bones" }, "Bones")
            Toggle(MainFarm2, { "Auto Kill Soul Reaper" }, "SoulReaper")
            MainFarm2:AddToggle({
				"Auto Trade Bones",
				false,
				function(arg143)
                _ENV.TradeBones = arg143

                while _ENV.TradeBones do
                    task.wait()

                    local Bones = Count.Bones

                    if Bones >= 50 then
                        FireRemote("Bones", "Buy", 1, 1)

                        if Bones == Count.Bones then
                            task.wait(5)
                        end
                    else
                        task.wait(0.5)
                    end
                end
            end,
				"TradeBones"
			})
        end
    end
    MainFarm2:AddSection("Chest")
    Toggle(MainFarm2, { "Auto Chest [ Tween ]" }, "ChestTween")
    MainFarm2:AddSection("Bosses")
    MainFarm2:AddButton({
		"Update Boss List",
		helper17
	})
    val93 = MainFarm2:AddDropdown({
		"Boss List",
		{},
		false,
		{
			settings,
			"BossSelected"
		},
		"B-Selected"
	})
    helper17()
    Toggle(MainFarm2, {
		"Auto Kill Boss Selected",
		"Kill boss Selected"
	}, "BossSelected")
    Toggle(MainFarm2, {
		"Auto Farm All Bosses",
		"Kill all bosses Spawned"
	}, "AllBosses")
    MainFarm2:AddToggle({
		"Take Boss Quest",
		true,
		{
			settings,
			"BossQuest"
		},
		"B-Quest"
	})
    MainFarm2:AddSection("Material")
    MainFarm2:AddDropdown({
		"Material List",
		FarmManager.Materials,
		false,
		{
			settings,
			"fMaterial"
		},
		"S-Material"
	})
    Toggle(MainFarm2, {
		"Auto Farm Material",
		"Farm material Selected"
	}, "Material")
    MainFarm2:AddSection("Mastery")
    MainFarm2:AddSlider({
		"Select Enemy Health [ % ]",
		10,
		100,
		1,
		25,
		{
			settings,
			"mHealth"
		},
		"M-Health"
	})
    MainFarm2:AddDropdown({
		"Select Tool",
		{
			"Blox Fruit",
			"Gun"
		},
		{ "Blox Fruit" },
		{
			settings,
			"mTool"
		},
		"M-Tool"
	})
    MainFarm2:AddDropdown({
		"Select Skills",
		tbl52[1],
		tbl52[2],
		{
			settings,
			"MasterySkills"
		},
		"M-Skills",
		MultiSelect = true
	})
    Toggle(MainFarm2, { "Auto Farm Mastery" }, "Mastery")
    local Sea3 = loadTabsResult.Sea
    if Sea == 1 then
        Sea3:Destroy()
    elseif Sea == 2 then
        local tbl54 = {
			{
				"Sea Beast",
				"PirateBrigade"
			},
			CreateDictionary({ "Sea Beast" }, true)
		}
        local tbl55 = {
			{
				"Z",
				"X",
				"C",
				"V",
				"F"
			},
			CreateDictionary({
				"Z",
				"X",
				"C",
				"V"
			}, true)
		}

        Sea3:AddSection("Farm")
        Toggle(Sea3, { "Auto Farm Sea" }, "Sea")
        Sea3:AddToggle({
			"Auto Drive Boat",
			true,
			{
				settings,
				"autoDriveBoat"
			},
			"A-TweenBoat"
		})
        Sea3:AddSection("Farm Select")
        Sea3:AddDropdown({
			"Enemies",
			tbl54[1],
			tbl54[2],
			{
				settings,
				"seaEnemy"
			},
			"S-Enemies",
			MultiSelect = true
		})
        Sea3:AddDropdown({
			"Select Skills",
			tbl55[1],
			tbl55[2],
			{
				settings,
				"SeaSkills"
			},
			"S-Skills",
			MultiSelect = true
		})
        Sea3:AddSection("Configs")
        Sea3:AddSlider({
			"Boat Tween Speed",
			100,
			300,
			10,
			250,
			{
				settings,
				"BoatSpeed"
			},
			"S-BoatSpeed"
		})
        Sea3:AddToggle({
			"Auto Repair Boat [ BETA ]",
			false,
			{
				settings,
				"RepairBoat"
			},
			"S-RepairBoat"
		})
    elseif Sea == 3 then
        local tbl56 = {
			{
				"Z",
				"X",
				"C",
				"V",
				"F"
			},
			CreateDictionary({
				"Z",
				"X",
				"C",
				"V"
			}, true)
		}
        local tbl57 = {
			{
				"Sea Beast",
				"Terrorshark",
				"Fish Crew Member",
				"Piranha",
				"Shark"
			},
			CreateDictionary({
				"Terrorshark",
				"Fish Crew Member",
				"Piranha",
				"Shark"
			}, true)
		}
        local cFrame = CFrame.new(-16526, 76, 309)
        local cFrame4 = CFrame.new(-16526, 108, 752)
        local cFrame5 = CFrame.new(-16281, 73, 263)
        local cFrame6 = CFrame.new(-16471, 528, 539)
        local tbl58 = {
			["Shipwright Teacher"] = cFrame,
			["Shark Hunter"] = cFrame4,
			["Beast Hunter"] = cFrame5,
			Spy = cFrame6
		}

        Sea3:AddSection("Sea")
        Toggle(Sea3, { "Auto Farm Sea" }, "Sea")
        Sea3:AddToggle({
			"Auto Drive Boat",
			true,
			{
				settings,
				"autoDriveBoat"
			},
			"A-TweenBoat"
		})
        Sea3:AddSection("Farm Select")
        Sea3:AddDropdown({
			"Fish",
			tbl57[1],
			tbl57[2],
			{
				settings,
				"fishSelected"
			},
			"S-Fish",
			MultiSelect = true
		})
        Sea3:AddDropdown({
			"Boats",
			{
				"PirateBrigade",
				"PirateGrandBrigade",
				"GhostShip",
				"FishBoat"
			},
			nil,
			{
				settings,
				"boatSelected"
			},
			"S-Boat",
			MultiSelect = true
		})
        Sea3:AddDropdown({
			"Select Skills",
			tbl56[1],
			tbl56[2],
			{
				settings,
				"SeaSkills"
			},
			"S-Skills",
			MultiSelect = true
		})
        Sea3:AddSection("Configs")
        Sea3:AddDropdown({
			"Sea Level",
			{
				"1",
				"2",
				"3",
				"4",
				"5",
				"6",
				"inf"
			},
			"6",
			{
				settings,
				"SeaLevel"
			},
			"S-SeaLevel"
		})
        Sea3:AddSlider({
			"Boat Tween Speed",
			100,
			300,
			10,
			250,
			{
				settings,
				"BoatSpeed"
			},
			"S-BoatSpeed"
		})
        Sea3:AddToggle({
			"Auto Repair Boat [ BETA ]",
			false,
			{
				settings,
				"RepairBoat"
			},
			"S-RepairBoat"
		})
        Sea3:AddSection("NPCs")
        Sea3:AddDropdown({
			"Select NPC",
			{
				"Shipwright Teacher",
				"Shark Hunter",
				"Beast Hunter",
				"Spy"
			},
			"Spy",
			{
				settings,
				"selectedNpc"
			}
		})
        Sea3:AddToggle({
			"Teleport to NPC",
			false,
			function(arg144)
            _ENV.teleporting = arg144

            while _ENV.teleporting do
                task.wait()

                if settings.selectedNpc then
                    MoveCharacter(tbl58[settings.selectedNpc])
                end
            end

        end
		}):Callback(function(arg145)
            if arg145 then
                local TweenManager = arg141.Managers.TweenManager
                local huge = math.huge

                if _ENV.teleporting then
                    if not (huge < 15) then
                    end
                end

                repeat
                    task.wait()

                    if TweenManager:GetLastPosition() then
                        local val95 = LocalPlayer
                        local tbl59 = { TweenManager:GetLastPosition() }

                        huge = val95:DistanceFromCharacter(unpackValues(tbl59))
                    end
                until not _ENV.teleporting or huge < 15

                _ENV.teleporting = false
            end
        end)
        Sea3:AddSection("Quests/Items")
        Toggle(Sea3, { "Auto Unlock Shipwright Subclass [ BETA ]" }, "Shipwright")
        Toggle(Sea3, { "Auto Shark Anchor" }, "SharkAnchor")
    end
    local Stats = loadTabsResult.Stats
    if Level.Value < Module.GameData.MaxLevel then
        local tbl60 = {}
        local Points = Data:WaitForChild("Points")
        local Stats2 = Data:WaitForChild("Stats")

        Stats:AddSlider({
			"Points Amount",
			1,
			100,
			1,
			3,
			{
				settings,
				"StatsPoints"
			},
			"P-Stats"
		})
        Stats:AddToggle({
			"Auto Stats",
			false,
			function(arg146)
            _ENV.AutoStats = arg146

            while task.wait() and _ENV.AutoStats do
                local PointsValue = Points.Value

                if PointsValue > 0 then
                    for k, v in pairs(tbl60) do
                        local val96 = k

                        if v and Stats2[val96].Level.Value < Module.GameData.MaxLevel then
                            local clamp2 = math.clamp(math.clamp(settings.StatsPoints or 3, 0, PointsValue), 0, Module.GameData.MaxLevel)

                            FireRemote("AddPoint", val96, clamp2)
                        end
                    end
                end
            end
        end,
			"A-Stats"
		})
        Stats:AddSection("Select Stats")
        table.foreach({
			"Melee",
			"Defense",
			"Gun",
			"Sword",
			"Demon Fruit"
		}, function(_, arg268)
            Stats:AddToggle({
				arg268,
				false,
				{
					tbl60,
					arg268
				},
				"Stats-" .. arg268
			})
        end)
    else
        Stats:Destroy()
    end
    local Islands = loadTabsResult.Islands
    if Sea == 3 then
        local function helper18(arg147, arg269)
            local paragraph = Islands:AddParagraph({ arg147 .. " : not Spawn" })

            if not arg269 then
                arg269 = string.gsub(arg147, " ", "")
            end

            while task.wait() do
                local foundChild = Map:FindFirstChild(arg269)

                if foundChild then
                    local floor = math.floor
                    local WorldPivotPosition = foundChild.WorldPivot.Position

                    paragraph:SetTitle(arg147 .. " : Spawned | Distance : " .. floor(LocalPlayer:DistanceFromCharacter(WorldPivotPosition) / 5))
                else
                    paragraph:SetTitle(arg147 .. " : not Spawn")
                    Map.ChildAdded:Wait()
                end
            end
        end

        Islands:AddSection("Islands Stats")
        task.spawn(helper18, "Mirage Island", "MysticIsland")
        task.spawn(helper18, "Kitsune Island")
        task.spawn(helper18, "Prehistoric Island")
        Islands:AddSection("Prehistoric Island")
        Toggle(Islands, { "Auto Craft Volcanic Magnet" }, "CraftVolcanicMagnet")
        Toggle(Islands, { "Teleport to Prehistoric Island" }, "GotoVolcano")
        Toggle(Islands, { "Fully Prehistoric Island" }, "FullyVolcano")
        Islands:AddToggle({
			"Ignore Collect Bones [ Fully ]",
			false,
			{
				settings,
				"IgnoreBones"
			},
			"IgnoreBones"
		})
        Islands:AddToggle({
			"Ignore Collect Dragon Egg [ Fully ]",
			false,
			{
				settings,
				"IgnoreEggs"
			},
			"IgnoreEggs"
		})
        Islands:AddToggle({
			"Reset character after Finishing [ Fully ]",
			false,
			{
				settings,
				"VolcanoReset"
			},
			"VolcanoReset"
		})
        Islands:AddSection("Leviathan [ BETA ]")
        Toggle(Islands, { "Auto Attack Leviathan" }, "Leviathan")
        Islands:AddSection("Kitsune Island")
        Islands:AddSlider({
			"Trade Azure Ember Amount",
			10,
			25,
			5,
			20,
			{
				settings,
				"Azure"
			},
			"A-Amount"
		})
        Islands:AddToggle({
			"Auto Trade Azure Ember",
			false,
			function(arg148)
            _ENV.TradeAzure = arg148

            while _ENV.TradeAzure do
                if Lighting:GetAttribute("IsBlueMoon") and not Lighting:GetAttribute("BlueMoonEnded") and Count["Azure Ember"] >= settings.Azure then
                    Net["RF/KitsuneStatuePray"]:InvokeServer()
                end

                task.wait(1)
            end
        end
		}, "Trade-Azure")
        Toggle(Islands, { "Auto Kitsune Island" }, "KitsuneIsland")
        Islands:AddSection("Mirage Island")
        Toggle(Islands, { "Teleport To Gear" }, "MirageGear")
        Toggle(Islands, { "Teleport To Mirage" }, "TeleportMirage")
        Toggle(Islands, { "Teleport To Fruit Dealer" }, "MirageFruitDealer")
        Toggle(Islands, { "Collect Mirage Chests" }, "MirageChests")
        Islands:AddToggle({
			"Look To Moon",
			false,
			function(arg149)
            _ENV.LookMoon = arg149

            while _ENV.LookMoon do
                CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, Lighting:GetMoonDirection() + CurrentCamera.CFrame.Position)
                task.wait()
            end
        end,
			"MirageLookMoon"
		})
    else
        Islands:Destroy()
    end
    local FruitRaid = loadTabsResult.FruitRaid
    local tbl61 = {
		"Rocket",
		"Spin",
		"Blade",
		"Spring",
		"Bomb",
		"Smoke",
		"Spike"
	}
    local flag6 = true
    local val97
    FruitRaid:AddSection("Fruits")
    FruitRaid:AddToggle({
		"Auto Store Fruits",
		false,
		function(arg150)
        _ENV.auto_store = arg150

        while _ENV.auto_store do
            task.wait(not settings.SmoothMode and 0.2 or 0.3)
            flag6 = false

            local flag7 = not LocalPlayer:GetAttribute("IslandRaiding")

            if flag7 then
                flag7 = _ENV.unstore_common_fruits and val97
            end

            local StorableFruit = FruitManager:GetStorableFruit(flag7)

            if StorableFruit then
                FruitManager:StoreFruit(StorableFruit)
                val97 = nil
            else
                flag6 = true
            end
        end

        flag6 = true
    end,
		"F-AutoStore"
	})
    Toggle(FruitRaid, { "Teleport To Fruits" }, "Fruits")
    FruitRaid:AddToggle({
		"Auto Random Fruit",
		false,
		function(arg151)
        _ENV.random_fruit = arg151

        while _ENV.random_fruit do
            FruitManager:RerollRandomFruit()
            task.wait(0.1)
        end
    end,
		"F-RandomFruit"
	})
    FruitRaid:AddSection("Raid")
    if Sea ~= 2 and Sea ~= 3 then
        FruitRaid:AddParagraph({ "Only on Sea 2 and 3" })
    else
        FruitRaid:AddDropdown({
			"Select Chip",
			Module.RaidList,
			"",
			{
				settings,
				"SelectedChip"
			},
			"R-RaidChip"
		})
        Toggle(FruitRaid, {
			"Auto Farm Raid",
			"Kill Aura, Start & Awaken"
		}, "Raid")
        FruitRaid:AddToggle({
			"Auto Buy Chip",
			false,
			function(arg152)
            _ENV.raid_microchip = arg152

            while _ENV.raid_microchip do
                if not flag6 then
                    task.wait()
                elseif FruitManager:CanBuyMicrochip() then
                    FireRemote("RaidsNpc", "Select", settings.SelectedChip)
                else
                    task.wait(0.1)
                end
            end
        end,
			"R-BuyChip"
		})
        FruitRaid:AddToggle({
			"Unstore Common Fruits",
			false,
			function(arg153)
            _ENV.unstore_common_fruits = arg153

            while _ENV.unstore_common_fruits do
                if FruitManager:CanBuyMicrochip() == -1 and flag6 then
                    for i = 1, #tbl61 do
                        local val98 = tbl61[i]
                        local val99 = val98 .. "-" .. val98

                        if LocalPlayer.Character:FindFirstChild(val99) or LocalPlayer.Backpack:FindFirstChild(val99) then
                            break
                        end

                        if Count[val99] > 0 then
                            val97 = val98 .. " Fruit"
                            FireRemote("LoadFruit", val99)

                            break
                        end
                    end
                end

                task.wait(0.25)
            end
        end,
			"R-Unstore"
		})
    end
    local Teleport = loadTabsResult.Teleport
    local cFrame = CFrame.new(28286, 14897, 103)
    local val100 = ({
		{
			"WindMill",
			"Marine",
			"Middle Town",
			"Jungle",
			"Pirate Village",
			"Desert",
			"Snow Island",
			"MarineFord",
			"Colosseum",
			"Sky Island 1",
			"Sky Island 2",
			"Sky Island 3",
			"Prison",
			"Magma Village",
			"Under Water Island",
			"Fountain City"
		},
		{
			"The Cafe",
			"Frist Spot",
			"Dark Area",
			"Flamingo Mansion",
			"Flamingo Room",
			"Green Zone",
			"Zombie Island",
			"Two Snow Mountain",
			"Punk Hazard",
			"Cursed Ship",
			"Ice Castle",
			"Forgotten Island",
			"Ussop Island"
		},
		{
			"Mansion",
			"Port Town",
			"Great Tree",
			"Castle On The Sea",
			"Hydra Island",
			"Floating Turtle",
			"Haunted Castle",
			"Ice Cream Island",
			"Peanut Island",
			"Cake Island",
			"Candy Cane Island",
			"Tiki Outpost"
		}
	})[Sea]
    local cFrame7 = CFrame.new(-688, 15, 1585)
    local cFrame8 = CFrame.new(-4810, 21, 4359)
    local cFrame9 = CFrame.new(-2728, 25, 2056)
    local cFrame10 = CFrame.new(889, 17, 1434)
    local cFrame11 = CFrame.new(1054, 53, 4490)
    local cFrame12 = CFrame.new(1298, 87, -1344)
    local cFrame13 = CFrame.new(-1173, 45, 3837)
    local cFrame14 = CFrame.new(-1614, 37, 146)
    local cFrame15 = CFrame.new(4870, 6, 736)
    local cFrame16 = CFrame.new(61164, 5, 1820)
    local cFrame17 = CFrame.new(-1535, 7, -3014)
    local cFrame18 = CFrame.new(-5290, 9, 8349)
    local cFrame19 = CFrame.new(-4814, 718, -2551)
    local tbl62 = {
		["Middle Town"] = cFrame7,
		MarineFord = cFrame8,
		Marine = cFrame9,
		WindMill = cFrame10,
		Desert = cFrame11,
		["Snow Island"] = cFrame12,
		["Pirate Village"] = cFrame13,
		Jungle = cFrame14,
		Prison = cFrame15,
		["Under Water Island"] = cFrame16,
		Colosseum = cFrame17,
		["Magma Village"] = cFrame18,
		["Sky Island 1"] = cFrame19,
		["Sky Island 2"] = CFrame.new(-4652, 873, -1754),
		["Sky Island 3"] = CFrame.new(-7895, 5547, -380),
		["Fountain City"] = CFrame.new(5041, 1, 4101),
		["The Cafe"] = CFrame.new(-382, 73, 290),
		["Frist Spot"] = CFrame.new(-11, 29, 2771),
		["Dark Area"] = CFrame.new(3494, 13, -3259),
		["Flamingo Mansion"] = CFrame.new(-317, 331, 597),
		["Flamingo Room"] = CFrame.new(2285, 15, 905),
		["Green Zone"] = CFrame.new(-2258, 73, -2696),
		["Zombie Island"] = CFrame.new(-5552, 194, -776),
		["Two Snow Mountain"] = CFrame.new(752, 408, -5277),
		["Punk Hazard"] = CFrame.new(-5897, 18, -5096),
		["Cursed Ship"] = CFrame.new(919, 125, 32869),
		["Ice Castle"] = CFrame.new(5505, 40, -6178),
		["Forgotten Island"] = CFrame.new(-3050, 240, -10178),
		["Ussop Island"] = CFrame.new(4816, 8, 2863),
		Mansion = CFrame.new(-12471, 374, -7551),
		["Port Town"] = CFrame.new(-345, 21, 5542),
		["Castle On The Sea"] = CFrame.new(-5073, 315, -3153),
		["Hydra Island"] = CFrame.new(5666, 1013, -310),
		["Great Tree"] = CFrame.new(2683, 275, -7008),
		["Floating Turtle"] = CFrame.new(-12528, 332, -8658),
		["Haunted Castle"] = CFrame.new(-9517, 142, 5528),
		["Ice Cream Island"] = CFrame.new(-902, 79, -10988),
		["Peanut Island"] = CFrame.new(-2062, 50, -10232),
		["Cake Island"] = CFrame.new(-1897, 14, -11576),
		["Candy Cane Island"] = CFrame.new(-1038, 10, -14076),
		["Tiki Outpost"] = CFrame.new(-16224, 9, 439)
	}
    Teleport:AddSection("Travel")
    Teleport:AddButton({
		"Teleport to Sea 1",
		function()
        Module:TravelTo(1)
    end,
		Desc = "Main"
	})
    Teleport:AddButton({
		"Teleport to Sea 2",
		function()
        Module:TravelTo(2)
    end,
		Desc = "Dressrosa"
	})
    Teleport:AddButton({
		"Teleport to Sea 3",
		function()
        Module:TravelTo(3)
    end,
		Desc = "Zou"
	})
    Teleport:AddSection("Islands")
    Teleport:AddDropdown({
		"Select Island",
		val100,
		"",
		{
			_ENV,
			"SelectedIsland"
		}
	})
    Teleport:AddToggle({
		"Teleport to Island",
		false,
		function(arg154)
        _ENV.teleporting = arg154

        while _ENV.teleporting do
            task.wait()

            if tbl62[_ENV.SelectedIsland] then
                MoveCharacter(tbl62[_ENV.SelectedIsland])
            end
        end

    end
	}):Callback(function(arg155)
        if arg155 then
            local TweenManager = arg141.Managers.TweenManager
            local huge = math.huge

            if _ENV.teleporting then
                if not (huge < 15) then
                end
            end

            repeat
                task.wait()

                if TweenManager:GetLastPosition() then
                    local GetLastPosition = TweenManager.GetLastPosition

                    huge = LocalPlayer:DistanceFromCharacter(GetLastPosition(TweenManager))
                end
            until not _ENV.teleporting or huge < 15

            _ENV.teleporting = false
        end
    end)
    if Sea == 3 then
        Teleport:AddSection("Race V4")
        Teleport:AddButton({
			"Teleport to Temple of Time",
			function()
            if not Map:FindFirstChild("Temple of Time") then
                ReplicatedStorage.MapStash["Temple of Time"].Parent = Map
            end

            for _ = 1, 10 do
                task.wait()
                LocalPlayer.Character:SetPrimaryPartCFrame(cFrame)
            end
        end
		})
    end
    local Status = loadTabsResult.Status
    local _ = FarmManager.Enemies.Elites
    local IsSpawned = Module.Enemies.IsSpawned
    local timestamp
    local tbl63 = {
		"🌑",
		"🌘",
		"🌗",
		"🌖",
		"🌕",
		"🌔",
		"🌓",
		"🌒"
	}
    local tbl64 = {}
    local num11 = 0
    local function NewStatusParagraph(arg156, arg270)
        if arg270 ~= false then
            table.insert(tbl64, {
				Paragraph = Status:AddParagraph({ "" }),
				Function = arg156
			})
        end
    end
    NewStatusParagraph(function()
        local Progress = Module:GetProgress("EliteProgress", "EliteHunter", "Progress")
        local EnemyByTag = Module.Enemies:GetEnemyByTag("Elite")

        if EnemyByTag then
            local EnemyByTagName = EnemyByTag.Name

            return ("Elite Progress: %i\nElite Hunter: %s %s").format("Elite Progress: %i\nElite Hunter: %s %s", Progress, EnemyByTagName, "🟢")
        end

        local val101 = timestamp

        if val101 then
            val101 = 600 - (tick() - timestamp) >= 0 and tbl4.GetTimer(600 - (tick() - timestamp) or "00:00")
        end

        local val102 = (val101 or "") .. "🔴"

        return ("Elite Progress: %i\nElite Hunter: %s").format("Elite Progress: %i\nElite Hunter: %s", Progress, val102)
    end, Sea == 3)
    NewStatusParagraph(function()
        local val103 = if not IsSpawned("Cake Prince") then IsSpawned("Dough King") and "Dough King" else "Cake Prince"

        if val103 then
            return ("Katakuri: %s %s").format("Katakuri: %s %s", val103, "🟢")
        end

        local gsub4 = string.gsub(Module:GetProgress("Katakuri", "CakePrinceSpawner", true), "%D", "")

        return "Katakuri: " .. if gsub4:len() ~= 0 then gsub4 else "0"
    end, Sea == 3)
    NewStatusParagraph(function()
        if IsSpawned("Tyrant of the Skies") then
            return "Tyrant of the Skies: 🟢"
        end

        local TikiOutpost = Map.TikiOutpost
        local num12 = 0

        for i = 1, 4 do
            local eye = TikiOutpost:FindFirstChild("Eye" .. i, true)

            if eye and eye.Transparency == 0 then
                num12 += 1
            end
        end

        local val104 = num12 ~= 4 and "🔴" or "🟠"

        return ("Tyrant of the Skies: %i/4 %s").format("Tyrant of the Skies: %i/4 %s", num12, val104)
    end, Sea == 3)
    NewStatusParagraph(function()
        local Progress = Module:GetProgress("Sword Dealer", "LegendarySwordDealer", "1")

        if type(Progress) == "string" then
            return ("Sword Dealer: %s %s").format("Sword Dealer: %s %s", Progress, "🟢")
        end

        return ("Sword Dealer: %s").format("Sword Dealer: %s", "🔴")
    end, Sea == 2)
    NewStatusParagraph(function()
        local val105, val106 = Module:GetProgress("BaristaCousin", "ColorsDealer", "1")

        if type(val105) == "string" then
            local flag8 = not ((val106 or 1) >= 3) and "Rare" or "LEGENDARY"

            return ("Barista Cousin: %s [ %s ] %s").format("Barista Cousin: %s [ %s ] %s", val105, flag8, "🟢")
        end

        return "Barista Cousin: 🔴"
    end)
    NewStatusParagraph(function()
        local fruit = workspace:FindFirstChild("Fruit ")

        if fruit then
            local RealFruitName = Module:GetRealFruitName(fruit)
            local val107 = ("Fruit [ %s-%s ]").format("Fruit [ %s-%s ]", RealFruitName, RealFruitName)

            return ("Devil Fruit: %s %s").format("Devil Fruit: %s %s", val107, "🟢")
        end

        return "Devil Fruit: 🔴"
    end)
    NewStatusParagraph(function()
        local tbl65 = {}

        for i = 1, #tbl3.Berries do
            local val108 = i

            if val108 % 10 == 0 then
                task.wait(0.1)
            end

            local val109 = tbl3.Berries[val108]
            local GetAttributes = val109.GetAttributes

            for _, v in pairs(GetAttributes(val109)) do
                table.insert(tbl65, (string.sub(v, 1, -7)))
            end
        end

        if #tbl65 > 0 then
            local val110 = #tbl65
            local concat2 = table.concat(tbl65, ", ")

            return ("Berries: #%i [ %s ] %s").format("Berries: #%i [ %s ] %s", val110, concat2, "🟢")
        end

        return "Berries: 🔴"
    end)
    NewStatusParagraph(function()
        return "Players: " .. #Players:GetPlayers() .. "/12"
    end)
    NewStatusParagraph(function()
        local val111 = #rzFarmFunctions
        local val112 = #rzFunctions
        local val113 = settings.RunningOption or "Null"
        local RunningMethod = settings.RunningMethod

        return ("Enabled Options: %i/%i\nFarm Status: %s [ %s ]").format("Enabled Options: %i/%i\nFarm Status: %s [ %s ]", val111, val112, val113, RunningMethod or "Null")
    end)
    NewStatusParagraph(function()
        local MoonPhase = Lighting:GetAttribute("MoonPhase")
        local ClockTime = Lighting.ClockTime

        if ClockTime >= 6 and ClockTime < 12 then
            MoonPhase += 1
        end

        local val114 = tbl63[MoonPhase]
        local val115 = ClockTime > 18 or (not (ClockTime < 6) and "🟠" or "🟢")

        return ("MoonPhase: %s %i/8 %s").format("MoonPhase: %s %i/8 %s", val114, MoonPhase, val115)
    end, Sea == 3)
    local num13 = 1
    local connection
    connection = Stepped:Connect(function()
        if not Status or not Status.Cont then
            return connection:Disconnect()
        end

        local val116 = Sea == 3

        if val116 then
            val116 = num13 == 1 and tick() - num11 >= 1
        end

        if val116 then
            if not Status.Cont.Parent then
                num11 = tick()
            end

            if Module.Enemies:GetEnemyByTag("Elite") then
                timestamp = tick()
            end
        end

        if tick() - num11 >= 1 and Status.Cont.Parent then
            local val117 = tbl64[num13]

            num13 = if not (num13 >= #tbl64) then num13 + 1 else 0

            if num13 >= #tbl64 then
                num11 = tick()
            end

            if val117 and not val117.Updating then
                val117.Updating = true

                local Paragraph = val117.Paragraph
                local tbl66 = { val117.Function() }

                Paragraph:SetTitle(unpackValues(tbl66))
                val117.Updating = false
            end
        end
    end)
    local Visual = loadTabsResult.Visual
    local EspManager = arg141.Managers.EspManager
    local SeaManager = arg141.Managers.SeaManager
    local tbl67 = {}
    local color3 = Color3.fromRGB(220, 220, 220)
    local color3_2 = Color3.fromRGB(255, 0, 0)
    local color3_3 = Color3.fromRGB(0, 255, 255)
    local color3_4 = Color3.fromRGB(255, 255, 0)
    local color3_5 = Color3.fromRGB(255, 255, 0)
    local color3_6 = Color3.fromRGB(150, 150, 150)
    local color3_7 = Color3.fromRGB(255, 255, 0)
    local color3_8 = Color3.fromRGB(0, 255, 255)
    local color3_9 = Color3.fromRGB(150, 0, 255)
    local tbl68 = {
		Chest1 = color3_6,
		Chest2 = color3_7,
		Chest3 = color3_8,
		Other = color3_9
	}
    tbl67.MyBoat = EspManager.new("MyBoat"):SetEspColor(color3_5):SetCustomEspDisplay(function(arg157, arg271)
        local Humanoid = arg157:FindFirstChild("Humanoid")
        local OriginalMaxHealth = arg157:GetAttribute("OriginalMaxHealth")

        return ("My Boat<font color='rgb(170, 170, 0)'> [ %im ]</font>\n<font color='rgb(25, 240, 25)'>[%i/%i]</font>"):format(arg271, Humanoid and Humanoid.Value or OriginalMaxHealth, OriginalMaxHealth)
    end):GetInstance(function()
        return select(1, SeaManager:GetMyBoat())
    end)
    tbl67.Players = EspManager.new("Players"):SetEspColor(color3):SetObjects(Characters):Validator(function(arg158)
        return arg158 ~= LocalPlayer.Character
    end)
    tbl67.Islands = EspManager.new("Islands"):SetEspColor(color3_3):SetObjects(Locations):Validator(function(arg159)
        return arg159.Name ~= "Sea" and string.sub(arg159.Name, 1, 6) ~= "Trial "
    end)
    tbl67.Fruits = EspManager.new("Fruits"):SetEspColor(color3_2):SetObjects(workspace):WaitChildsAdded():Validator(function(arg160)
        if arg160.Name == "Fruit " then
            local RealFruitName = Module:GetRealFruitName(arg160)
            local Fruits = tbl67.Fruits
            local tbl69 = { ("Fruit [ %s-%s ]").format("Fruit [ %s-%s ]", RealFruitName, RealFruitName) }

            Fruits:SetInstanceName(arg160, unpackValues(tbl69))
        end

        if string.find(arg160.Name, "Fruit") and arg160:IsA("Model") then
            return arg160.ClassName ~= "Model" or arg160.WorldPivot.Position ~= Vector3.zero
        end
    end)
    tbl67.Flowers = EspManager.new("Flowers"):SetObjects(workspace):WaitChildsAdded():SetEspColor(function(arg161)
        return arg161.Color
    end):Validator(function(arg162)
        return string.sub(arg162.Name, 1, 6) == "Flower"
    end)
    tbl67.Chests = EspManager.new("Chests"):SetObjects(tbl3.Chests):SetAlwaysValidate():SetEspColor(function(arg163)
        return tbl68[arg163.Name] or tbl68.Other
    end):Validator(function(arg164)
        return not arg164:GetAttribute("IsDisabled")
    end)
    tbl67.Berries = EspManager.new("Berries"):SetObjects(tbl3.Berries):SetAlwaysValidate():SetEspColor(color3_4):Validator(function(arg165)
        local val118, val119, val120 = pairs(arg165:GetAttributes())
        local val121, val122 = val118(val119, val120)

        if val121 then
            tbl67.Berries:SetInstanceName(arg165, val122)

            return true
        end
    end)
    if not Module:IsBlacklistedExecutor() then
        Visual:AddSection("Aimbot Nearest")
        Visual:AddToggle({
			"Aimbot Gun",
			false,
			{
				_ENV,
				"AimBot_Gun"
			}
		})
        Visual:AddToggle({
			"Aimbot Tap",
			false,
			{
				_ENV,
				"AimBot_Tap"
			}
		})
        Visual:AddToggle({
			"Aimbot Skills",
			false,
			{
				_ENV,
				"AimBot_Skills"
			}
		})
        Visual:AddToggle({
			"Ignore Mobs",
			true,
			{
				settings,
				"NoAimMobs"
			}
		})
    end
    Visual:AddSection("ESP")
    Visual:AddSlider({
		"Esp Size",
		7,
		15,
		1,
		10,
		function(...)
        EspManager:ChangeEspSize(...)
    end,
		"S-EspSize"
	})
    if Sea == 2 then
        Visual:AddToggle({
			"ESP Flowers",
			false,
			{
				tbl67.Flowers,
				"Enabled"
			},
			"Esp-Flower"
		})
    end
    if Sea ~= 1 then
        Visual:AddToggle({
			"ESP My Boat",
			false,
			{
				tbl67.MyBoat,
				"Enabled"
			},
			"Esp-MyBoat"
		})
    end
    Visual:AddToggle({
		"ESP Players",
		false,
		{
			tbl67.Players,
			"Enabled"
		},
		"Esp-Players"
	})
    Visual:AddToggle({
		"ESP Fruits",
		false,
		{
			tbl67.Fruits,
			"Enabled"
		},
		"Esp-Fruits"
	})
    Visual:AddToggle({
		"ESP Berries",
		false,
		{
			tbl67.Berries,
			"Enabled"
		},
		"Esp-Berry"
	})
    Visual:AddToggle({
		"ESP Chests",
		false,
		{
			tbl67.Chests,
			"Enabled"
		},
		"Esp-Chests"
	})
    Visual:AddToggle({
		"ESP Islands",
		false,
		{
			tbl67.Islands,
			"Enabled"
		},
		"Esp-Island"
	})
    Visual:AddSection("Visual")
    Visual:AddButton({
		"Meteor Rain",
		function()
        require(game:GetService("ReplicatedStorage").Effect.Container.UzothSpec)({
				Position = LocalPlayer.Character.PrimaryPart.Position
			})
    end
	})
    Visual:AddButton({
		"Remove Portal Dash Cooldown",
		function()
        local portalPortal = LocalPlayer.Backpack:FindFirstChild("Portal-Portal") or LocalPlayer.Character:FindFirstChild("Portal-Portal")

        if portalPortal then
            local _next = next
            local val123, val124 = getconnections(portalPortal.Activated)

            while true do
                local val125

                val124, val125 = _next(val123, val124)

                if not val124 then
                    break
                end

                if #debug.getupvalues(val125.Function) == 9 then
                    while true do
                        local elapsed = task.wait()

                        if elapsed then
                            elapsed = portalPortal and portalPortal:IsDescendantOf(game)
                        end

                        if not elapsed then
                            break
                        end

                        debug.setupvalue(val125.Function, 2, 0)
                    end
                end
            end
        end
    end
	})
    local Shop = loadTabsResult.Shop
    for _, v in ipairs(Module.Shop) do
        Shop:AddSection(v[1])

        for _, item in ipairs(v[2]) do
            local val126 = item
            local val127 = val126[2]

            if type(val126[2]) == "table" then
                function val127()
                    FireRemote(unpack(val126[2]))
                end
            end

            Shop:AddButton({
				val126[1],
				val127
			})
        end
    end
    local Misc = loadTabsResult.Misc
    local val128
    local function helper19(arg166, arg272)
        for i = #arg272, 2, -1 do
            local nextIntegerResult = arg166:NextInteger(1, i)
            local val129 = arg272[nextIntegerResult]
            local val130 = arg272[i]

            arg272[i] = val129
            arg272[nextIntegerResult] = val130
        end
    end
    local function helper20(arg167)
        local reverse2 = string.reverse(arg167)
        local num = tonumber("-" .. string.sub(reverse2, -2, -1))
        local sub2 = string.sub(reverse2, 1, -3)
        local tbl70 = {
			"0",
			"1",
			"2",
			"3",
			"4",
			"5",
			"6",
			"7",
			"8",
			"9"
		}
        local tbl71 = {
			"a",
			"b",
			"c",
			"d",
			"e",
			"f",
			"g",
			"h",
			"i",
			"j",
			"k",
			"l",
			"n",
			"o",
			"p",
			"q",
			"r",
			"s",
			"t",
			"u"
		}
        local tbl72 = {
			8,
			4,
			4,
			4,
			12
		}
        local random = Random.new(num)

        helper19(random, tbl70)
        helper19(random, tbl71)

        for i = 1, #tbl70 do
            local val131 = tbl70[i]
            local gsub5 = string.gsub(sub2, tbl71[i + 10], val131 .. val131)

            sub2 = string.gsub(gsub5, tbl71[i], val131)
        end

        local tbl73 = {}
        local num14 = 1

        for i = 1, #tbl72 do
            table.insert(tbl73, (string.sub(sub2, num14, num14 + tbl72[i] - 1)))
            num14 += tbl72[i]
        end

        return string.lower(table.concat(tbl73, "-"))
    end
    local function helper21(arg168)
        local gsubResult = arg168:gsub("\n", ""):gsub("```", ""):gsub("`", "")

        if string.sub(gsubResult, 1, 5) ~= "redz-" then
            return string.sub(gsubResult, 6, -1)
        end

        return helper20(string.sub(gsubResult, 6, -1))
    end
    local function helper22(arg169)
        ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", arg169)
    end
    local val132
    local val133
    if IsOwner then
        Misc:AddSection("Executor")
        Misc:AddButton({
			"Execute Clipboard",
			function()
            loadstring((getclipboard or fromclipboard)())()
        end
		})
    end
    if Module.JobIds then
        Misc:AddSection("Join Server")
        Misc:AddTextBox({
			"Input Job Id",
			"1",
			true,
			helper22,
			"JobId"
		}).OnChanging = function(arg170)
            return helper21(arg170)
        end
        Misc:AddButton({
			"Join Clipboard",
			function()
            helper22((getclipboard or fromclipboard)())
        end
		})
    end
    Misc:AddSection("Settings")
    Misc:AddDropdown({
		"Farm Mode",
		{
			"Up",
			"Orbit",
			"Star"
		},
		"Up",
		{
			settings,
			"FarmMode"
		},
		"S-FarmMode"
	})
    Misc:AddSlider({
		"Farm Distance",
		5,
		30,
		1,
		15,
		function(arg171)
        settings.FarmPos = Vector3.new(0, arg171, 0)
        settings.FarmDistance = arg171
    end,
		"S-Distance"
	})
    Misc:AddSlider({
		"Tween Speed",
		50,
		300,
		5,
		200,
		{
			settings,
			"TweenSpeed"
		},
		"S-TweenSpeed"
	})
    Misc:AddSlider({
		"Bring Mobs Distance",
		50,
		400,
		10,
		250,
		{
			settings,
			"BringDistance"
		},
		"S-BringDistance"
	})
    Misc:AddToggle({
		"Bring Mobs",
		true,
		{
			settings,
			"BringMobs"
		},
		"S-BringMobs"
	})
    Misc:AddToggle({
		"Auto Haki",
		true,
		{
			settings,
			"AutoBuso"
		},
		"S-AutoBuso"
	})
    Misc:AddToggle({
		"Auto Attack",
		true,
		{
			settings,
			"AutoClick"
		},
		"S-AutoClick"
	})
    Misc:AddToggle({
		"Auto Shoot",
		false,
		{
			settings,
			"AutoShoot"
		},
		"S-AutoShoot"
	})
    Misc:AddToggle({
		"Take Quest Debounce",
		false,
		{
			arg141.Managers.QuestManager,
			"takeQuestDebounce"
		},
		"S-QuestDenounce",
		Desc = "Wait 75 seconds to take the next mission"
	})
    Misc:AddSection("Codes")
    Misc:AddButton({
		"Redeem all Codes",
		tbl4.AllCodes
	})
    Misc:AddSection("Server")
    Misc:AddButton({
		"Server Hop",
		function()
        Module:ServerHop()
    end
	})
    Misc:AddButton({
		"Rejoin",
		function()
        Module.Rejoin()
    end
	})
    Misc:AddSection("Team")
    Misc:AddButton({
		"Join Pirates Team",
		tbl2.Pirates
	})
    Misc:AddButton({
		"Join Marines Team",
		tbl2.Marines
	})
    Misc:AddSection("Race")
    Misc:AddToggle({
		"Auto Active Race V3",
		false,
		function(arg172)
        _ENV.ActiveRaceV3 = arg172

        while _ENV.ActiveRaceV3 do
            if Data.Race:FindFirstChild("Evolved") then
                Remotes.CommE:FireServer("ActivateAbility")
            else
                Data.Race.ChildAdded:Wait()
            end

            task.wait(not settings.SmoothMode and 1 or 2.5)
        end
    end,
		"S-RaceV3"
	})
    Misc:AddToggle({
		"Auto Active Race V4",
		false,
		function(arg173)
        _ENV.ActiveRaceV4 = arg173

        while _ENV.ActiveRaceV4 do
            local val134 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local RaceTransformed = val134:FindFirstChild("RaceTransformed")
            local RaceEnergy = val134:FindFirstChild("RaceEnergy")

            if RaceEnergy then
                RaceEnergy = RaceEnergy.Value >= 1

                if RaceEnergy then
                    RaceEnergy = RaceTransformed and not RaceTransformed.Value
                end
            end

            if RaceEnergy then
                local awakening = LocalPlayer.Backpack:FindFirstChild("Awakening") or val134:FindFirstChild("Awakening")

                if awakening:FindFirstChild("RemoteFunction") then
                    awakening.RemoteFunction:InvokeServer(true)
                end
            end

            task.wait(not settings.SmoothMode and 0.5 or 1)
        end
    end,
		"S-RaceV4"
	})
    Misc:AddSection("Menu")
    Misc:AddButton({
		"Devil Fruit Shop",
		function()
        require(LocalPlayer.PlayerGui.Main.UIController.FruitShop):Open("FruitDealer")
    end
	})
    Misc:AddButton({
		"Advanced Fruit Dealer",
		function()
        require(LocalPlayer.PlayerGui.Main.UIController.FruitShop):Open("AdvancedFruitDealer")
    end
	})
    Misc:AddButton({
		"Titles",
		function()
        FireRemote("getTitles")
        LocalPlayer.PlayerGui.Main.Titles.Visible = true
    end
	})
    if not Module:IsBlacklistedExecutor() then
        Misc:AddSection("Local-Player")
        Misc:AddToggle({
			"Enable Speed Hack",
			false,
			function(arg174)
            if arg174 then
                Module.Hooking:EnableBypass()
            end

            _ENV.WalkSpeedBypass = arg174 and val133 or false
            val132 = arg174
        end,
			"M-WalkSpeed:A"
		})
        Misc:AddSlider({
			"Walk Speed",
			10,
			300,
			5,
			150,
			function(arg175)
            _ENV.WalkSpeedBypass = val132 and arg175 or false
            val133 = arg175
        end,
			"M-WalkSpeed:B"
		})
    end
    Misc:AddSection("Visual")
    Misc:AddButton({
		"Remove Fog",
		function()
        if Lighting:FindFirstChild("LightingLayers") then
            Lighting.LightingLayers:Remove()
        end
    end
	})
    Misc:AddSection("More FPS")
    Misc:AddToggle({
		"Smooth Farm Mode",
		false,
		{
			settings,
			"SmoothMode"
		},
		"SmoothFarm",
		Desc = "Reduces calculation speed to improve FPS"
	})
    Misc:AddToggle({
		"Remove Damage",
		false,
		function(arg176)
        ReplicatedStorage.Assets.GUI.DamageCounter.Enabled = not arg176
    end,
		"M-DamageCounter"
	})
    Misc:AddToggle({
		"Remove Notifications",
		false,
		function(arg177)
        LocalPlayer.PlayerGui.Notifications.Enabled = not arg177
    end,
		"M-Notifications"
	})
    Misc:AddSection("Others")
    Misc:AddToggle({
		"Walk On Water",
		true,
		function(arg178)
        _ENV.WalkOnWater = arg178

        local waterBasePlane = Map:WaitForChild("WaterBase-Plane", 9000000000)
        local val135 = val128 or waterBasePlane.Size
        local vector3 = Vector3.new(val135.X, 113, val135.Z)

        val128 = val135

        while task.wait(0.25) and _ENV.WalkOnWater do
            if Module.IsAlive(LocalPlayer.Character) and LocalPlayer.Character.Humanoid.Sit then
                waterBasePlane.Size = val135
            else
                waterBasePlane.Size = vector3
            end
        end

        waterBasePlane.Size = val135
    end,
		"M-WalkOnWater"
	})
    Misc:AddToggle({
		"Anti AFK",
		true,
		function(arg179)
        _ENV.AntiAFK = arg179

        while _ENV.AntiAFK do
            VirtualUser:CaptureController()

            local val136 = VirtualUser
            local tbl74 = { Vector2.new(math.huge, math.huge) }

            val136:ClickButton1(unpackValues(tbl74))
            task.wait(600)
        end
    end,
		"M-AntiAFK"
	})
    local Items = loadTabsResult.Items
    if Sea == 3 then
        Items:AddSection("Dragon Dojo")
        Toggle(Items, {
			"Auto Dojo Trainer Quest",
			"Automatically completes Dojo Trainer quests"
		}, "DojoTrainer")
        Toggle(Items, {
			"Auto Dragon Hunter Quest",
			"Automatically completes Dragon Hunter quests"
		}, "DragonHunter")
        Toggle(Items, {
			"Auto Draco V2 & V3",
			"Evolves the Draco Race to V2 and V3"
		}, "DracoV2V3")
        Items:AddSection("Farm")
        Toggle(Items, {
			"Auto Elite Hunter",
			"Automatically completes Elite Hunter quests"
		}, "EliteHunter")
   --[[     Toggle(Items, {
			"Auto Rip Indra",
			"Activates the plates and summons Rip Indra"
		}, "RipIndra")]]
        Toggle(Items, {
			"Auto Cake Prince",
			"Automatically summons the Cake Prince"
		}, "CakePrince")
        Toggle(Items, {
			"Auto Dough King",
			"Automatically summons the Dough King"
		}, "DoughKing")
        Toggle(Items, {
			"Auto Tyrant of the Skies",
			"Kill mobs and the Eagle Boss"
		}, "TyrantSkies")
        Items:AddSection("Sword")
        Toggle(Items, {
			"Auto Collect Yama",
			"Automatically collects the Yama sword after defeating 30 Elite Hunters"
		}, "Yama")
        Toggle(Items, {
			"Auto Tushita",
			"Solves the Tushita puzzle and defeats Longma"
		}, "Tushita")
        Toggle(Items, {
			"Auto Cursed Dual Katana",
			"Complete the Cursed Dual Katana puzzle"
		}, "CursedDualKatana")
        Items:AddSection("Mastery")
        Toggle(Items, { "Auto Mastery all Swords" }, "MasterySwords")
        Items:AddSection("Quest")
        Toggle(Items, { "Auto Citizen Quest" }, "Citizen")
        Toggle(Items, { "Auto Rainbow Haki" }, "RainbowHaki")
    elseif Sea == 2 then
        Items:AddSection("Third Sea")
        Toggle(Items, {
			"Auto Third Sea",
			"Automatically unlocks access to the Third Sea"
		}, "ThirdSea")
        Toggle(Items, {
			"Auto Kill Don Swan",
			"Automatically defeats Don Swan"
		}, "DonSwan")
        Items:AddSection("Bosses")
        Toggle(Items, {
			"Auto Darkbeard",
			"Automatically spawns and defeats Darkbeard"
		}, "Darkbeard")
        Toggle(Items, {
			"Auto Cursed Captain",
			"Automatically summons and defeats the Cursed Captain"
		}, "CursedCaptain")
        Items:AddSection("Law")
        Toggle(Items, {
			"Fully Raid Law",
			"Automatically spawns and defeats Law (Order)"
		}, "Order")
        Items:AddToggle({
			"Auto Start [ Fully ]",
			true,
			{
				settings,
				"StartLaw"
			},
			"S-RaidLaw",
			Desc = "Automatically spawns and defeats Law (Order)"
		})
        Items:AddSection("Sword")
        Items:AddToggle({
			"Auto Buy Legendary Sword",
			false,
			function(arg180)
            _ENV.LegendSword = arg180

            while task.wait() and _ENV.LegendSword do
                local result32 = FireRemote("LegendarySwordDealer", "1")

                if type(result32) == "string" then
                    if Unlocked[result32] then
                        task.wait(13500)
                    elseif Beli.Value >= 2000000 then
                        FireRemote("LegendarySwordDealer", "2")
                    else
                        Beli:GetPropertyChangedSignal("Value"):Wait()
                    end
                else
                    task.wait(5)
                end
            end
        end,
			"LegendSword",
			Desc = "Automatically purchases Legendary Swords when available"
		})
        Toggle(Items, {
			"Auto Rengoku",
			"Automatically kill Ice Admiral to unlock the Rengoku sword"
		}, "Rengoku")
        Items:AddSection("Race")
        Toggle(Items, {
			"Auto Race V2",
			"Automatically evolves the Race to V2"
		}, "RaceV2")
        Toggle(Items, {
			"Auto Race V3",
			"Mink, Human & Shark"
		}, "RaceV3")
        Items:AddSection("Bartilo")
        Toggle(Items, {
			"Auto Bartilo Quest",
			"Req: Level 850"
		}, "Bartilo")
    elseif Sea == 1 then
        Items:AddSection("Second Sea")
        Toggle(Items, {
			"Auto Second Sea",
			"Automatically unlocks access to the Second Sea"
		}, "SecondSea")
        Items:AddSection("Swords")
        Toggle(Items, {
			"Auto Unlock Saber",
			"Automatically unlocks the Saber Sword"
		}, "Saber")
        Toggle(Items, {
			"Auto Pole V1",
			"Kill Thunder God"
		}, "PoleV1")
        Toggle(Items, {
			"Auto Saw Sword",
			"Kill The Saw"
		}, "TheSaw")
    end
    Items:AddSection("Berries")
    Toggle(Items, { "Auto Collect Berries" }, "BerryBush")
    Items:AddToggle({
		"Auto Berry Hop",
		false,
		{
			settings,
			"BerryHop"
		},
		"S-BerryHop"
	})
    if Sea ~= 1 then
        Items:AddSection("Aura Color")
        Items:AddToggle({
			"Auto Barista Cousin",
			false,
			function(arg181)
            _ENV.barista_cousin = arg181

            while _ENV.barista_cousin do
                local response, _ = FireRemote("ColorsDealer", "1")

                if type(response) == "string" then
                    local result33 = FireRemote("ColorsDealer", "2")

                    if result33 == 1 or result33 == 2 then
                        task.wait(250)
                    elseif result33 == 0 then
                        Beli:GetPropertyChangedSignal("Value"):Wait()
                    end
                else
                    task.wait(5)
                end
            end
        end,
			"B-Cousin"
		})
    end
end
function Core2.StartFarm(_)
    if not _ENV.loadedFarm then
        _ENV.loadedFarm = true
        task.spawn(Module.RunFunctions.FarmQueue, rzFarmFunctions)
    end
end
function Core2.StartFunctions(arg182)
    local Shared = {}

    table.clear(rzFunctions)
    Shared.OptionIndex = {}

    local function NewOptionQueue(arg183, arg273, arg317)
        if arg317 ~= false then
            local tbl75 = {
				Name = arg183,
				Function = arg273
			}

            Shared.OptionIndex[arg183] = arg273
            table.insert(rzFunctions, tbl75)
        end
    end

    Shared.QuestManager = arg182.Managers.QuestManager

    local ItemsManager = arg182.Managers.ItemsManager

    Shared.FarmManager = arg182.Managers.FarmManager
    Shared.RaidManager = arg182.Managers.RaidManager
    Shared.SeaManager = arg182.Managers.SeaManager
    Shared.TweenManager = arg182.Managers.TweenManager
    Shared.MaxMastery = Module.GameData.MaxMastery
    Shared.MaxLevel = Module.GameData.MaxLevel
    Shared.Sea = Module.GameData.Sea
    Shared.IsAlive = Module.IsAlive

    local Inventory = Module.Inventory

    Shared.EquipTool = Module.EquipTool
    Shared.FireRemote = Module.FireRemote
    Shared.Unlocked = Inventory.Unlocked
    Shared.Count = Inventory.Count
    Shared.Mastery = Inventory.Mastery
    Shared.Items = Inventory.Items
    Shared.IsSpawned = Module.Enemies.IsSpawned
    Shared.EnemySpawned = Module.EnemySpawned
    Shared.EnemyLocations = Module.EnemyLocations
    Shared.Elites = Shared.FarmManager.Enemies.Elites
    Shared.Bones = Shared.FarmManager.Enemies.Bones
    Shared.Katakuri = Shared.FarmManager.Enemies.Katakuri
    Shared.Ectoplasm = Shared.FarmManager.Enemies.Ectoplasm
    Shared.Attack = Shared.FarmManager.attack
    Shared.CursedDualKatana = ItemsManager.CursedDualKatana
    Shared.DojoTrainer = ItemsManager.DojoTrainer
    Shared.OffsetUp3 = Vector3.yAxis * 3
    Shared.OffsetUp5 = Vector3.yAxis * 5
    Shared.OffsetUp50 = Vector3.yAxis * 50
    Shared.OffsetDown10 = Vector3.yAxis * -10
    Shared.Position = CFrame.new(-1926, 13, 1738)
    Shared.Position2 = CFrame.new(-5556, 300, -2988)
    Shared.Position3 = CFrame.new(914, 126, 33100)
    Shared.Position4 = CFrame.new(-5410, 314, -2628)
    Shared.Position5 = CFrame.new(-5561, 314, -2663)
    Shared.Position6 = CFrame.new(-8932.85, 142.87, 6063.31)
    Shared.Position7 = CFrame.new(1346, 37, -1329)
    Shared.Position8 = CFrame.new(-2103, 70, -12165)
    Shared.Position9 = CFrame.new(224, 25, -12771)
    Shared.Position10 = CFrame.new(3779, 16, -3500)
    Shared.Position11 = CFrame.new(912, 186, 33591)
    Shared.Position12 = CFrame.new(-9513, 164, 5786)
    Shared.Position13 = CFrame.new(-1461, 30, -51)
    Shared.Position14 = CFrame.new(5864, 1209, 810)
    Shared.Position15 = CFrame.new(5251, 20, 454)
    Shared.Position16 = CFrame.new(-7739, 5657, -2289)
    Shared.Position17 = CFrame.new(-690, 15, 1583)
    Shared.Position18 = CFrame.new(-26952, 21, 329)
    Shared.Position19 = CFrame.new(-462, 73, 300)
    Shared.Position20 = CFrame.new(2289, 15, 808)
    Shared.Position21 = CFrame.new(-2777, 73, -3570)
    Shared.Position22 = CFrame.new(-1988, 124, -70)
    Shared.Position23 = CFrame.new(-12512, 340, -9872)
    Shared.Position24 = CFrame.new(-12445, 332, -7676)
    Shared.Position25 = CFrame.new(-16252, 153, 1394)
    Shared.Position26 = CFrame.new(-16649, 107, 1293)
    Shared.InteractSubclassQuest = Net:WaitForChild("RF/InteractSubclassQuest")
    Net:WaitForChild("RF/InteractDragonQuest")
    Shared.StartSubclassQuest = Net:WaitForChild("RF/StartSubclassQuest")
--    Shared.FruitCustomizerRF = Net:WaitForChild("RF/FruitCustomizerRF")
    Net:WaitForChild("RF/JuiceNetworkRF")
    Shared.DragonHunter = Net:WaitForChild("RF/DragonHunter")
    Shared.ClaimBerry = Net:WaitForChild("RF/ClaimBerry")

    local tbl76 = {
		__index = function(arg184, arg274)
        rawset(arg184, arg274, NPCs:FindFirstChild(arg274) or ReplicatedStorage.NPCs:FindFirstChild(arg274))

        return (rawget(arg184, arg274))
    end
	}

    Shared.TouchKitsuneStatue = Net:WaitForChild("RE/TouchKitsuneStatue")
    Net:WaitForChild("RE/CollectBlueEmber")
    Net:WaitForChild("RE/DragonDojoEmber")
    Shared.SubclassNetwork = Remotes:WaitForChild("SubclassNetwork")
    Remotes:WaitForChild("QuestUpdate")
    Shared.Proxy = setmetatable({}, tbl76)
    Shared.State = nil
    Shared.State2 = nil
    Shared.State3 = nil
    Shared.State4 = nil
    Shared.State5 = nil
    Shared.State6 = nil
    Shared.State7 = nil
    Shared.State8 = nil
    Shared.State9 = nil
    Shared.State10 = nil
    Shared.State11 = nil
    Shared.State12 = nil
    Shared.State13 = nil
    Shared.State14 = nil
    Shared.State15 = nil
    Shared.State16 = nil
    Shared.State17 = nil
    Shared.Counter = 0
    Shared.Counter2 = 0
    Shared.Counter3 = 0
    Shared.Counter4 = 0
    Shared.Cache = {
		"Forest Pirate",
		"Mythological Pirate"
	}
    Shared.Cache2 = {
		"Stone",
		"Hydra Leader",
		"Kilo Admiral",
		"Captain Elephant",
		"Beautiful Pirate"
	}
    Shared.Cache3 = {
		"Yama",
		"Tushita"
	}
    Shared.Cache4 = {
		Tushita = "Good",
		Yama = "Evil"
	}
    Shared.Counter5 = -1
    Shared.Cache5 = nil
    Shared.Cache6 = {}
    Shared.Cache7 = {}
    Shared.Cache8 = {
		SecondSea = {
			"PirateBrigade",
			"Sea Beast"
		},
		ThirdSea = {
			"Shark",
			"Terrorshark",
			"Sea Beast",
			"Fish Crew Member",
			"Piranha",
			"PirateBrigade",
			"PirateGrandBrigade",
			"GhostShip",
			"FishBoat"
		}
	}
    Shared.Cache9 = {
		SegmentVector = Vector3.yAxis * 75,
		Segment = nil
	}

    local tbl77 = {
		CFrame.new(-13335, 380, -7660),
		CFrame.new(-13138, 380, -7713),
		CFrame.new(-13298, 380, -7876),
		CFrame.new(-13512, 380, -7983),
		CFrame.new(-13632, 380, -7815)
	}
    local tbl78 = {
		CFrame.new(778, 110, 1129),
		CFrame.new(1018, 110, 1128),
		CFrame.new(1020, 110, 1366),
		CFrame.new(1016, 110, 1115)
	}

    Shared.Cache10 = {
		["Forest Pirate"] = tbl77,
		["Swan Pirate"] = tbl78
	}

    local tbl79 = {
		Tushita = "Good",
		Yama = "Evil"
	}
    local _CFrame = CFrame
    local tbl80 = {
		Quest = {},
		Frags = -1
	}
    local result34 = _CFrame.new(-710, 382, -11150)
    local cFrame = CFrame.new(-12131, 578, -6707)
    local cFrame20 = CFrame.new(-13350, 332, -7645)
    local tbl81 = {
		CFrame.new(-12360, 603, -6551),
		CFrame.new(-12331, 603, -6551)
	}

    Shared.Cache11 = {
		Quests = {
			"Yama",
			"Tushita"
		},
		Modes = tbl79,
		CurrentQuest = tbl80,
		BoatsDealer = {},
		CakeQueen = result34,
		DoorNpc = cFrame,
		ForestPirate = cFrame20,
		Heaven = {
			"Heaven's Guardian",
			"Cursed Skeleton"
		},
		Hell = {
			"Hell's Messenger",
			"Cursed Skeleton"
		},
		CursedSkeleton = tbl81,
		OpenedDoor = false
	}

    local cFrame21 = CFrame.new(-8654, 141, 6169)
    local cFrame22 = CFrame.new(-8760, 142, 6018)
    local cFrame23 = CFrame.new(-9680, 6, 6346)
    local cFrame24 = CFrame.new(-10139, 154, 6001)
    local _ = {
		GravestoneEvent = cFrame21,
		Gravestones = cFrame22,
		BuySkullGuitar = cFrame23,
		Zombies = cFrame24,
		Trophies = CFrame.new(-9529, 6, 6039),
		Ghost = CFrame.new(-9758, 270, 6291),
		Pipes = CFrame.new(-9576, 6, 6230)
	}

    Shared.Cache12 = {
		RequestQuest = {
			Context = "RequestQuest"
		},
		Check = {
			Context = "Check"
		}
	}

    local result35 = CreateDictionary({ "Sea Beast" }, true)

    Shared.Cache13 = {
		Human = {
			"Orbitus",
			"Diamond",
			"Jeremy"
		},
		Shark = result35
	}
    CreateDictionary({
		"Human",
		"Skypiea",
		"Fishman",
		"Mink",
		"Cyborg",
		"Ghoul"
	}, true)

    local brickColor = BrickColor.new("Lime green")

    Shared.Cache14 = {
		["Really red"] = "Pure Red",
		Oyster = "Snow White",
		["Hot pink"] = "Winter Sky",
		_hotGreen = brickColor
	}

    local result36 = CreateDictionary({ "Shark" }, true)
    local result37 = CreateDictionary({ "Terrorshark" }, true)
    local self2 = setmetatable({}, {
		__index = function()
        return true
    end
	})
    local tbl82 = {
		["Fool's Gold"] = 20,
		["Terror Eyes"] = 2,
		["Electric Wings"] = 8,
		["Shark Teeth"] = 10
	}
    local tbl83 = {
		["Shark Teeth"] = "Shark",
		["Terror Eyes"] = "Terrorshark",
		["Fish Crew Member"] = "Electric Wings"
	}
    local tbl84 = {
		Terrorshark = result37,
		_Selected = self2,
		Materials = tbl82,
		Drops = tbl83
	}

    Shared.Cache15 = {
		Shipwright = result36,
		SharkAnchor = tbl84
	}

--[[    local function helper23()
        if tick() - Shared.Counter <= 30 then
            return Shared.State11
        end

        Shared.Counter = tick()

        local tbl85 = {
			Context = "GetSkinsInventory"
		}

        Shared.State11 = Shared.FruitCustomizerRF:InvokeServer(tbl85)

        return Shared.State11
    end]]
    local function helper24(arg185, arg275)
        if arg185 then
            for i = 1, #arg185 do
                arg185[i].Name = arg275
            end
        end
    end
    local function helper25(arg186, arg276, arg318)
        if arg276 > Level.Value then
            return
        end

        Shared.State12 = Shared.FarmManager:GetNpcVectorCFrame(arg186)

        if arg318 then
            local PrimaryPart = arg318.PrimaryPart

            return LocalPlayer:DistanceFromCharacter(PrimaryPart.Position) >= LocalPlayer:DistanceFromCharacter(Shared.State12.Position)
        end

        return true
    end
    local function helper26(arg187)
        if arg187 then
            arg187 = arg187.PrimaryPart and arg187.PrimaryPart.Anchored
        end

        return arg187
    end
    local function helper27()
        if Shared.State and helper26(Shared.State.Parent) then
            return Shared.State
        end
        local IslandModel = Map.Waterfall.IslandModel
        local meshesBambootree = IslandModel:FindFirstChild("Meshes/bambootree", true)
        local val137
        while meshesBambootree do
            if helper26(meshesBambootree.Parent) then
                helper24(val137, "Meshes/bambootree")
                Shared.State = meshesBambootree

                return meshesBambootree
            end

            val137 = val137 or {}
            meshesBambootree.Name = "Meshes/notbambootree"
            meshesBambootree = IslandModel:FindFirstChild("Meshes/bambootree", true)
            table.insert(val137, meshesBambootree)
        end
    end
    local function helper28()
        if Shared.State2 and Shared.IsSpawned(Shared.State2) then
            return Shared.State2
        end

        for k, _ in pairs(Module.Bosses) do
            local val138 = k

            if Shared.IsSpawned(val138) then
                Shared.State2 = val138

                return val138
            end
        end
    end
    local function TryBossQuest(arg188, arg277, arg319)
        local Quest = arg188.Quest
        local val139 = arg319 ~= true

        if val139 then
            val139 = not Shared.QuestManager:VerifyQuest(arg277) and settings.BossQuest
        end

        if val139 and (Quest and Level.Value >= arg188.Level) then
            Shared.QuestManager:StartQuest(Quest[1], Quest[3] or 3, Quest[2])

            return "Getting Boss Quest: " .. arg277
        end

        local result38 = Shared.EnemySpawned(arg277)

        if result38 and result38.PrimaryPart then
            return "Defeating Boss: " .. arg277, Shared.Attack(result38, true)
        end

        if arg188.Position then
            return "Waiting for: " .. arg277, MoveCharacter(arg188.Position)
        end

        return false
    end
    local function helper29()
        Shared.State3 = workspace:FindFirstChild("EmberTemplate")
        local val140
        while Shared.State3 do
            if Shared.State3.Part.Position.Y > 0 then
                helper24(val140, "EmberTemplate")

                return true
            end

            val140 = val140 or {}
            Shared.State3.Name = "notEmberTemplate"
            Shared.State3 = workspace:FindFirstChild("EmberTemplate")
            table.insert(val140, Shared.State3)
        end
    end

    function Shared.Value102()
        MoveCharacter(Shared.State3.Part.CFrame)

        return "Collecting Ember"
    end
    function Shared.Value103()
        local result39 = helper27()

        if result39 then
            if LocalPlayer:DistanceFromCharacter(result39.Position) >= 5 then
                return MoveCharacter(result39.CFrame)
            end

            if Shared.Unlocked["Skull Guitar"] then
                if VerifyTool("Skull Guitar") then
                    Module.Hooking:SetTarget(Tree)
                    Shared.EquipTool("Skull Guitar")
                    Module.FastAttack:ShootInTarget(result39.Position + Shared.OffsetDown10)

                    return
                end

                Shared.FireRemote("LoadItem", "Skull Guitar")

                return
            end

            Shared.EquipTool(Shared.SeaManager:GetRandomWeapon(), true)
            Module.UseSkills(result39, settings.SeaSkills)
        end
    end

    local function helper30(arg189)
        EnableBuso()
        Shared.SeaManager:StopMovingBoat()

        if arg189.Name == "Leviathan Segment" and arg189:FindFirstChild("Head") then
            Shared.EquipTool(Shared.SeaManager:GetRandomWeapon(), true)
            Module.UseSkills(arg189.Head.CFrame + Shared.Cache9.SegmentVector, settings.SeaSkills)

            return true, MoveCharacter(arg189.Head.CFrame + Shared.Cache9.SegmentVector)
        end

        if arg189:FindFirstChild("Head") then
            local cFrame25 = CFrame.new(arg189.Head.Position.X, 60, arg189.Head.Position.Z)

            EnableBuso()
            Shared.SeaManager:StopMovingBoat()
            Shared.EquipTool(Shared.SeaManager:GetRandomWeapon(), true)
            Module.UseSkills(cFrame25, settings.SeaSkills)

            return true, MoveCharacter(cFrame25)
        end
    end
    local function helper31()
        if LocalPlayer:FindFirstChild("QuestHaze") then
            return "Yama", 2
        end

        if LocalPlayer:FindFirstChild("BoatQuest") then
            return "Tushita", 1
        end

        if Map:FindFirstChild("HellDimension") then
            return "Yama", 3
        end

        if Map:FindFirstChild("HeavenlyDimension") then
            return "Tushita", 3
        end

        if Shared.Count["Alucard Fragment"] == 6 then
            return "FinalQuest"
        end

        if Shared.Counter5 == Shared.Count["Alucard Fragment"] then
            return unpack(Shared.Cache5)
        end

        local result40 = Shared.FireRemote("CDKQuest", "Progress")

        for _, v in ipairs(Shared.Cache3) do
            local val141
            local val142 = Shared.Cache4[v]
            local val143 = result40[val142]
            local val144
            if val143 < -2 then
                val144 = v
                val141 = (val143 + 2) * -1
            elseif val143 >= 0 and val143 < 3 then
                Shared.FireRemote("CDKQuest", "StartTrial", val142)
                val144 = v
                val141 = val143 + 1
            end
            if val144 then
                Shared.Counter5 = Shared.Count["Alucard Fragment"]
                Shared.Cache5 = {
					val144,
					val141
				}

                return val144, val141
            end
        end
    end
    local function helper32()
        local ClosestByTag = Module.Enemies:GetClosestByTag("CakePrince")

        if not Shared.QuestManager:VerifyQuest(Shared.Katakuri[1]) and helper25("Cake Quest Giver 2", 2275, ClosestByTag) then
            Shared.QuestManager:StartQuest("CakeQuest2", 2, Shared.State12)
        elseif ClosestByTag and ClosestByTag.PrimaryPart then
            Shared.Attack(ClosestByTag, true, true)
        else
            MoveCharacter(Shared.Position8)
        end

        return true
    end
    --[[local function helper33()
        local result41 = helper23()
        local _hotGreen = Shared.Cache14._hotGreen
        local value73 = Shared.State9

        if not value73 then
            value73 = Map["Boat Castle"].Summoner.Circle:GetChildren()
        end

        Shared.State9 = value73

        for i = 1, #Shared.State9 do
            local val145 = Shared.State9[i]

            if not val145:IsA("BasePart") then
                continue
            end

            local BrickColorName = val145.BrickColor.Name
            local val146 = Shared.Cache14[BrickColorName]

            if not result41[val146] then
                return false
            end

            if _hotGreen ~= val145.Part.BrickColor then
                if LocalPlayer:DistanceFromCharacter(val145.Position) <= 3 then
                    local CFrame2 = val145.CFrame

                    MoveCharacter(CFrame2 + Shared.OffsetUp5)
                    Shared.FruitCustomizerRF:InvokeServer({
						StorageName = val146,
						Type = "AuraSkin",
						Context = "Equip"
					})
                else
                    MoveCharacter(val145.CFrame)
                end

                return 1
            end
        end

        return 2
    end]]
    local function helper34()
        if helper26(Shared.State7) then
            return true
        end

        for _, child in ipairs(Map.TikiOutpost:FindFirstChild("EagleBossArena", true):GetChildren()) do
            if child.Name == "Tree" and helper26(child) then
                Shared.State7 = child

                return true
            end
        end
    end
    local function helper35(arg190)
        local value78 = Shared.State14

        if value78 then
            value78 = Shared.State14:IsDescendantOf(arg190) and Shared.State14.Enabled
        end

        if value78 then
            return Shared.State14.Parent
        end

        local GetChildren = arg190.GetChildren

        for _, v in ipairs(GetChildren(arg190)) do
            local Specs = v:FindFirstChild("Specs", true)

            if Specs and Specs.Enabled then
                Shared.State14 = Specs

                return Specs.Parent
            end
        end
    end
    local function helper36()
        local SpawnedDragonEggs = Map.PrehistoricIsland:FindFirstChild("SpawnedDragonEggs", true)
        local dragonEgg = SpawnedDragonEggs and SpawnedDragonEggs:FindFirstChild("DragonEgg")

        if dragonEgg then
            local ProximityPrompt = dragonEgg:FindFirstChild("ProximityPrompt", true)

            if ProximityPrompt and ProximityPrompt.Enabled then
                if LocalPlayer:DistanceFromCharacter(ProximityPrompt.Parent.Position) < 3 then
                    fireproximityprompt(ProximityPrompt)
                else
                    MoveCharacter(ProximityPrompt.Parent.CFrame)
                end

                return true
            end
        end
    end
    local function helper37()
        if Shared.Count["Dinosaur Bones"] >= 99 then
            return
        end

        local _ = Map.PrehistoricIsland
        local DinoBone = workspace:FindFirstChild("DinoBone")

        if DinoBone and LocalPlayer:DistanceFromCharacter(DinoBone.Position) <= 1500 then
            if LocalPlayer:DistanceFromCharacter(DinoBone.Position) <= 3 then
                MoveCharacter(DinoBone.CFrame + Shared.OffsetUp5)
            else
                MoveCharacter(DinoBone.CFrame)
            end

            return true
        end
    end
    local function helper38()
        local result42 = Shared.EnemySpawned("Lava Golem")

        if result42 and result42.PrimaryPart then
            return true, Shared.Attack(result42, true)
        end
    end
    local function helper39()
        if Fragments.Value >= 1000 then
            Shared.FireRemote("BlackbeardReward", "Microchip", "2")

            local timestamp = tick()

            while true do
                local flag9 = not VerifyTool("Microchip")

                if flag9 then
                    flag9 = tick() - timestamp <= 5
                end

                if not flag9 then
                    break
                end

                task.wait()
            end
        end
    end
    local function helper40()
        return fireclickdetector(Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    end
    local function helper41()
        return fireclickdetector(Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
    end
    local function helper42(arg191, arg278, arg320)
        if arg278:GetAttribute("IsMinigameActive") then
            if tick() - Shared.Counter2 >= 5 then
                Shared.Counter2 = tick()
                Module:RemoveVolcanoLava()
            end

            if helper38() then
                return true
            end

            local result43 = helper35(arg320)

            if result43 then
                if LocalPlayer:DistanceFromCharacter(result43.Position) < 5 then
                    Shared.EquipTool(Shared.SeaManager:GetRandomWeapon(), true)
                    Module.UseSkills(result43, settings.SeaSkills)
                else
                    MoveCharacter(result43.CFrame, false, false, true)
                end

                return true
            end

            if result43 then
                return true, MoveCharacter(result43.CFrame, false, false, true)
            end
        elseif LocalPlayer:GetAttribute("PrehistoricIslandParticipant") then
            local val147 = arg191 or not settings.IgnoreEggs and helper36()

            if not val147 then
                val147 = arg191 or not settings.IgnoreBones and helper37()
            end

            if val147 then
                return true
            end
        end
    end
    local function helper43(arg192, arg279)
        if arg279 then
            local ProximityPrompt = arg192:FindFirstChild("ProximityPrompt", true)

            if LocalPlayer:DistanceFromCharacter(arg279.Position) <= 5 and ProximityPrompt then
                fireproximityprompt(ProximityPrompt)

                return
            end

            MoveCharacter(arg279.CFrame)
        end
    end
    local function helper44(arg193)
        if arg193 then
            for _, child in ipairs(arg193:GetChildren()) do
                local val148 = helper43
                local isAResult3 = child:IsA("Model")

                if isAResult3 then
                    isAResult3 = child.PrimaryPart or child:FindFirstChildOfClass("MeshPart")
                end

                if val148(child, isAResult3) then
                    return "Collecting Fire Flower"
                end
            end
        end

        local result44 = Shared.EnemySpawned(Shared.Cache)

        if result44 and result44.PrimaryPart then
            Shared.Attack(result44, true)
        else
            Shared.TweenManager:TweenToCFrameQueue(Shared.Cache10["Forest Pirate"])
        end

        return true
    end
    local function helper45(arg194, _)
        local flag10 = not (arg194 < 350) and "Yama" or "Tushita"

        if VerifyTool(flag10) then
            Shared.EquipTool(flag10)
            Shared.FarmManager.ToolDebounce()

            local val149 = enabledOptions.PirateRaid and Shared.OptionIndex.PirateRaid()

            if not val149 then
                val149 = enabledOptions.Fruits and Shared.OptionIndex.Fruits()

                if not val149 then
                    val149 = enabledOptions.EliteHunter and Shared.OptionIndex.EliteHunter() or Shared.OptionIndex.Bones()
                end
            end

            return val149
        end

        Shared.FireRemote("LoadItem", flag10)

        return "Getting 350 in: " .. flag10
    end
    local function helper46(arg195)
        local result45 = Shared.FireRemote("CDKQuest", "OpenDoor")
        local val150 = result45 == "opened"

        if not val150 then
            val150 = result45 == "can" and Shared.FireRemote("CDKQuest", "OpenDoor", true)
        end

        if val150 then
            local FindFirstChild = arg195.FindFirstChild

            Shared.State16 = true

            if FindFirstChild(arg195, "Breakable") then
                arg195.Breakable:Destroy()
            end
        end
    end
    local function helper47()
        local value81 = Shared.State17

        if value81 then
            value81 = Shared.State17:IsDescendantOf(Map)
        end

        if value81 then
            return Shared.State17.Transparency ~= 1
        end

        for _, child in ipairs(Map.MysticIsland:GetChildren()) do
            if child:IsA("MeshPart") and child.MeshId == "rbxassetid://10153114969" then
                Shared.State17 = child

                return child.Transparency ~= 1
            end
        end
    end
    local function helper48()
        if HighestPoint and HighestPoint:IsDescendantOf(Map) then
            return HighestPoint
        end

        HighestPoint = Map.MysticIsland:FindFirstChild("dbz_map1_Cube.012", true)

        return HighestPoint
    end

    NewOptionQueue("Tushita", function()
        if Shared.Unlocked.Tushita then
            if Shared.IsSpawned("rip_indra True Form") then
                local result46 = Shared.EnemySpawned("rip_indra True Form")

                if result46 and result46.PrimaryPart then
                    Shared.Attack(result46)
                else
                    MoveCharacter(Shared.Position4)
                end

                return true
            end

            return nil
        end

        local Progress = Module:GetProgress("Tushita", "TushitaProgress")

        Shared.State4 = Shared.State4 or Progress.OpenedDoor

        if Shared.State4 then
            if Shared.IsSpawned("Longma") then
                return TryBossQuest(Module.Bosses.Longma, "Longma")
            end

            return nil
        end

        if VerifyTool("Holy Torch") then
            for i = 1, #Progress.Torches do
                local val151 = i

                if not Progress.Torches[val151] then
                    Shared.FireRemote("TushitaProgress", "Torch", val151)
                end
            end

            return true
        end

        if Shared.IsSpawned("rip_indra True Form") then
            local new = CFrame.new

            MoveCharacter(new(5713, 38, 255))

            return true
        end

        return not enabledOptions.EliteHunter and Shared.OptionIndex.EliteHunter()
    end, Shared.Sea == 3)
    NewOptionQueue("Darkbeard", function()
        if Shared.IsSpawned("Darkbeard") then
            local result47 = Shared.EnemySpawned("Darkbeard")

            if result47 and result47.PrimaryPart then
                Shared.Attack(result47)
            else
                MoveCharacter(Shared.Position10)
            end

            return true
        end

        if VerifyTool("Fist of Darkness") then
            Shared.EquipTool("Fist of Darkness")

            local value40 = Shared.Position10

            MoveCharacter(value40)

            return true
        end
    end, Shared.Sea == 2)
    NewOptionQueue("CursedCaptain", function()
        if Shared.IsSpawned("Cursed Captain") then
            local result48 = Shared.EnemySpawned("Cursed Captain")

            if result48 and result48.PrimaryPart then
                Shared.Attack(result48)
            else
                MoveCharacter(Shared.Position11)
            end

            return true
        end
    end, Shared.Sea == 2)
    NewOptionQueue("Factory", function()
        local core = Enemies:FindFirstChild("Core") or ReplicatedStorage:FindFirstChild("Core")

        if core and (Shared.IsAlive(core) and core.PrimaryPart) then
            return "Defeating Factory", Shared.FarmManager.GotoTargetCFrame(core.PrimaryPart.CFrame)
        end
    end, Shared.Sea == 2)
    NewOptionQueue("CursedDualKatana", function()
        if Shared.Unlocked["Cursed Dual Katana"] then
            return
        end

        if not Shared.Unlocked.Tushita then
            return Shared.OptionIndex.Tushita()
        end

        if not Shared.Unlocked.Yama then
            return Shared.OptionIndex.Yama() or Shared.OptionIndex.EliteHunter()
        end

        local Tushita = Shared.Mastery.Tushita
        local Yama = Shared.Mastery.Yama

        if Tushita >= 350 and Yama >= 350 then
            if not Shared.State16 then
                return helper46(Map.Turtle.Cursed)
            end

            local val152, val153 = helper31()

            if val152 then
                if val153 then
                    if Shared.CursedDualKatana[val152][val153](Shared.Cache11, Shared.OptionIndex) then
                        return val152 .. val153
                    end
                elseif Shared.CursedDualKatana[val152](Shared.Cache11, Shared.OptionIndex) then
                    return val152
                end
            end

            return
        end

        return helper45(Tushita, Yama)
    end, Shared.Sea == 3)

    local val154 = Shared.Sea == 2

    if not val154 then
        val154 = Shared.Sea == 3
    end

    NewOptionQueue("Raid", function()
        local lGliseDeProphTie = Locations:FindFirstChild("l'Église de Prophétie")

        if lGliseDeProphTie and LocalPlayer:DistanceFromCharacter(lGliseDeProphTie.Position) <= 150 then
            local result49 = Shared.FireRemote("Awakener", "Check")

            if type(result49) == "table" then
                if Fragments.Value < (result49.Cost or 0) then
                    return true, Shared.FireRemote("Awakener", "Teleport")
                end

                Shared.FireRemote("Awakener", "Awaken")
                Shared.FireRemote("Awakener", "Teleport")
            elseif result49 ~= 0 then
                return true, Shared.FireRemote("Awakener", "Teleport")
            end
        end

        if Shared.RaidManager:IsRaiding() then
            local RaidIsland = Module:GetRaidIsland()

            if RaidIsland then
                for _, child in ipairs(Enemies:GetChildren()) do
                    local PrimaryPart = child.PrimaryPart

                    if Shared.IsAlive(child) and PrimaryPart and ((RaidIsland.Position - PrimaryPart.Position).Magnitude <= 1000 and PrimaryPart.Position.Y > 0) then
                        return true, Shared.Attack(child, true, true, settings.FarmMode ~= "Up" and settings.FarmMode or "Star")
                    end
                end

                if LocalPlayer:DistanceFromCharacter(RaidIsland.Position) <= 3000 then
                    MoveCharacter(RaidIsland.CFrame + Shared.OffsetUp50)
                end

                return true
            end

            return true
        end

        if VerifyTool("Special Microchip") then
            return true, Shared.RaidManager:start()
        end
    end, val154)
    NewOptionQueue("Leviathan", function()
        if not Map:FindFirstChild("FrozenHeart") then
            local Segment = Shared.Cache9.Segment
            local val155 = Segment

            if Segment then
                val155 = Shared.IsAlive(Segment) and Segment:GetAttribute("HealthEnabled")
            end

            if val155 then
                return helper30(Segment)
            end

            local children = SeaBeasts:GetChildren()

            for i = 1, #children do
                local val156 = children[i]

                if val156.name:find("Leviathan") and (Shared.IsAlive(val156) and val156:GetAttribute("HealthEnabled")) then
                    Shared.Cache9.Segment = val156

                    return helper30(val156)
                end
            end
        end
    end, Shared.Sea == 3)
    NewOptionQueue("KitsuneIsland", function()
        if Lighting:GetAttribute("BlueMoonEnded") then
            return
        end

        local KitsuneIsland = Map:FindFirstChild("KitsuneIsland")

        if KitsuneIsland and Lighting:GetAttribute("MoonPhase") == 5 then
            if helper29() then
                return Shared.Value102()
            end

            local ShrineDialogPart = KitsuneIsland:FindFirstChild("ShrineDialogPart")

            if ShrineDialogPart then
                if LocalPlayer:DistanceFromCharacter(ShrineDialogPart.Position) <= 3 then
                    if Lighting:GetAttribute("MoonPhase") == 5 and not Lighting:GetAttribute("IsBlueMoon") then
                        Shared.TouchKitsuneStatue:FireServer()
                    end
                else
                    MoveCharacter(ShrineDialogPart.CFrame)
                end
            elseif KitsuneIsland.WorldPivot then
                MoveCharacter(KitsuneIsland.WorldPivot)
            end

            return true
        end
    end, Shared.Sea == 3)
    NewOptionQueue("CraftVolcanicMagnet", function()
        if Map:FindFirstChild("PrehistoricIsland") then
            if enabledOptions.FullyVolcano or enabledOptions.GotoVolcano then
                return false
            end

            if LocalPlayer:GetAttribute("CurrentLocation") == "Prehistoric Island" then
                return false
            end
        elseif tick() - Shared.Counter4 <= 30 then
            return false
        end

        if Shared.Unlocked["Volcanic Magnet"] then
            Shared.Counter4 = tick()

            return
        end

        if Shared.Count["Scrap Metal"] < 10 then
            return Shared.FarmManager:Material("Leather + Scrap Metal")
        end

        if Shared.Count["Blaze Ember"] < 15 then
            return Shared.OptionIndex.DragonHunter()
        end

        if LocalPlayer:DistanceFromCharacter(Shared.Position14.Position) < 3 then
            Shared.FireRemote("CraftItem", "Craft", "Volcanic Magnet")
        else
            MoveCharacter(Shared.Position14)
        end

        return true
    end, Shared.Sea == 3)
    NewOptionQueue("FullyVolcano", function(arg196, arg280)
        local PrehistoricIsland = Map:FindFirstChild("PrehistoricIsland")

        if PrehistoricIsland then
            local Core = PrehistoricIsland:FindFirstChild("Core")
            local activationPrompt = Core and Core:FindFirstChild("ActivationPrompt")
            local volcanoRocks = Core and Core:FindFirstChild("VolcanoRocks")

            if helper42(arg196, PrehistoricIsland, volcanoRocks) then
                Shared.Counter3 = tick()

                return true
            end

            if activationPrompt or PrehistoricIsland:GetAttribute("IsMinigameActive") then
                Shared.Counter3 = tick()
            end

            if activationPrompt then
                if not PrehistoricIsland:GetAttribute("IsMinigameActive") and LocalPlayer:DistanceFromCharacter(activationPrompt.Position) <= 3 then
                    local WaitForChild = activationPrompt.WaitForChild

                    fireproximityprompt(WaitForChild(activationPrompt, "ProximityPrompt", 9000000000))
                else
                    MoveCharacter(activationPrompt.CFrame)
                end
            else
                local val157 = Core

                if Core then
                    val157 = Core:FindFirstChild("PrehistoricRelic") and Core.PrehistoricRelic:FindFirstChild("Skull")
                end

                if val157 then
                    local val158 = Core.PrehistoricRelic.Skull.CFrame + Vector3.yAxis * 25

                    MoveCharacter(val158)

                    if not arg280 then
                        arg280 = settings.VolcanoReset
                    end

                    if arg280 and LocalPlayer:GetAttribute("PrehistoricIslandParticipant") and (tick() - Shared.Counter3 >= 15 and Shared.IsAlive(LocalPlayer.Character)) and LocalPlayer:DistanceFromCharacter(val158.Position) <= 10 then
                        LocalPlayer.Character.Humanoid.Health = 0
                    end
                end
            end

            return true
        end

        if not enabledOptions.Sea then
            return Shared.SeaManager:DriveBoat("inf")
        end
    end, Shared.Sea == 3)
    NewOptionQueue("PirateRaid", function()
        local PirateRaid = Module.Enemies:GetTagged("PirateRaid")

        if #PirateRaid > 0 or tick() - Module.PirateRaid <= 10 then
            for i = 1, #PirateRaid do
                local val159 = i

                if PirateRaid[val159].PrimaryPart then
                    return true, Shared.Attack(PirateRaid[val159], true, true)
                end
            end

            return true, MoveCharacter(Shared.Position2)
        end
    end, Shared.Sea == 3)
    NewOptionQueue("Fruits", function(arg197)
        if not arg197 then
            arg197 = workspace:FindFirstChild("Fruit ") or workspace:FindFirstChildOfClass("Tool")
        end

        local val160 = arg197

        if arg197 then
            val160 = arg197:IsA("Model") or arg197:IsA("Tool")
        end

        if val160 then
            local handle = arg197:FindFirstChild("Handle") and arg197.Handle.CFrame

            if not handle and arg197:IsA("Model") then
                local Pivot = arg197:GetPivot()

                if Pivot.Position ~= Vector3.zero then
                    handle = Pivot
                end
            end

            if handle then
                if LocalPlayer:DistanceFromCharacter(handle.Position) <= 2 then
                    MoveCharacter(handle + Shared.OffsetUp3)
                else
                    MoveCharacter(handle)
                end

                return true
            end
        end
    end)
    NewOptionQueue("DracoV2V3", function()
        local evoDracoRaceResult = Shared.DojoTrainer:EvoDracoRace(Shared.OptionIndex)

        if evoDracoRaceResult == "FireFlowers" then
            return helper44(workspace:FindFirstChild("FireFlowers"))
        end

        return evoDracoRaceResult
    end, Shared.Sea == 3)
    NewOptionQueue("DojoTrainer", function()
        local val161 = Shared.Cache6["Dragon Talon"]

        if not val161 or val161 < 500 then
            if not VerifyTool("Dragon Talon") then
                Shared.FireRemote("BuyDragonTalon")
            else
                if val161 then
                    Shared.Cache6["Dragon Talon"] = GetToolMastery("Dragon Talon")
                    Shared.EquipTool("Dragon Talon")
                    Shared.FarmManager.ToolDebounce()

                    return Shared.OptionIndex.Bones()
                end

                Shared.Cache6["Dragon Talon"] = GetToolMastery("Dragon Talon")
            end

            return true
        end

        return Shared.DojoTrainer:Train(Shared.OptionIndex)
    end, Shared.Sea == 3)
    NewOptionQueue("DragonHunter", function()
        if Shared.State13 == "Locked" then
            return
        end

        if helper29() then
            return Shared.Value102()
        end

        if not Shared.State13 or not Shared.State13.Text then
            if LocalPlayer:DistanceFromCharacter(Shared.Position14.Position) < 5 then
                Shared.State13 = Shared.DragonHunter:InvokeServer(Shared.Cache12.Check)

                if Shared.State13 and not Shared.State13.Text then
                    pcall(Shared.DragonHunter.InvokeServer, Shared.DragonHunter, Shared.Cache12.RequestQuest)
                end
            else
                MoveCharacter(Shared.Position14)
            end

            return "Getting Dragon Hunter Quest"
        end

        local value77Text = Shared.State13.Text

        if value77Text:find("Defeat") then
            local flag11 = not value77Text:find("Venomous") and "Hydra Enforcer" or "Venomous Assailant"
            local result50 = Shared.EnemySpawned(flag11)
            local val162 = Shared.EnemyLocations[flag11]

            if result50 and result50.PrimaryPart then
                Shared.Attack(result50, true)
            elseif val162 then
                Shared.TweenManager:TweenToCFrameQueue(val162)
            end

            return "Killing: " .. flag11
        end

        if value77Text:find("Destroy") then
            Shared.Value103()

            return "Breaking Hydra Island Tree's"
        end
    end, Shared.Sea == 3)
    NewOptionQueue("MirageFruitDealer", function()
        if Map:FindFirstChild("MysticIsland") then
            local val163 = Shared.Proxy["Advanced Fruit Dealer"]

            if val163 and val163.PrimaryPart then
                return true, MoveCharacter(val163.PrimaryPart.CFrame)
            end
        end
    end, Shared.Sea == 3)
    NewOptionQueue("MirageGear", function()
        if Map:FindFirstChild("MysticIsland") and helper47() then
            local value81CFrame = Shared.State17.CFrame

            MoveCharacter(value81CFrame)

            return true
        end
    end, Shared.Sea == 3)
    NewOptionQueue("MirageChests", function()
        if Map:FindFirstChild("MysticIsland") then
            return Shared.OptionIndex.ChestTween(" from Mirage Island", Map.MysticIsland)
        end
    end, Shared.Sea == 3)
    NewOptionQueue("TeleportMirage", function()
        if Map:FindFirstChild("MysticIsland") and helper48() then
            local val164 = HighestPoint.CFrame + Vector3.yAxis * 211.8

            MoveCharacter(val164)

            return true
        end
    end, Shared.Sea == 3)
    NewOptionQueue("GotoVolcano", function()
        if Map:FindFirstChild("PrehistoricIsland") then
            local Core = Map.PrehistoricIsland:FindFirstChild("Core")
            local activationPrompt2 = Core and Core:FindFirstChild("ActivationPrompt")

            if activationPrompt2 then
                return true, MoveCharacter(activationPrompt2.CFrame)
            end

            local val165 = Core

            if Core then
                val165 = Core:FindFirstChild("PrehistoricRelic") and Core.PrehistoricRelic:FindFirstChild("Skull")
            end

            if val165 then
                return true, MoveCharacter(Core.PrehistoricRelic.Skull.CFrame + Vector3.yAxis * 25)
            end
        end
    end, Shared.Sea == 3)
    NewOptionQueue("Shipwright", function()
        if Subclass.Value == "Shipwright" then
            return nil
        end

        local val166, val167 = Shared.InteractSubclassQuest:InvokeServer("Shipwright")

        if val166 == 1 then
            Shared.StartSubclassQuest:InvokeServer("Shipwright")

            return
        end

        if val166 == 3 then
            if (tonumber(val167) or 0) < 20 then
                return Shared.OptionIndex.Sea(Shared.Cache15.Shipwright)
            end
        elseif val166 == 4 or val166 == 2 then
            if Shared.SubclassNetwork.GetPlayerData:InvokeServer().Purchased.Shipwright ~= nil then
                Shared.SubclassNetwork.EquipSubclass:InvokeServer("Shipwright")

                return
            end

            if Fragments.Value >= 3000 then
                Shared.SubclassNetwork.PurchaseSubclass:InvokeServer("Shipwright")
            end
        end
    end, Shared.Sea == 3)
    NewOptionQueue("RaceV2", function()
        local val168 = Data.Race.Value == "Draco"

        if not val168 then
            val168 = not Shared.Unlocked["Warrior Helmet"] or Data.Race:FindFirstChild("Evolved")
        end

        if val168 then
            return nil
        end

        local Progress = Module:GetProgress("RaceV2", "Alchemist", "1")

        if Progress == 0 or Progress == 2 then
            if Progress ~= 2 or Beli.Value >= 500000 then
                if LocalPlayer:DistanceFromCharacter(Shared.Position21.Position) < 5 then
                    Shared.FireRemote("Alchemist", Progress ~= 0 and "3" or "2")
                else
                    MoveCharacter(Shared.Position21)
                end

                return true
            end
        elseif Progress == 1 then
            for i = 1, 2 do
                local val169 = i
                local flower = workspace:FindFirstChild("Flower" .. val169)
                local val170 = flower

                if flower then
                    val170 = flower.Transparency ~= 1 and not VerifyTool("Flower " .. val169)
                end

                if val170 then
                    return "Collecting Flower: " .. val169, MoveCharacter(flower.CFrame)
                end
            end

            if not VerifyTool("Flower 3") then
                local result51 = Shared.EnemySpawned("Swan Pirate")

                if result51 and result51.PrimaryPart then
                    Shared.Attack(result51)
                else
                    Shared.TweenManager:TweenToCFrameQueue(Shared.Cache10["Swan Pirate"])
                end

                return "Getting Flower: 3"
            end
        end
    end, Shared.Sea == 2)
    NewOptionQueue("RaceV3", function()
        local RaceValue = Data.Race.Value
        local val171 = RaceValue == "Draco"

        if not val171 then
            val171 = not Data.Race:FindFirstChild("Evolved")

            if not val171 then
                val171 = Shared.Cache7.RaceV3 and Shared.Cache7.RaceV3[RaceValue]
            end
        end

        if val171 then
            return nil
        end

        local Progress = Module:GetProgress("RaceV3", "Wenlocktoad", "1")

        if Progress == -2 then
            if not Shared.Cache7.RaceV3 then
                Shared.Cache7.RaceV3 = {
					[RaceValue] = true
				}
            else
                Shared.Cache7.RaceV3[RaceValue] = true
            end

            return nil
        end

        if Progress == 0 or Progress == 2 then
            if Progress ~= 2 or Beli.Value >= 2000000 then
                if LocalPlayer:DistanceFromCharacter(Shared.Position22.Position) < 5 then
                    Shared.FireRemote("Wenlocktoad", Progress ~= 0 and "3" or "2")
                else
                    MoveCharacter(Shared.Position22)
                end

                return true
            end
        elseif Progress == 1 then
            if RaceValue == "Fishman" then
                return Shared.OptionIndex.Sea(Shared.Cache13.Shark)
            end

            if RaceValue == "Human" then
                for _, v in ipairs(Shared.Cache13.Human) do
                    if Shared.IsSpawned(v) then
                        return TryBossQuest(Module.Bosses[v], v)
                    end
                end

                return
            end

            if RaceValue == "Mink" then
                return Shared.OptionIndex.ChestTween(" for Mink V3")
            end
        end
    end, Shared.Sea == 2)
    NewOptionQueue("SharkAnchor", function()
        if Shared.Unlocked["Shark Anchor"] then
            return
        end

        local SharkAnchor = Shared.Cache15.SharkAnchor

        if Shared.Unlocked["Monster Magnet"] then
            return Shared.OptionIndex.Sea(SharkAnchor.Terrorshark, false)
        end

        local tbl86 = {}
        local flag12 = false

        for k, v in pairs(SharkAnchor.Materials) do
            local val172 = k

            if v > Shared.Count[val172] then
                local val173 = SharkAnchor.Drops[val172]

                if val173 then
                    tbl86[val173] = true
                elseif val172 == "Fool's Gold" then
                    flag12 = SharkAnchor._Selected
                end
            end
        end

        if next(tbl86) then
            return Shared.OptionIndex.Sea(tbl86, flag12)
        end

        Shared.FireRemote("CraftItem", "Check", "SharkAnchor")
        Shared.FireRemote("CraftItem", "Craft", "SharkAnchor")
    end, Shared.Sea == 3)
    NewOptionQueue("Sea", function(arg198)
        if not arg198 then
            arg198 = settings.seaEnemy
        end

        local SeaEvents = Shared.SeaManager:GetSeaEvents(Shared.Cache8.SecondSea, arg198)

        if SeaEvents then
            return true, Shared.SeaManager:attackSeaEvent(SeaEvents)
        end

        if Shared.SeaManager:CanRepair() then
            return Shared.SeaManager:RepairBoat()
        end

        if settings.autoDriveBoat then
            return Shared.SeaManager:DriveBoat()
        end
    end, Shared.Sea == 2)
    NewOptionQueue("Sea", function(arg199, arg281)
        if not arg199 then
            arg199 = settings.fishSelected
        end

        local val174 = arg281 ~= false

        if val174 then
            val174 = arg281 or settings.boatSelected
        end

        local SeaEvents = Shared.SeaManager:GetSeaEvents(Shared.Cache8.ThirdSea, arg199, val174)

        if SeaEvents then
            return true, Shared.SeaManager:attackSeaEvent(SeaEvents)
        end

        if Shared.SeaManager:CanRepair() then
            return Shared.SeaManager:RepairBoat()
        end

        if settings.autoDriveBoat then
            return Shared.SeaManager:DriveBoat()
        end
    end, Shared.Sea == 3)
    NewOptionQueue("Rengoku", function()
        local Rengoku = Shared.Unlocked.Rengoku

        if not Rengoku then
            Rengoku = enabledOptions.Level and Level.Value < 1350
        end

        if Rengoku then
            return nil
        end

        if VerifyTool("Library Key") then
            return Shared.FireRemote("OpenLibrary")
        end

        if VerifyTool("Hidden Key") then
            return Shared.FireRemote("OpenRengoku")
        end

        if Shared.IsSpawned("Awakened Ice Admiral") then
            return TryBossQuest(Module.Bosses["Awakened Ice Admiral"], "Awakened Ice Admiral")
        end

        if Level.Value >= 1425 or not enabledOptions.Level then
            local result52 = Shared.EnemySpawned("Arctic Warrior", "Snow Lurker")

            if result52 and result52.PrimaryPart then
                Shared.Attack(result52)

                return true
            end
        end
    end, Shared.Sea == 2)
    NewOptionQueue("Bartilo", function()
        if Level.Value < 850 or Shared.Unlocked["Warrior Helmet"] then
            return nil
        end

        local Progress = Module:GetProgress("Bartilo", "BartiloQuestProgress")

        if Progress.KilledSpring then
            Shared.FireRemote("BartiloQuestProgress", "DidPlates")

            return
        end

        if Progress.KilledBandits then
            if Shared.IsSpawned("Jeremy") then
                local result53 = Shared.EnemySpawned("Jeremy")

                if result53 and result53.PrimaryPart then
                    Shared.Attack(result53)
                else
                    MoveCharacter(CFrame.new(2316, 449, 787))
                end

                return true
            end
        elseif not Progress.KilledBandits then
            if Shared.QuestManager:VerifyQuest("Swan Pirate") and Shared.QuestManager:VerifyQuest("50") then
                local result54 = Shared.EnemySpawned("Swan Pirate")

                if result54 and result54.PrimaryPart then
                    Shared.Attack(result54)
                else
                    Shared.TweenManager:TweenToCFrameQueue(Shared.Cache10["Swan Pirate"])
                end
            else
                Shared.QuestManager:StartQuest("BartiloQuest", 1, Shared.Position19)
            end

            return true
        end
    end, Shared.Sea == 2)
    NewOptionQueue("Yama", function()
        if Shared.Unlocked.Yama then
            return nil
        end

        if Module:GetProgress("EliteProgress", "EliteHunter", "Progress") >= 30 then
            if LocalPlayer:DistanceFromCharacter(Shared.Position15.Position) < 5 then
                pcall(helper41)
                task.wait(1)
            else
                MoveCharacter(Shared.Position15)
            end

            return true
        end
    end, Shared.Sea == 3)
    NewOptionQueue("Citizen", function()
        if Level.Value < 1800 or Shared.Unlocked["Musketeer Hat"] then
            return nil
        end

        local Progress = Module:GetProgress("Citizen", "CitizenQuestProgress")
        local NpcVectorCFrame = Shared.FarmManager:GetNpcVectorCFrame("Citizen")

        if Progress.KilledBoss then
            return true, MoveCharacter(Shared.Position23)
        end

        if Progress.KilledBandits then
            if Shared.IsSpawned("Captain Elephant") then
                if not Shared.QuestManager:VerifyQuest("Captain Elephant") then
                    if LocalPlayer:DistanceFromCharacter(NpcVectorCFrame.Position) >= 5 then
                        Shared.FireRemote("CitizenQuestProgress", "Citizen")
                    else
                        MoveCharacter(NpcVectorCFrame)
                    end

                    return true
                end

                local result55 = Shared.EnemySpawned("Captain Elephant")

                if result55 and result55.PrimaryPart then
                    Shared.Attack(result55)
                else
                    MoveCharacter(Shared.Position24)
                end

                return true
            end

            return
        end

        if Shared.QuestManager:VerifyQuest("Forest Pirate") and Shared.QuestManager:VerifyQuest("50") then
            local result56 = Shared.EnemySpawned("Forest Pirate")

            if result56 and result56.PrimaryPart then
                Shared.Attack(result56, true)
            else
                Shared.TweenManager:TweenToCFrameQueue(Shared.Cache10["Forest Pirate"])
            end

            return true
        end

        if LocalPlayer:DistanceFromCharacter(NpcVectorCFrame.Position) >= 5 then
            Shared.FireRemote("CitizenQuest", 1)
        else
            MoveCharacter(NpcVectorCFrame)
        end

        return true
    end, Shared.Sea == 3)
    NewOptionQueue("RainbowHaki", function()
        if Shared.State15 then
            return
        end

        local verifyQuestResult = Shared.QuestManager:VerifyQuest(Shared.Cache2)

        if verifyQuestResult then
            if Shared.IsSpawned(verifyQuestResult) then
                return TryBossQuest(Module.Bosses[verifyQuestResult], verifyQuestResult, true)
            end
        else
            if Shared.FireRemote("HornedMan") ~= 1 then
                Shared.FireRemote("HornedMan", "Bet")

                return
            end

            Shared.State15 = true
        end
    end, Shared.Sea == 3)
    NewOptionQueue("EliteHunter", function()
        local verifyQuestResult2 = Shared.QuestManager:VerifyQuest(Shared.Elites)
        local DoughKing = enabledOptions.DoughKing

        if not DoughKing then
            DoughKing = enabledOptions.CakePrince or enabledOptions.RipIndra
        end

        if DoughKing then
            DoughKing = Shared.IsSpawned("rip_indra True Form")

            if not DoughKing then
                DoughKing = Shared.IsSpawned("Dough King") or Shared.IsSpawned("Cake Prince")
            end

            if not DoughKing then
                DoughKing = VerifyTool("God's Chalice") or VerifyTool("Sweet Chalice")
            end
        end

        if DoughKing then
            return nil
        end

        if verifyQuestResult2 then
            local result57 = Shared.EnemySpawned(verifyQuestResult2)

            if result57 and result57.PrimaryPart then
                return "Killing Elite Hunter: " .. verifyQuestResult2, Shared.Attack(result57)
            end
        else
            local EnemyByTag = Module.Enemies:GetEnemyByTag("Elite")

            if EnemyByTag then
                local NpcVectorCFrame = Shared.FarmManager:GetNpcVectorCFrame("Elite Hunter")

                MoveCharacter(NpcVectorCFrame)
                Shared.TweenManager:InteractWithNpc(NpcVectorCFrame, "EliteHunter")

                return "Getting Elite Quest: " .. EnemyByTag.Name
            end
        end
    end, Shared.Sea == 3)
    NewOptionQueue("BerryBush", function(arg1100, arg282)
        local result58 = Module.Berry(arg1100)

        if result58 and result58.Parent then
            local val175, val176, val177 = pairs(result58:GetAttributes())
            local val178, val179 = val175(val176, val177)

            if val178 then
                local Parent = result58.Parent
                local GetAttribute = Parent.GetAttribute
                local pivot = Parent:GetPivot() * GetAttribute(Parent, val178)

                if LocalPlayer:DistanceFromCharacter(pivot.Position) < 3 then
                    Shared.ClaimBerry:InvokeServer(Parent.Name, val178)
                else
                    MoveCharacter(pivot)
                end

                return "Collecting Berry: " .. val179
            end
        else
            if not arg282 then
                arg282 = arg282 == nil and settings.BerryHop
            end

            if arg282 then
                Module:ServerHop()
            end
        end
    end)
    NewOptionQueue("ThirdSea", function()
        if Level.Value < 1500 or Level.Value >= 1850 then
            return nil
        end

        local Progress = Module:GetProgress("Zou1", "ZQuestProgress")

        if not Shared.Cache7.Zou2 and not Module:GetProgress("Zou2", "ZQuestProgress", "Check") then
            if Module:GetProgress("Unlockables", "GetUnlockables").FlamingoAccess then
                return Shared.OptionIndex.DonSwan()
            end

            return nil
        end

        if not Shared.Cache7.Zou2 then
            Shared.Cache7.Zou2 = true
        end

        if LocalPlayer:DistanceFromCharacter(Shared.Position18.Position) < 1200 then
            local rip_indra = Enemies:FindFirstChild("rip_indra")
            local val180 = rip_indra

            if rip_indra then
                val180 = rip_indra.PrimaryPart and rip_indra.PrimaryPart.Position.Y > 0
            end

            if val180 then
                Shared.Attack(rip_indra)
            end

            return true
        end

        if Progress.KilledIndraBoss then
            return Module:TravelTo(3)
        end

        if LocalPlayer:DistanceFromCharacter(Shared.Position.Position) < 5 then
            Shared.FireRemote("ZQuestProgress", "Begin")
            _ENV.OnFarm = false

            if not (LocalPlayer:DistanceFromCharacter(Shared.Position18.Position) < 1200) then
                local _ = enabledOptions[settings.RunningOption]
            end

            repeat
                task.wait()
            until LocalPlayer:DistanceFromCharacter(Shared.Position18.Position) < 1200 or not enabledOptions[settings.RunningOption]

            return true
        end

        MoveCharacter(Shared.Position)
    end, Shared.Sea == 2)
    NewOptionQueue("DonSwan", function()
        if not Shared.Unlocked["Warrior Helmet"] then
            return nil
        end

        if Shared.IsSpawned("Don Swan") then
            local result59 = Shared.EnemySpawned("Don Swan")

            if result59 and result59.PrimaryPart then
                Shared.Attack(result59)
            else
                MoveCharacter(Shared.Position20)
            end

            return true
        end
    end, Shared.Sea == 2)
    NewOptionQueue("SecondSea", function()
        if Level.Value < 700 then
            return
        end

        local Progress = Module:GetProgress("Dressrosa", "DressrosaQuestProgress")
        local KilledIceBoss = Progress.KilledIceBoss

        if KilledIceBoss then
            KilledIceBoss = not Shared.Unlocked["Warrior Helmet"] and Level.Value < 1250
        end

        if KilledIceBoss then
            return Module:TravelTo(2)
        end

        if not Progress.TalkedDetective then
            Shared.FireRemote("DressrosaQuestProgress", "Detective")
        elseif not Progress.UsedKey then
            if not VerifyTool("Key") then
                Shared.FireRemote("DressrosaQuestProgress", "Detective")
            end

            Shared.EquipTool("Key")
            Shared.FireRemote("DressrosaQuestProgress", "UseKey")
        elseif not Progress.KilledIceBoss then
            local result60 = Shared.EnemySpawned("Ice Admiral")

            if result60 and result60.PrimaryPart then
                Shared.Attack(result60)
            else
                MoveCharacter(Shared.Position7)
            end
        end

        return true
    end, Shared.Sea == 1)
    NewOptionQueue("Order", function(arg1101)
        local Order = Enemies:FindFirstChild("Order")

        if Shared.IsAlive(Order) and Order.PrimaryPart then
            return "Defeating Law", Shared.Attack(Order, true)
        end

        if not VerifyTool("Microchip") and not Order then
            return helper39()
        end

        if VerifyTool("Microchip") and arg1101 or settings.StartLaw then
            return pcall(helper40)
        end
    end, Shared.Sea == 2)
    NewOptionQueue("Saber", function()
        if Level.Value < 200 or Shared.Unlocked.Saber then
            return nil
        end

        local Progress = Module:GetProgress("Shanks", "ProQuestProgress")

        if Progress.UsedRelic then
            if Shared.IsSpawned("Saber Expert") then
                local result61 = Shared.EnemySpawned("Saber Expert")

                if result61 and result61.PrimaryPart then
                    Shared.Attack(result61)
                else
                    MoveCharacter(Shared.Position13)
                end

                return true
            end
        else
            if Progress.KilledMob then
                if VerifyTool("Relic") then
                    Shared.FireRemote("ProQuestProgress", "PlaceRelic")
                else
                    Shared.FireRemote("ProQuestProgress", "RichSon")
                end

                return true
            end

            if not Progress.UsedCup then
                if Progress.UsedTorch then
                    if VerifyTool("Cup") then
                        Shared.FireRemote("ProQuestProgress", "FillCup", LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Cup") or LocalPlayer.Backpack:FindFirstChild("Cup"))
                    else
                        Shared.FireRemote("ProQuestProgress", "GetCup")
                    end

                    Shared.FireRemote("ProQuestProgress", "SickMan")

                    return true
                end
                local _next = next
                local Plates = Progress.Plates
                local val181
                repeat
                    local val182

                    val181, val182 = _next(Plates, val181)

                    if not val181 then
                        if VerifyTool("Torch") then
                            Shared.FireRemote("ProQuestProgress", "DestroyTorch")
                        else
                            Shared.FireRemote("ProQuestProgress", "GetTorch")
                        end

                        return true
                    end
                until not val182
                Shared.FireRemote("ProQuestProgress", "Plate", val181)

                return true
            end

            if not Progress.TalkedSon then
                return Shared.FireRemote("ProQuestProgress", "RichSon")
            end

            if Shared.IsSpawned("Mob Leader") then
                local result62 = Shared.EnemySpawned("Mob Leader")

                if result62 and result62.PrimaryPart then
                    Shared.Attack(result62)
                else
                    MoveCharacter(CFrame.new(-2880, 9, 5430))
                end

                return true
            end
        end
    end, Shared.Sea == 1)
    NewOptionQueue("PoleV1", function()
        if Level.Value < 450 or Shared.Unlocked["Pole (1st Form)"] then
            return
        end

        if Shared.IsSpawned("Thunder God") then
            local result63 = Shared.EnemySpawned("Thunder God")

            if result63 and result63.PrimaryPart then
                Shared.Attack(result63)
            else
                MoveCharacter(Shared.Position16)
            end

            return true
        end
    end, Shared.Sea == 1)
    NewOptionQueue("TheSaw", function()
        if Level.Value < 100 or Shared.Unlocked["Shark Saw"] then
            return nil
        end

        if Shared.IsSpawned("The Saw") then
            local result64 = Shared.EnemySpawned("The Saw")

            if result64 and result64.PrimaryPart then
                Shared.Attack(result64)
            else
                MoveCharacter(Shared.Position17)
            end

            return true
        end
    end, Shared.Sea == 1)
    NewOptionQueue("SoulReaper", function()
        local result65 = Shared.EnemySpawned("Soul Reaper")

        if result65 and result65.PrimaryPart then
            Shared.Attack(result65)

            return true
        end

        if VerifyTool("Hallow Essence") then
            Shared.EquipTool("Hallow Essence")
            MoveCharacter(Shared.Position6)

            return true
        end
    end, Shared.Sea == 3)
--[[    NewOptionQueue("RipIndra", function()
        if Shared.IsSpawned("rip_indra True Form") then
            local result66 = Shared.EnemySpawned("rip_indra True Form")

            if result66 and result66.PrimaryPart then
                Shared.Attack(result66)
            else
                MoveCharacter(Shared.Position4)
            end

            return "Defeating: rip_indra True Form"
        end

        if VerifyTool("God's Chalice") then
            local result67 = helper33()

            if result67 == 1 then
                return "Activating Places"
            end

            if result67 == 2 then
                return "God's Chalice: rip_indra True Form", MoveCharacter(Shared.Position5)
            end
        end
    end, Shared.Sea == 3)]]
    NewOptionQueue("BossSelected", function()
        local BossSelected = settings.BossSelected

        if BossSelected and Shared.IsSpawned(BossSelected) then
            return TryBossQuest(Module.Bosses[BossSelected], BossSelected)
        end
    end)
    NewOptionQueue("AllBosses", function()
        local result68 = helper28()

        if result68 then
            return TryBossQuest(Module.Bosses[result68], result68)
        end
    end)
    NewOptionQueue("MasterySwords", function()
        local value69 = Shared.State5

        if value69 then
            value69 = Shared.State6

            if not value69 then
                local value69_2 = Shared.State5

                value69 = Shared.Mastery[value69_2] < Shared.MaxMastery
            end
        end

        if value69 then
            if not VerifyTool(Shared.State5) then
                return Shared.FireRemote("LoadItem", Shared.State5)
            end

            local value69_3 = Shared.State5

            Shared.EquipTool(value69_3)
            Shared.FarmManager.ToolDebounce()

            local TyrantSkies = enabledOptions.TyrantSkies

            if not TyrantSkies then
                TyrantSkies = enabledOptions.CakePrince

                if not TyrantSkies then
                    TyrantSkies = enabledOptions.DoughKing

                    if not TyrantSkies then
                        TyrantSkies = enabledOptions.Bones

                        if not TyrantSkies then
                            TyrantSkies = enabledOptions.Level or enabledOptions.Material
                        end
                    end
                end
            end

            if not TyrantSkies then
                return Shared.OptionIndex.Bones()
            end
        else
            local val183
            local num15 = -1
            for k, v in pairs(Shared.Items) do
                local val184 = k
                local val185 = v.Type == "Sword"

                if val185 then
                    val185 = Shared.Mastery[val184] < Shared.MaxMastery and num15 <= v.Rarity
                end

                if val185 then
                    val183 = val184
                    num15 = v.Rarity
                end
            end
            if val183 then
                Shared.State5 = val183

                return
            end
            Shared.State6 = true
        end
    end, Shared.Sea == 3)
    NewOptionQueue("TyrantSkies", function()
        local result69 = Shared.EnemySpawned("Tyrant of the Skies")

        if result69 then
            local tbl87 = { Shared.Attack(result69, true) }

            return "Defeating Tyrant of the Skies", unpackValues(tbl87)
        end

        if not Shared.State8 then
            Shared.State8 = Map.TikiOutpost:FindFirstChild("Eye4", true)

            return false
        end

        if Shared.State8.Transparency == 0 then
            if helper34() then
                local PrimaryPart = Shared.State7.PrimaryPart

                Shared.EquipTool(Shared.SeaManager:GetRandomWeapon(), true)
                Module.UseSkills(PrimaryPart.CFrame, settings.MasterySkills)

                return "Breaking Breakables", MoveCharacter(PrimaryPart.CFrame)
            end

            return "Waiting Breakables", MoveCharacter(Shared.Position25)
        end

        local ClosestByTag = Module.Enemies:GetClosestByTag("TyrantSkies")

        if not Shared.QuestManager:VerifyQuest("Skull Slayer") and helper25("Tiki Quest Giver 3", 2575, ClosestByTag) then
            Shared.QuestManager:StartQuest("TikiQuest3", 2, Shared.State12)
        elseif ClosestByTag and ClosestByTag.PrimaryPart then
            Shared.Attack(ClosestByTag, true, true)
        else
            MoveCharacter(Shared.Position26)
        end

        return "Making Red Eyes"
    end, Shared.Sea == 3)
    NewOptionQueue("DoughKing", function()
        local result70 = Shared.EnemySpawned("Dough King") or Shared.EnemySpawned("Cake Prince")

        if VerifyTool("Red Key") then
            Shared.FireRemote("CakeScientist", "Check")

            return true
        end

        if result70 and result70.PrimaryPart then
            Shared.Attack(result70)

            return true
        end

        if not VerifyTool("Sweet Chalice") and VerifyTool("God's Chalice") then
            if Shared.Count["Conjured Cocoa"] < 10 then
                return Shared.FarmManager:Material("Conjured Cocoa")
            end

            MoveCharacter(Shared.Position9)
            Shared.TweenManager:InteractWithNpc(Shared.Position9, "SweetChaliceNpc")

            return true
        end

        return helper32()
    end, Shared.Sea == 3)
    NewOptionQueue("CakePrince", function()
        if enabledOptions.DoughKing then
            return nil
        end

        local result71 = Shared.EnemySpawned("Dough King") or Shared.EnemySpawned("Cake Prince")

        if result71 and result71.PrimaryPart then
            Shared.Attack(result71)

            return true
        end

        return helper32()
    end, Shared.Sea == 3)
    NewOptionQueue("ChestTween", function(arg1102, arg283)
        local result72 = Module.Chests()

        if result72 then
            local Pivot = result72:GetPivot(arg283)

            if LocalPlayer:DistanceFromCharacter(Pivot.Position) < 3 then
                local val186 = Pivot + Shared.OffsetUp5

                MoveCharacter(val186)
                task.wait(0.15)
            else
                MoveCharacter(Pivot)
            end

            return "Collecting Chest" .. (arg1102 or "")
        end
    end)
    NewOptionQueue("Ectoplasm", function()
        local result73 = Shared.EnemySpawned(Shared.Ectoplasm)

        if result73 and result73.PrimaryPart then
            return "Killing: " .. result73.Name, Shared.Attack(result73, true, true)
        end

        return "Waiting for: Enemy Spawn", MoveCharacter(Shared.Position3)
    end, Shared.Sea == 2)
    NewOptionQueue("Bones", function()
        if enabledOptions.Level and Level.Value < Shared.MaxLevel then
            return
        end

        local ClosestByTag = Module.Enemies:GetClosestByTag("Bones")

        if not Shared.QuestManager:VerifyQuest(Shared.Bones[4]) and helper25("Haunted Castle Quest Giver 2", 2050, Target) then
            Shared.QuestManager:StartQuest("HauntedQuest2", 2, Shared.State12)

            return true
        end

        if ClosestByTag and ClosestByTag.PrimaryPart then
            return "Killing: " .. ClosestByTag.Name, Shared.Attack(ClosestByTag, true, true)
        end

        local tbl88 = { MoveCharacter(Shared.Position12) }

        return "Waiting for: Enemy Spawn", unpackValues(tbl88)
    end, Shared.Sea == 3)
    NewOptionQueue("Level", function()
        local Quest = Shared.QuestManager:GetQuest()

        if not Quest then
            return nil
        end

        local EnemyName = Quest.Enemy.Name
        local EnemyPosition = Quest.Enemy.Position
        local verifyQuestResult3 = Shared.QuestManager:VerifyQuest(EnemyName)

        if verifyQuestResult3 and Module.IsBoss(verifyQuestResult3) then
            return TryBossQuest(Module.Bosses[verifyQuestResult3], verifyQuestResult3, false)
        end

        if verifyQuestResult3 then
            local result74 = Shared.EnemySpawned(verifyQuestResult3)

            if result74 and result74.PrimaryPart then
                return "Killing: " .. result74.Name, Shared.Attack(result74, true)
            end

            local QuestPosition = Shared.QuestManager:GetQuestPosition(Quest.Name)

            if #EnemyPosition > 0 then
                Shared.TweenManager:TweenToCFrameQueue(EnemyPosition)
            elseif QuestPosition then
                MoveCharacter(QuestPosition * Shared.QuestManager._Position)
            end

            return "Waiting for: " .. verifyQuestResult3
        end

        local value2 = Shared.QuestManager
        local QuestName = Quest.Name
        local Count = Quest.Count
        local QuestName2 = Quest.Name
        local tbl89 = { Shared.QuestManager:GetQuestPosition(QuestName2) }

        return value2:StartQuest(QuestName, Count, unpackValues(tbl89))
    end)
    NewOptionQueue("Mastery", function()
        if Shared.Sea == 3 and Level.Value >= Shared.MaxLevel then
            return Shared.OptionIndex.Bones()
        end

        return Shared.OptionIndex.Level()
    end)
    NewOptionQueue("Material", function()
        if settings.fMaterial then
            return Shared.FarmManager:Material(settings.fMaterial)
        end
    end)
    NewOptionQueue("Nearest", function()
        local val187 = Shared.State10 and Shared.State10.PrimaryPart
        if val187 then
            local result75 = Shared.IsAlive(Shared.State10)

            if result75 then
                result75 = LocalPlayer:DistanceFromCharacter(val187.Position) < 1500
            end

            val187 = result75
        end
        if val187 then
            return "Killing: " .. Shared.State10.Name, Shared.Attack(Shared.State10, true, true)
        end
        local num16 = 1500
        local val188
        for _, child in ipairs(Enemies:GetChildren()) do
            local PrimaryPart = child.PrimaryPart

            if Shared.IsAlive(child) and PrimaryPart then
                local distanceFromCharacterResult4 = LocalPlayer:DistanceFromCharacter(PrimaryPart.Position)

                if distanceFromCharacterResult4 < num16 then
                    num16 = distanceFromCharacterResult4
                    val188 = child
                end
            end
        end
        if val188 then
            Shared.State10 = val188
            Shared.Attack(val188, true, true)

            return true
        end
        task.wait(0.4)
    end)

    if Shared.Sea == 3 then
        local flag13 = false

        local function helper49()
            Shared.State13 = nil
        end

        local tbl90 = {
			["Obtained <Color=Purple><Mutant Tooth><Color=/> (1x)"] = function()
            Shared.DojoTrainer:UpdateBeltProgress("Red", 1)
        end,
			["<Color=Yellow><QUEST COMPLETED!><Color=/>"] = function()
            Shared.DojoTrainer:UpdateBeltProgress("White", 8)
        end,
			["Head back to the Dojo to complete more tasks."] = helper49,
			["Dojo quest abandoned!"] = helper49
		}
        local insert = table.insert
        local val189 = connections
        local tbl91 = { Module.Signals.Notify:Connect(function(arg1103)
            local val190 = tbl90[arg1103]

            if val190 then
                return val190()
            end

            if arg1103:find("Earned <Color=Green>%$%d+<Color=/>") then
                if LocalPlayer:GetAttribute("DangerLevel") >= 100 then
                    Shared.DojoTrainer:UpdateBeltProgress("Yellow", 1)

                    return
                end

                local val191 = enabledOptions.DoughKing and VerifyTool("Sweet Chalice")

                if not val191 then
                    val191 = not VerifyTool("God's Chalice") and enabledOptions.CakePrince
                end

                if val191 and not flag13 then
                    flag13 = true

                    if string.find(Shared.FireRemote("CakePrinceSpawner", true) or "Error", "Do you want to open the portal now?") then
                        Shared.FireRemote("CakePrinceSpawner")
                    end

                    CheckingDebounce = false
                end
            end
        end) }

        insert(val189, unpackValues(tbl91))
    end
end
function Core2.Webhooks(_)
    if Module.Webhooks then
        fetcher.load("{Utils}/BloxFruits/Webhooks.lua")(Module)
    end
end
local function runStep(arg1104, ...)
    local timestamp = tick()

    Core2[arg1104](Core2, ...)
    print(arg1104, tick() - timestamp)
end
runStep("Initialize")
runStep("StartFarm")
runStep("StartFunctions")
task.spawn(runStep, "LoadLibrary")
task.spawn(runStep, "Webhooks")
