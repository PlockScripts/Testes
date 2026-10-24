-- This file was generated at discord.gg/syncrypt

local v1 = unpack or table.unpack
local t1 = { ... }
local v3 = t1[2]
local v4 = t1[1]
local v5 = v3 or {
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
local _getgenv = getgenv
if not _getgenv then
    _getgenv = getrenv or getfenv
end
local v38 = _getgenv()
local _ = game.HttpGet
local t2 = {}
local t3 = {}
local v42 = v38.rz_Functions or {}
local v43 = v38.rz_FarmFunctions or {}
local rz_Settings = v38.rz_Settings
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
local v46 = rz_Settings
local rz_EnabledOptions = v38.rz_EnabledOptions
if not rz_EnabledOptions then
    rz_EnabledOptions = setmetatable({}, {
		__newindex = function(_, p2, p3)
        rawset(t3, p2, p3 or nil)
        table.clear(v43)

        for _, v in ipairs(v42) do
            if rawget(t3, v.Name) then
                table.insert(v43, v)
            end
        end
    end,
		__index = t3
	})
end
local v48 = rz_EnabledOptions
local PlayerGui = LocalPlayer.PlayerGui
if not LocalPlayer.Team and not LocalPlayer:FindFirstChild("Main") then
    local n1 = 0

    while not LocalPlayer.Team and not LocalPlayer:FindFirstChild("Main") do
        if tick() - n1 >= 0.5 then
            pcall(function(p4)
                local ChooseTeam = PlayerGui["Main (minimal)"]:WaitForChild("ChooseTeam")
                local v71 = p4:find("pirate")
                local v72 = getconnections(ChooseTeam.Container[not v71 and "Marines" or "Pirates"].Frame.TextButton.Activated)

                for i = 1, #v72 do
                    v72[i].Function()
                end
            end, string.lower(v5.JoinTeam or "Pirates"))
            n1 = tick()
        end

        task.wait()
    end
end
v38.rz_Functions = v42
v38.rz_Settings = v46
v38.rz_EnabledOptions = v48
v38.rz_FarmFunctions = v43
local v51 = rz_connections or {}
v38.rz_connections = v51
for _, v in ipairs(v51) do
    v:Disconnect()
end
table.clear(v51)
local u54
local u55
local MoveCharacter
local t4 = {
	Marines = function()
    u55.FireRemote("SetTeam", "Marines")
end,
	Pirates = function()
    u55.FireRemote("SetTeam", "Pirates")
end
}
local t5 = {}
local function v59(p5)
    local p5_2 = CollectionService:GetTagged(p5)

    table.insert(v51, CollectionService:GetInstanceAddedSignal(p5):Connect(function(p6)
        table.insert(p5_2, p6)
    end))

    return p5_2
end
t5.Chests = v59("_ChestTagged")
t5.Berries = v59("BerryBush")
local t6 = {
	AllCodes = function()
    local v108 = v4.get("{Utils}BloxFruits/Codes.txt")
    local parts = string.split(string.gsub(v108, "\n", ""), "~")

    for i = 1, #parts do
        Remotes.Redeem:InvokeServer(parts[i])
    end
end,
	GetTimer = function(p7)
    local v103 = math.floor(p7)
    local v104 = math.floor(p7 / 60)
    local v105 = math.floor(p7 / 60 / 60) * 60
    local v106 = v103 - v104 * 60
    local v107 = v104 - v105

    return (v107 < 10 and "0" .. tostring(v107) or v107) .. ":" .. (v106 < 10 and "0" .. tostring(v106) or v106)
end
}
local t7 = {
	Managers = {}
}
local Managers = t7.Managers
function Managers.TweenManager()
    local t8 = {
		QueueNumber = 1,
		InDebounce = false
	}
    local v75 = u55.RunFunctions.TweenModule()
    local t9 = {
		["Sky Island 1"] = Vector3.new(-4652, 873, -1754),
		["Sky Island 2"] = Vector3.new(-7895, 5547, -380),
		["Under Water Island"] = Vector3.new(61164, 15, 1820),
		["Under Water Island Entrace"] = Vector3.new(3865, 20, -1926)
	}
    local t10 = {
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
    local v83 = ({
		t9,
		t10,
		{
			Mansion = vector3,
			["Hydra Island"] = vector3_2,
			["Temple of Time"] = vector3_3,
			["Sea Castle"] = vector3_4,
			["Great Tree"] = vector3_5
		}
	})[u55.GameData.Sea]
    local Unlocked = u55.Inventory.Unlocked
    local Sea = u55.GameData.Sea
    local IsAlive = u55.IsAlive
    local FireRemote = u55.FireRemote
    local Tween = u55.Tween
    local n2 = 0
    local n3 = 0
    local u91
    local p16Position
    local u93
    local cFrame = CFrame.new(28610, 14897, 105)
    local v95 = Vector3.yAxis * -25.2
    local function v96(p8)
        if Entarce == "Spawn Point" then
            return not LocalPlayer.Character:GetAttribute("InCombat")
        end

        local v439 = Sea == 3

        if v439 then
            v439 = p8 == "Hydra Island"

            if not v439 then
                v439 = p8 == "Sea Castle" or p8 == "Mansion"
            end
        end

        if v439 then
            return Unlocked["Valkyrie Helm"]
        end

        if Sea == 2 then
            if p8 == "Flamingo Mansion" or p8 == "Flamingo Room" then
                return Unlocked["Swan Glasses"] or Level.Value >= 1750
            end

            if p8 == "Zombie Island" or p8 == "Cursed Ship" then
                return Level.Value >= 1000
            end
        end

        return true
    end
    local function v97(p9)
        local v443
        local huge = math.huge
        local v445
        for k, v in pairs(v83) do
            local v448 = k

            if v96(v448) then
                local Magnitude = (p9 - v).Magnitude

                if Magnitude < huge then
                    huge = Magnitude
                    v445 = v
                    v443 = v448
                end
            end
        end

        return v445, v443
    end
    local function v98()
        t8.MoveCharacter(cFrame, nil, true)
        t8:InteractWithNpc(cFrame, "RaceV4Progress", "TeleportBack")
    end
    local function v99()
        local v450 = t8

        t8.QueueNumber = t8.QueueNumber + 1
        v450.InDebounce = false
    end
    function t8.GetLastPosition(_)
        return p16Position
    end
    function t8.TweenToCFrameQueue(p11, p12, p13)
        if not IsAlive(LocalPlayer.Character) then
            return false
        end

        if p11.InDebounce and p12[p11.QueueNumber] then
            return MoveCharacter(p12[p11.QueueNumber] + v95)
        end

        if #p12 == 1 then
            p11.MoveCharacter(p12[1], p13)

            return
        end

        if #p12 > 1 then
            if p11.QueueNumber > #p12 then
                p11.QueueNumber = 1
            end

            local PrimaryPart = LocalPlayer.Character.PrimaryPart
            local v456 = p12[p11.QueueNumber]

            if PrimaryPart and (PrimaryPart.Position - v456.Position).Magnitude < 5 then
                p11.InDebounce = true
                task.delay(0.8, v99)

                return
            end

            p11.MoveCharacter(v456, p13)
        end
    end
    function t8.InteractWithNpc(_, p15, ...)
        if LocalPlayer:DistanceFromCharacter(p15.Position) < 5 then
            return FireRemote(...)
        end
    end
    function t8.MoveCharacter(p16, p17, p18, p19)
        if not IsAlive(LocalPlayer.Character) or not LocalPlayer.Character.PrimaryPart then
            return false
        end

        if tick() - n3 <= 1 and p16 == u91 then
            return false
        end

        if not p18 then
            p16Position = p16.Position
        end

        local Character = LocalPlayer.Character
        local Humanoid = Character.Humanoid
        local PrimaryPart = Character.PrimaryPart

        if Humanoid.Sit then
            Humanoid.Sit = false

            return
        end

        if PrimaryPart.Anchored then
            v75:stopTween(PrimaryPart)

            return
        end

        n3 = tick()
        u91 = p16
        v38.OnFarm = true

        local v466 = v46.TweenSpeed or 220
        local p16Position2 = p16.Position
        local Magnitude = (PrimaryPart.Position - p16Position2).Magnitude

        if Magnitude < (not p17 and 120 or 10) then
            PrimaryPart.CFrame = p16

            return v75:stopTween(PrimaryPart)
        end

        if Character:FindFirstChild("TempSafeZone") then
            return v75:stopTween(PrimaryPart)
        end

        local v469, v470 = v97(p16Position2)

        if v469 and (v469 < Magnitude and (p16Position2 - v469).Magnitude + 300) then
            if v470 == "Great Tree" then
                return v98()
            end

            if tick() - n2 >= 6 or v470 ~= u93 then
                v75:stopTween(PrimaryPart)
                task.wait(0.2)

                local v471 = if not ((p16Position2 - v469).Magnitude < 50) then v469 + (p16Position2 - PrimaryPart.Position).Unit * 40 else p16Position2

                u93 = v470
                n2 = tick()

                return FireRemote("requestEntrance", v471)
            end
        end

        if p17 then
            return v75.new(PrimaryPart, Magnitude / p17, "CFrame", p16)
        end

        if not p19 then
            local PrimaryPartPosition = PrimaryPart.Position
            local cFrame2 = CFrame.new(PrimaryPartPosition.X, p16Position2.Y, PrimaryPartPosition.Z)

            if (PrimaryPartPosition - cFrame2.Position).Magnitude > 75 then
                v75:stopTween(PrimaryPart)
                task.wait(0.1)
                PrimaryPart.CFrame = cFrame2
                task.wait(0.5)
            end
        end

        if Magnitude < 380 then
            v75.new(PrimaryPart, Magnitude / (v466 * 2), "CFrame", p16)

            return
        end

        v75.new(PrimaryPart, Magnitude / v466, "CFrame", p16)
    end
    table.insert(v51, Tween:GetPropertyChangedSignal("Parent"):Connect(function()
        if not Tween.Parent and IsAlive(LocalPlayer.Character) then
            local Character = LocalPlayer.Character
            local FindFirstChild = Character.FindFirstChild

            v75:stopTween(FindFirstChild(Character, "HumanoidRootPart"))
        end
    end))
    MoveCharacter = t8.MoveCharacter

    return t8
end
function Managers.QuestManager()
    local Sea = u55.GameData.Sea
    local cFrame = CFrame.new(0, 0, 2.5)
    local t11 = {
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
    local t12 = {
		GuideModule = GuideModule,
		Quests = Quests
	}

    local function v119(p20)
        local ok, result = pcall(function()
            return require(t12[p20])
        end)

        if not ok then
            warn(("falha a o carregar Module [ %s ] [ %s ]").format("falha a o carregar Module [ %s ] [ %s ]", p20, result))
        end

        return ok and result or v4.load("{Utils}BloxFruits/GameModules/" .. p20 .. ".lua")()
    end

    local v120 = v119("GuideModule")
    local v121 = v119("Quests")
    local EnemyLocations = u55.EnemyLocations
    local _ = u55.EnemySpawned
    local IsBoss = u55.IsBoss

    task.spawn(function()
        if v120.Data.IsFakeData then
            return nil
        end

        for _, v in pairs(v120.Data.NPCList) do
            t11.QuestPos[v.NPCName] = CFrame.new(v.Position)
        end

        setmetatable(v120.Data.NPCList, {
			__newindex = function(p21, p22, p23)
            t11.QuestPos[p23.NPCName] = CFrame.new(p23.Position)

            return (rawset(p21, p22, p23))
        end
		})
    end)
    task.spawn(u55.RunFunctions.Quests, t11, v121, function(p24)
        local t13 = {}
        local t14 = {}
        local _next = next
        local Task = p24.Task
        local v483
        while true do
            local v484

            v483, v484 = _next(Task, v483)

            if not v483 then
                break
            end

            t14 = EnemyLocations[v483] or {}
            EnemyLocations[v483] = t14
            table.insert(t13, v483)
        end

        return t13, t14
    end)

    function t11.GetQuest(p25)
        if p25.oldLevel == Level.Value and p25.CurrentQuest then
            if p25.oldBoss and u55.Enemies.IsSpawned(p25.oldBoss) then
                return p25.oldBossQuest
            end

            return p25.CurrentQuest
        end
        local v488
        local v489
        local v490
        p25.oldLevel = Level.Value
        local Sea2 = p25.Sea
        local clamp = math.clamp
        local LevelValue = Level.Value
        local v494 = Sea2 == 1 and 700
        if not v494 then
            v494 = if Sea2 ~= 2 then Level.Value else 1500
        end
        local v495 = clamp(LevelValue, 0, v494)
        for _, v in ipairs(p25.QuestList) do
            local Level2 = v.Enemy.Level
            local v499 = v.Enemy.Name[1]

            if not IsBoss(v499) then
                if v495 < Level2 then
                    p25.oldBoss = v488
                    p25.oldBossQuest = v490
                    p25.CurrentQuest = v489

                    return v489
                end

                v489 = v

                continue
            end

            v488 = Level2 <= v495 and (Level2 >= v495 - 50 and v499)
            v490 = v
        end
        p25.oldBoss = v488
        p25.oldBossQuest = v490
        p25.CurrentQuest = v489

        return v489
    end
    function t11.GetQuestPosition(p26, p27)
        if v120.Data.IsFakeData then
            local v502 = v120.Data.NPCs[p27]

            if v502 then
                v502 = NPCs:FindFirstChild(v502) or ReplicatedStorage.NPCs:FindFirstChild(v502)
            end

            return v502 and v502:GetPivot()
        end

        return p26.QuestPos[v120.Data.LastClosestNPC]
    end
    function t11.VerifyQuest(_, p29)
        if not Quest.Visible then
            return false
        end

        local v505 = string.gsub(QuestTitleTitle.Text, "-", ""):lower()

        if type(p29) == "string" then
            return string.find(v505, string.gsub(p29, "-", ""):lower())
        end

        for _, v in ipairs(p29) do
            if string.find(v505, string.gsub(v, "-", ""):lower()) then
                return v
            end
        end
    end
    function t11.StartQuest(p30, p31, p32, p33)
        local v512 = p33

        if p33 then
            v512 = LocalPlayer:DistanceFromCharacter(p33.Position) >= 5
        end

        if v512 then
            local v513 = p33 * p30._Position

            MoveCharacter(v513)

            return "Teleporting to NPC: " .. p31
        end

        if p30.takeQuestDebounce then
            local v514 = not p30.Debounce

            if not v514 then
                v514 = tick() - p30.Debounce >= 75 or p30.InDebounceQuest ~= p32 .. p31
            end

            if v514 then
                v46.RunningMethod = "Getting Quest: " .. p31
                task.wait(0.5)
                u55.FireRemote("StartQuest", p31, p32)

                local v515 = p32 .. p31
                local timestamp = tick()

                p30.InDebounceQuest = v515
                p30.Debounce = timestamp

                return v46.RunningMethod, task.wait(0.5)
            end

            return "Quest Debounce: " .. t6.GetTimer(75 - (tick() - p30.Debounce))
        end

        task.wait(0.5)
        u55.FireRemote("StartQuest", p31, p32)

        return "Getting Quest: " .. p31, task.wait(0.5)
    end

    return t11
end
function Managers.FarmManager()
    local vector2 = Vector2.new()
    local t15 = {
		CanFarm = {},
		EnemyLocation = {},
		ClickPosition = vector2,
		axisDebounce = 0
	}
    local IsAlive = u55.IsAlive
    local EnemySpawned = u55.EnemySpawned
    local EnemyLocations = u55.EnemyLocations
    local EquipTool = u55.EquipTool
    local n4 = 0

    t15.Materials = ({
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
	})[u55.GameData.Sea]
    t15.Enemies = {
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
    t15.FarmModes = {
		Star = function(p34, p35)
        local v522 = p35.CFrame + p34:GetNextAxis()

        if LocalPlayer:DistanceFromCharacter(v522.Position) >= 5 then
            MoveCharacter(v522)
        end
    end,
		Orbit = function(_, p37, p38)
        local p37Parent = p37.Parent
        local n5 = 0
        local elapsed = task.wait()
        local RunningOption = v46.RunningOption

        while true do
            local v530 = p38 or v46.FarmMode == "Orbit"

            if v530 then
                v530 = v48[RunningOption]

                if v530 then
                    v530 = p37 and IsAlive(p37Parent)
                end
            end

            if not v530 then
                break
            end

            if tick() - n4 >= 1 then
                EquipTool()
            end

            EnableBuso()

            local FarmDistance = v46.FarmDistance

            n5 += 3.5 * elapsed
            MoveCharacter(CFrame.new(math.cos(n5) * FarmDistance, 8, math.sin(n5) * FarmDistance) + p37.Position)
            elapsed = task.wait(not v46.SmoothMode and 0 or 0.1)
        end
    end,
		Up = function(_, p40)
        local v519 = p40.CFrame + v46.FarmPos

        if LocalPlayer:DistanceFromCharacter(v519.Position) >= 5 then
            MoveCharacter(v519)
        end
    end
	}

    local t16 = {}
    local t17 = { CFrame.new(-7742, 5634, -1564) }
    local t18 = {
		CFrame.new(-1257, 54, 4091),
		CFrame.new(-1100, 77, 1152),
		CFrame.new(-364, 116, 5692)
	}
    local cFrame = CFrame.new(-5408, 11, 8456)
    local t19 = { CFrame.new(-5241, 50, -4713) }
    local _CFrame = CFrame
    local t20 = {
		cFrame,
		v1(t19)
	}
    local t21 = {
		_CFrame.new(60931, 19, 1574),
		false,
		CFrame.new(-10679, 398, -8975)
	}
    local t22 = {
		false,
		CFrame.new(-3350, 282, -10527)
	}
    local t23 = {
		false,
		CFrame.new(-73, 149, -112)
	}
    local t24 = { CFrame.new(-6030, 6, -1281) }
    local _CFrame2 = CFrame
    local t25 = {
		false,
		v1(t24)
	}
    local t26 = {
		false,
		false,
		_CFrame2.new(-394, 135, 5981)
	}
    local t27 = {
		false,
		false,
		CFrame.new(-13510, 584, -6986)
	}
    local t28 = {
		false,
		false,
		CFrame.new(400, 81, -12257)
	}
    local t29 = {
		false,
		false,
		CFrame.new(6689, 378, 331)
	}
    local t30 = {
		["Angel Wings"] = t17,
		["Leather + Scrap Metal"] = t18,
		["Magma Ore"] = t20,
		["Fish Tail"] = t21,
		["Mystic Droplet"] = t22,
		["Radiactive Material"] = t23,
		["Vampire Fang"] = t25,
		Gunpowder = t26,
		["Mini Tusk"] = t27,
		["Conjured Cocoa"] = t28,
		["Dragon Scale"] = t29
	}
    local t31 = {
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

    function t15.ToolDebounce()
        n4 = tick()
    end
    function t15.GotoTargetCFrame(p41)
        MoveCharacter(p41)
        EnableBuso()
        EquipTool()
    end
    function t15.GetNextAxis(p42)
        if tick() - p42.axisDebounce <= 0.4 then
            return p42.nextAxis
        end

        local v534 = Vector3[not (math.random() <= 0.5) and "zAxis" or "xAxis"]
        local v535 = math.random() <= 0.5 and v46.FarmDistance or -v46.FarmDistance
        local v536 = Vector3.yAxis * 8
        local v537 = v534 * v535 + v536

        p42.axisDebounce = tick()
        p42.nextAxis = v537

        return v537
    end
    function t15.Mastery(_, p44, p45)
        local Health = p45.Health

        for _, child in ipairs(Enemies:GetChildren()) do
            if child.PrimaryPart then
                local Humanoid = child:FindFirstChildOfClass("Humanoid")
                local v545 = Humanoid

                if Humanoid then
                    v545 = Humanoid.Health > 0 and Health >= Humanoid.Health
                end

                if v545 then
                    Health = Humanoid.Health
                    p45 = Humanoid
                    p44 = child.PrimaryPart
                end
            end
        end

        local v546 = p44.CFrame + v46.FarmPos
        local v547 = p45.Health / p45.MaxHealth * 100
        local v548 = v547 <= v46.mHealth and v46.mTool or "Melee"

        EquipTool(v548, true)

        local p44Parent = p44.Parent

        u55:BringEnemies(p44Parent)
        EnableBuso()

        if LocalPlayer:DistanceFromCharacter(v546.Position) >= 2.5 then
            MoveCharacter(v546)
        end

        local v550 = v547 <= v46.mHealth

        if v550 then
            v550 = LocalPlayer:DistanceFromCharacter(v546.Position) < 5
        end

        if v550 then
            u55.Hooking:SetTarget(p44, p44.Parent, true)
            u55.UseSkills(p44, v46.MasterySkills)
        end
    end
    function t15.attack(p46, p47, p48, p49)
        local Humanoid = p46:FindFirstChild("Humanoid")

        if not Humanoid then
            return nil
        end

        if v48.Mastery and Humanoid.MaxHealth < 40000 then
            local PrimaryPart = p46.PrimaryPart

            t15:Mastery(PrimaryPart, Humanoid)

            return true
        end

        if p47 then
            u55:BringEnemies(p46, p48)
        end

        if tick() - n4 >= 1 then
            EquipTool()
        end

        EnableBuso()
        t15.FarmModes[p49 or v46.FarmMode](t15, p46.PrimaryPart, p49)

        local SmoothMode = v46.SmoothMode

        if SmoothMode then
            SmoothMode = p49 or v46.FarmMode ~= "Orbit"
        end

        if SmoothMode then
            local elapsed = task.wait(0.1)

            if elapsed then
                elapsed = IsAlive(p46)

                if elapsed then
                    elapsed = p46.PrimaryPart and v48[v46.RunningOption]
                end
            end

            if elapsed then
                local v559 = v38

                v46.RunningMethod = "Killing: " .. p46.Name
                v559.OnFarm = true
                t15.attack(p46, p47, p48, p49)
            end
        end

        return true
    end
    function t15.Material(p50, p51)
        local v562 = t30[p51] and t30[p51][u55.GameData.Sea]
        local v563 = t31[p51]

        if v563 then
            local EnemyLocation = p50.EnemyLocation
            local CanFarm = p50.CanFarm

            if CanFarm[p51] == nil then
                if v563[2][u55.GameData.Sea] then
                    CanFarm[p51] = true
                else
                    CanFarm[p51] = false
                end
            end

            if not CanFarm[p51] then
                return nil
            end

            if EnemyLocation[p51] == nil then
                for _, v in ipairs(v563[1]) do
                    local v568 = EnemyLocations[v]

                    if v568 and #v568 > 0 then
                        EnemyLocation[p51] = v568
                    end
                end

                if not EnemyLocation[p51] then
                    EnemyLocation[p51] = false
                end
            end

            for _, v in ipairs(v563[1]) do
                local v571 = EnemySpawned(v)

                if v571 and v571.PrimaryPart then
                    p50.attack(v571, true, true)

                    return "Killing: " .. v
                end
            end

            if EnemyLocation[p51] then
                Managers.TweenManager:TweenToCFrameQueue(EnemyLocation[p51])
            else
                MoveCharacter(v562)
            end

            return "Farming Material: " .. p51
        end
    end
    function t15.GetNpcVectorCFrame(_, p53)
        if t16[p53] then
            return t16[p53]:GetPivot()
        end

        local v574 = NPCs:FindFirstChild(p53) or ReplicatedStorage.NPCs:FindFirstChild(p53)

        if v574 then
            t16[p53] = v574

            return v574:GetPivot()
        end
    end

    return t15
end
function Managers.RaidManager()
    if u55.GameData.Sea ~= 2 and u55.GameData.Sea ~= 3 then
        return nil
    end

    if u55.GameData.Sea ~= 2 then
    end

    local cFrame = CFrame.new(-5033, 315, -2950)
    local Timer = LocalPlayer.PlayerGui:WaitForChild("Main").Timer
    local v153 = if u55.GameData.Sea ~= 2 then u55.GameData.Sea == 3 and "Boat Castle.RaidSummon2.Button.Main" else "CircleIsland.RaidSummon2.Button.Main"

    return {
		RaidPosition = cFrame,
		requests = {},
		Require = 0,
		Timer = Timer,
		Button = v153,
		IsRaiding = function(_)
        return v48.Raid and LocalPlayer:GetAttribute("IslandRaiding")
    end,
		GetRaidIsland = function(_)
        return u55:GetRaidIsland()
    end,
		CanStartRaid = function(_)
        return Level.Value >= 1200 and VerifyTool("Special Microchip")
    end,
		start = function(p57)
        if not p57:IsRaiding() and p57:CanStartRaid() then
            local parts = p57.Button:split(".")
            local v580 = Map

            for i = 1, #parts do
                if v580 then
                    v580 = v580:FindFirstChild(parts[i])
                end
            end

            if v580 and v580:FindFirstChild("ClickDetector") then
                fireclickdetector(v580.ClickDetector)
                task.wait(1)

                return
            end

            return MoveCharacter(p57.RaidPosition)
        end
    end
	}
end
function Managers.ItemsManager()
    local t32 = {}
    local Sea = u55.GameData.Sea
    local IsSpawned = u55.Enemies.IsSpawned
    local EnemySpawned = u55.EnemySpawned
    local EnemyLocations = u55.EnemyLocations
    local EquipTool = u55.EquipTool
    local FireRemote = u55.FireRemote
    local IsAlive = u55.IsAlive
    local Count = u55.Inventory.Count
    local Unlocked = u55.Inventory.Unlocked

    if Sea == 3 then
        t32.CursedDualKatana = {}
        t32.SkullGuitar = {}
        local u164
        t32.DojoTrainer = {}
        local u165
        local u166
        local u167
        local u168
        local u169
        local u170
        local cFrame = CFrame.new(5867, 1208, 872)
        local cFrame3 = CFrame.new(5771, 1209, 804)
        local function v173()
            if u165 and u165.Value > 0 then
                return u165
            end

            local huge = math.huge

            u165 = nil

            for _, child in ipairs(LocalPlayer.QuestHaze:GetChildren()) do
                if child.Value > 0 then
                    local Position = child:GetAttribute("Position")
                    local v589 = typeof(Position) == "Vector3" and LocalPlayer:DistanceFromCharacter(Position)

                    if v589 and v589 <= huge then
                        u165 = child
                        huge = v589
                    end
                end
            end

            return u165
        end
        local function v174(p58, p59)
            local v599 = not p59 and "Pedestal" or "Torch"

            for i = 1, 3 do
                local v601 = p58:FindFirstChild(v599 .. i)
                local v602 = v601

                if v601 then
                    v602 = v601:FindFirstChild("ProximityPrompt") and v601.ProximityPrompt.Enabled
                end

                if v602 then
                    return v601
                end
            end
        end
        function u170(p60)
            local huge = math.huge
            local v605
            for _, child in ipairs(ReplicatedStorage.NPCs:GetChildren()) do
                local v608 = child.Name == "Luxury Boat Dealer"

                if v608 then
                    v608 = not p60[child] and child.PrimaryPart
                end

                if v608 then
                    local v609 = LocalPlayer:DistanceFromCharacter(child.PrimaryPart.Position)

                    if v609 <= huge then
                        v605 = child
                        huge = v609
                    end
                end
            end

            return v605
        end
        function u164(p61, p62)
            local v612 = v174(p61, true)

            if not v612 then
                v612 = p61:FindFirstChild("Exit")
            end

            local v613 = v612

            if v612 then
                v613 = LocalPlayer:DistanceFromCharacter(v612.Position) <= 1000
            end

            if v613 then
                local v614 = EnemySpawned(p62)

                if v614 and v614.PrimaryPart then
                    local PrimaryPartCFrame = v614.PrimaryPart.CFrame
                    local FarmPos = v46.FarmPos

                    MoveCharacter(PrimaryPartCFrame + FarmPos)

                    return true, u55.KillAura(125)
                end

                local v617 = v612.Name ~= "Exit"

                if v617 then
                    v617 = LocalPlayer:DistanceFromCharacter(v612.Position) < 5
                end

                if v617 then
                    fireproximityprompt(v612.ProximityPrompt)
                else
                    MoveCharacter(v612.CFrame)
                end
            end

            return true
        end
        local CursedDualKatana = t32.CursedDualKatana
        CursedDualKatana.Tushita = {
			function(p63, _)
            if not LocalPlayer:FindFirstChild("BoatQuest") then
                return
            end

            if not u166 or p63.BoatsDealer[u166] then
                local v592 = NPCs:FindFirstChild("Luxury Boat Dealer")
                local v593 = not v592

                if not v593 then
                    v593 = not v592.PrimaryPart or p63.BoatsDealer[v592]
                end

                if v593 then
                    u166 = u170(p63.BoatsDealer)
                else
                    u166 = v592
                end
            end

            local v594 = u166 and u166.PrimaryPart

            if v594 then
                if LocalPlayer:DistanceFromCharacter(v594.Position) < 5 then
                    if FireRemote("CDKQuest", "BoatQuest", u166, "Check") then
                        FireRemote("CDKQuest", "BoatQuest", u166)
                    end

                    p63.BoatsDealer[u166] = true

                    return
                end

                return true, MoveCharacter(v594.CFrame)
            end

            task.wait(0.5)
        end,
			function(_, p66)
            return p66.PirateRaid()
        end,
			function(p67, _)
            if Map:FindFirstChild("HeavenlyDimension") then
                return u164(Map.HeavenlyDimension, p67.Heaven)
            end

            if IsSpawned("Cake Queen") then
                local v584 = EnemySpawned("Cake Queen")

                if v584 and v584.PrimaryPart then
                    Managers.FarmManager.attack(v584, true)
                else
                    MoveCharacter(p67.CakeQueen)
                end

                return true
            end
        end
		}
        CursedDualKatana.Yama = {
			function(p69, _)
            if not VerifyTool("Yama") then
                return FireRemote("LoadItem", "Yama")
            end

            local v620 = EnemySpawned("Forest Pirate")

            EquipTool("Yama")

            if v620 and v620.PrimaryPart then
                u55.AttackCooldown = tick()
                MoveCharacter(v620.PrimaryPart.CFrame * CFrame.new(0, 0, -2))
            else
                MoveCharacter(p69.ForestPirate)
            end

            return true
        end,
			function(_, _)
            if not LocalPlayer:FindFirstChild("QuestHaze") then
                return
            end

            local v626 = v173()

            if v626 then
                local Name = v626.Name
                local v628 = EnemySpawned(Name)

                if v628 and v628.PrimaryPart then
                    Managers.FarmManager.attack(v628, true)
                elseif EnemyLocations[Name] then
                    Managers.TweenManager:TweenToCFrameQueue(EnemyLocations[Name])
                else
                    MoveCharacter(v626:GetAttribute("Position"))
                end

                return true
            end
        end,
			function(p73, p74)
            if Map:FindFirstChild("HellDimension") then
                return u164(Map.HellDimension, p73.Hell)
            end

            if IsSpawned("Soul Reaper") then
                local v623 = EnemySpawned("Soul Reaper")

                if v623 and v623.PrimaryPart then
                    if LocalPlayer:DistanceFromCharacter(v623.PrimaryPart.Position) > 6 then
                        MoveCharacter(v623.PrimaryPart.CFrame * CFrame.new(0, 0, -2))
                    end

                    return true
                end

                return
            end

            return p74.SoulReaper() or p74.Bones()
        end
		}
        function CursedDualKatana.FinalQuest(p75, _)
            if not VerifyTool("Tushita") and not VerifyTool("Yama") then
                return FireRemote("LoadItem", "Yama")
            end

            if IsSpawned("Cursed Skeleton Boss") then
                local v631 = EnemySpawned("Cursed Skeleton Boss")

                if v631 and v631.PrimaryPart then
                    EquipTool("Sword", true)
                    Managers.FarmManager.ToolDebounce()
                    Managers.FarmManager.attack(v631, true)

                    return true
                end

                return false
            end

            if LocalPlayer.PlayerGui.Main.Dialogue.Visible then
                VirtualUser:ClickButton1(Vector2.new(10000, 10000))
            end

            local v632 = v174(Map.Turtle.Cursed)

            if v632 then
                if LocalPlayer:DistanceFromCharacter(v632.Position) < 5 then
                    fireproximityprompt(v632.ProximityPrompt)
                else
                    MoveCharacter(v632.CFrame)
                end

                return true
            end

            local v633 = LocalPlayer:DistanceFromCharacter(p75.CursedSkeleton[1].Position)

            if v633 > 6 then
                MoveCharacter(p75.CursedSkeleton[1], v633 <= 100 and 40)
            else
                MoveCharacter(p75.CursedSkeleton[2])
            end

            task.wait(0.5)

            return true
        end
        local DojoTrainer = t32.DojoTrainer
        local t33 = {
			NPC = "Dojo Trainer",
			Command = "ClaimQuest"
		}
        local t34 = {
			NPC = "Dojo Trainer",
			Command = "RequestQuest"
		}
        local t35 = {
			NPC = "Dragon Wizard",
			Command = "Speak"
		}
        local t36 = {
			NPC = "Dragon Wizard",
			Command = "DragonRace"
		}
        local t37 = {
			NPC = "Dragon Wizard",
			Command = "LearnTether"
		}
        local t38 = {
			NPC = "Dragon Wizard",
			Command = "Ascension",
			Action = "Begin"
		}
        local t39 = {
			NPC = "Dragon Wizard",
			Command = "Ascension",
			Action = "Complete"
		}
        local v184 = CreateDictionary({ "Terrorshark" }, true)
        local v185 = CreateDictionary({
			"Piranha",
			"Shark"
		}, true)
        local v186 = CreateDictionary({ "Terrorshark" }, true)
        local v187 = Net:WaitForChild("RF/InteractDragonQuest")
        DojoTrainer.Progress = {}
        DojoTrainer.BeltQuest = nil
        local t40 = {
			White = 20,
			Green = 360,
			Purple = 3,
			Red = 1,
			Yellow = 8,
			Blue = 1,
			Black = 3
		}
        local function v189(p77)
            return p77.CraftVolcanicMagnet() or p77.FullyVolcano(true, true)
        end
        local function v190(p78)
            local v636 = Unlocked["Dragon Egg"]

            if not v636 then
                v636 = u169.CanTransform or u169.CanTransformFree
            end

            if v636 then
                return DojoTrainer:InteractWithNpcDraco(t36)
            end

            if not u169.TetherLearned then
                return DojoTrainer:InteractWithNpcDraco(t37)
            end

            return v189(p78)
        end
        local function v191(p79, p80)
            if p79 == "V2" or p79 == "V3" then
                return DojoTrainer:InteractWithNpcDraco(t38)
            end

            if p79 == "V2InProgress" then
                if Count["Fire Flower"] >= 5 then
                    return DojoTrainer:InteractWithNpcDraco(t39)
                end

                return "FireFlowers"
            end

            if p79 == "V3InProgress" then
                if DojoTrainer.DracoV3Completed then
                    return DojoTrainer:InteractWithNpcDraco(t39)
                end

                return p80.Sea(v186, false)
            end

            if p79 == "V2TurnInReady" or p79 == "V3TurnInReady" then
                if Data.Level.Value >= (p79 ~= "V3TurnInReady" and 1000000 or 3000000) then
                    return self:InteractWithNpcDraco(t39)
                end

                return p80.Level()
            end
        end
        function DojoTrainer.BeltWhite(_, p82)
            return p82.Level()
        end
        function DojoTrainer.BeltGreen(p83)
            if LocalPlayer:GetAttribute("DangerLevel") >= 600 and p83.GreenTimer then
                p83.Progress.Green = p83.Progress.Green + (tick() - p83.GreenTimer)
            end

            p83.GreenTimer = tick()

            return Managers.SeaManager:DriveBoat("inf")
        end
        function DojoTrainer.BeltPurple(p84, p85)
            if not p84.PurpleProgress then
                p84.StartPurpleProgress = p84.Progress.Purple
                p84.PurpleProgress = u55:GetProgress("EliteProgress", "EliteHunter", "Progress")

                return
            end

            if not p85.EliteHunter() then
                p84.Progress.Purple = p84.StartPurpleProgress + (u55:GetProgress("EliteProgress", "EliteHunter", "Progress") - p84.PurpleProgress)

                return
            end

            return true
        end
        function DojoTrainer.BeltRed(_, p87)
            return p87.Sea(v184, false)
        end
        function DojoTrainer.BeltYellow(_, p89)
            return p89.Sea(v185, false)
        end
        function DojoTrainer.BeltBlue(p90, p91)
            if not IsAlive(LocalPlayer.Character) then
                return
            end

            local v650 = u167

            if v650 then
                v650 = u167.Parent == LocalPlayer.Character or u167.Parent == LocalPlayer.Backpack
            end

            if v650 then
                p90.Progress.Blue = 1
            elseif u167 and u167.Parent ~= workspace then
                u167 = nil
            end

            if u167 then
                return p91.Fruits(u167)
            end

            local Tool = workspace:FindFirstChildOfClass("Tool")

            if Tool and Tool:GetAttribute("DroppedBy") ~= LocalPlayer.Name then
                u167 = Tool

                return
            end

            if Tool then
                Tool.Parent = Map
            end
        end
        function DojoTrainer.BeltBlack(p92, p93)
            if not p92.BlackProgress then
                p92.BlackProgress = p92.Progress.Black - Count["Dinosaur Bones"]

                return
            end

            p92.Progress.Black = Count["Dinosaur Bones"] - p92.BlackProgress

            return v189(p93)
        end
        function DojoTrainer.CollectBeltReward(p94, p95)
            if Unlocked["Dojo Belt (" .. p95 .. ")"] then
                p94.Progress[p95] = nil

                return false
            end

            if LocalPlayer:DistanceFromCharacter(cFrame.Position) <= 5 then
                v187:InvokeServer(t33)
            else
                MoveCharacter(cFrame)
            end

            return true
        end
        function DojoTrainer.UpdateBeltProgress(p96, p97, p98)
            if p97 == p96.BeltQuest then
                p96.Progress[p97] = (p96.Progress[p97] or 0) + p98

                return
            end

            local v659 = p97 == "Red"

            if v659 then
                v659 = u169 and u169.AvailableVQuest == "V3InProgress"
            end

            if v659 then
                p96.DracoV3Completed = true
            end
        end
        function DojoTrainer.GetBelt(p99, p100, p101)
            local BeltName = p100.BeltName
            local v664 = p99["Belt" .. BeltName]

            if not v664 then
                return false
            end

            if Unlocked["Dojo Belt (" .. BeltName .. ")"] then
                return p99:InteractWithDojoTrainer()
            end

            if not p99.Progress[BeltName] or not p100.UpdatedProgress then
                p99.Progress[BeltName] = p100.Progress
                p100.UpdatedProgress = true
            end

            if p99.Progress[BeltName] >= t40[BeltName] then
                return p99:CollectBeltReward(BeltName)
            end

            p99.BeltQuest = BeltName

            if v664(p99, p101) then
                return "Belt Quest: " .. BeltName
            end
        end
        function DojoTrainer.InteractWithDojoTrainer(_)
            if LocalPlayer:DistanceFromCharacter(cFrame.Position) <= 5 then
                u168 = v187:InvokeServer(t34)
            else
                MoveCharacter(cFrame)
            end

            return "Getting Belt Quest"
        end
        function DojoTrainer.InteractWithDragonWizard(_)
            if LocalPlayer:DistanceFromCharacter(cFrame3.Position) <= 5 then
                u169 = v187:InvokeServer(t35)
            else
                MoveCharacter(cFrame3)
            end

            return "Getting Draco Quest"
        end
        function DojoTrainer.InteractWithNpcDraco(_, p105)
            if LocalPlayer:DistanceFromCharacter(cFrame3.Position) <= 5 then
                if v187:InvokeServer(p105) then
                    u169 = nil
                end
            else
                MoveCharacter(cFrame3)
            end

            return true
        end
        function DojoTrainer.Train(p106, p107)
            if type(u168) == "table" then
                if u168.Timeout or u168.Completed then
                    return nil
                end

                if u168.Quest then
                    return p106:GetBelt(u168.Quest, p107)
                end

                return
            end

            return p106:InteractWithDojoTrainer()
        end
        function DojoTrainer.EvoDracoRace(p108, p109)
            if not Unlocked["Dojo Belt (Black)"] then
                return p109.DojoTrainer()
            end

            if type(u169) ~= "table" then
                return p108:InteractWithDragonWizard()
            end

            if not u169.TetherLearned and not u169.CanLearnTether then
                return false
            end

            if not u169.FoundPrehistoric then
                return v189(p109)
            end

            if Data.Race.Value ~= "Draco" then
                return v190(p109)
            end

            if u169.AvailableVQuest then
                return v191(u169.AvailableVQuest, p109)
            end
        end
        local _ = t32.SkullGuitar
    end

    return t32
end
function Managers.EspManager()
    local t41 = {}

    t41.__index = t41

    function t41.__newindex(p110, p111, p112)
        if p111 == "Enabled" then
            task.spawn(p110.ToggleEsp, p110, p112)

            return
        end

        rawset(p110, p111, p112)
    end

    local Folder = Instance.new("Folder", CoreGui)

    Folder.Name = "redzHub-EspFolder"

    local FolderName = CoreGui:FindFirstChild(Folder.Name)

    if FolderName and FolderName ~= Folder then
        FolderName:Destroy()
    end

    local BoxHandleAdornment = Instance.new("BoxHandleAdornment")
    local v197 = BoxHandleAdornment

    v197.Size = Vector3.new(1, 0, 1, 0)
    v197.AlwaysOnTop = true
    v197.ZIndex = 10
    v197.Transparency = 0

    local BillboardGui = Instance.new("BillboardGui", v197)

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
    local t42 = {}

    local function v202(p113)
        if p113:IsA("BasePart") then
            return p113
        end

        if p113:IsA("Model") then
            return p113.PrimaryPart or p113:GetPivot()
        end

        if p113.Parent:IsA("Model") then
            return p113.Parent.PrimaryPart or p113.Parent:GetPivot()
        end
    end

    function t41.SetCustomEspDisplay(p114, p115)
        p114.CustomEspDisplay = p115

        return p114
    end
    function t41.SetObjects(p116, p117)
        p116.GetObjectsAction = p117

        return p116
    end
    function t41.GetInstance(p118, p119)
        p118.OnlyOneInstanceAction = p119

        return p118
    end
    function t41.SetInstanceName(p120, p121, p122)
        p120.EspsNames[p121] = p122

        return p120
    end
    function t41.SetAllInstancesName(p123, p124)
        p123.CustomInstanceName = p124

        return p123
    end
    function t41.WaitChildsAdded(p125)
        p125._WaitChildsAdded = true

        return p125
    end
    function t41.SetEspColor(p126, p127)
        p126.EspColor = p127

        return p126
    end
    function t41.SetAlwaysValidate(p128)
        p128.AlwaysValidateInstance = true

        return p128
    end
    function t41.Validator(p129, p130)
        p129.ValidateInstance = p130

        return p129
    end
    function t41.ChangeEspSize(p131, p132)
        p131.EspSize = p132

        for i = 1, #t42 do
            for _, v in pairs(t42[i].EspObjects) do
                v.BoxHandleAdornment.BillboardGui.TextLabel.TextSize = p132
            end
        end

        return p131
    end
    function t41.StartRunningEsp(p133, p134)
        local Instance2 = p134.Instance
        local BoxHandleAdornment2 = p134.BoxHandleAdornment
        local TextLabel2 = BoxHandleAdornment2.BillboardGui.TextLabel
        local _ = p133.EspFolder
        local v705 = Instance2:IsA("Model")
        local v706
        while task.wait(not v46.SmoothMode and 0 or 0.25) do
            if not BoxHandleAdornment2 or not BoxHandleAdornment2.Parent then
                return p133:Clear(p134)
            end

            if p133.AlwaysValidateInstance and not p133.ValidateInstance(Instance2) then
                return p133:Clear(p134)
            end

            if not Instance2:IsDescendantOf(workspace) and not Instance2:IsDescendantOf(ReplicatedStorage) then
                return p133:Clear(p134)
            end

            v706 = v706 or v202(Instance2)

            if not v706 then
                return p133:Clear(p134)
            end

            local v707 = math.floor(LocalPlayer:DistanceFromCharacter(v706.Position) / 5)
            local v708 = v705 and Instance2:FindFirstChildOfClass("Humanoid")

            if v708 then
                TextLabel2.Text = ("%s<font color='rgb(160, 160, 160)'> [ %im ]</font>\n<font color='rgb(25, 240, 25)'>[%i/%i]</font>"):format(Instance2.Name, v707, math.floor(v708.Health), (math.floor(v708.MaxHealth)))
            elseif p133.CustomEspDisplay then
                TextLabel2.Text = p133.CustomEspDisplay(Instance2, v707)
            else
                local CustomInstanceName = p133.CustomInstanceName

                if not CustomInstanceName then
                    CustomInstanceName = p133.EspsNames[Instance2] or Instance2.Name
                end

                TextLabel2.Text = ("%s < %i >").format("%s < %i >", CustomInstanceName, v707)
            end
        end
    end
    function t41.Create(p135, p136)
        if p135.EspObjects[p136] then
            return
        end

        local t43 = {
			Instance = p136,
			BoxHandleAdornment = nil
		}
        local clone = BoxHandleAdornment:Clone()
        local BillboardGui2 = clone.BillboardGui
        local TextLabel3 = BillboardGui2.TextLabel

        BillboardGui2.Adornee = p136:IsA("BasePart") or (p136:IsA("Model") and p136 or p136.Parent)

        local v716 = type(p135.EspColor) == "function" and p135.EspColor(p136)

        if not v716 then
            v716 = p135.EspColor or color3
        end

        TextLabel3.TextColor3 = v716
        TextLabel3.Text = p135.CustomInstanceName or "..."
        TextLabel3.TextSize = p135.EspSize or TextLabel3.TextSize
        clone.Parent = p135.EspFolder
        p135.EspObjects[p136] = t43
        t43.BoxHandleAdornment = clone
        task.spawn(p135.StartRunningEsp, p135, t43)

        return t43
    end
    function t41.Clear(p137, p138)
        if p138 then
            p137.EspObjects[p138.Instance] = nil

            if p138.BoxHandleAdornment then
                p138.BoxHandleAdornment:Destroy()

                return
            end
        else
            table.clear(p137.EspObjects)
            p137.EspFolder:ClearAllChildren()
        end
    end
    function t41.ToggleEsp(p139, p140)
        local v721 = "redzHub_Esp_" .. p139.SpecialTag

        v38[v721] = p140

        if not p140 then
            return p139:Clear()
        end

        while v38[v721] do
            local GetObjectsAction = p139.GetObjectsAction

            if p139.OnlyOneInstanceAction then
                local v723 = p139.OnlyOneInstanceAction()

                if v723 then
                    p139:Create(v723)
                end
            elseif GetObjectsAction then
                local v724 = typeof(GetObjectsAction) == "Instance" and GetObjectsAction:GetChildren() or GetObjectsAction
                local ValidateInstance = p139.ValidateInstance
                local EspObjects = p139.EspObjects

                for i = 1, #v724 do
                    local v728 = v724[i]
                    local v729 = not EspObjects[v728]

                    if v729 then
                        v729 = not ValidateInstance or ValidateInstance(v728)
                    end

                    if v729 then
                        p139:Create(v728)
                    end
                end
            end

            if not CreatedNew and p139._WaitChildsAdded then
                GetObjectsAction.ChildAdded:Wait()
            end

            task.wait(0.25)
        end
    end
    function t41.new(p141)
        local Folder2 = Instance.new("Folder", Folder)

        Folder2.Name = p141

        local v732 = setmetatable({
			SpecialTag = p141,
			EspObjects = {},
			EspsNames = {},
			EspFolder = Folder2
		}, t41)

        table.insert(t42, v732)

        return v732
    end

    return t41
end
function Managers.SeaManager()
    if u55.GameData.Sea == 1 then
        return
    end

    local t44 = {
		Weapons = {
			"Melee",
			"Blox Fruit",
			"Sword",
			"Gun"
		},
		Selected = "Melee",
		Debounce = 0
	}
    local t45 = {
		CFrame.new(94, 10, 2951),
		CFrame.new(-5288, 5, -701)
	}
    local t46 = {
		CFrame.new(-6123, 16, -2247),
		CFrame.new(-16917, 9, 510)
	}
    local v206 = u55.GameData.Sea - 1
    local t47 = {
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
			t45,
			t46
		})[v206]
	}
    local t48 = {
		Vector3.new(1, 0, 0),
		Vector3.new(0, 0, 1),
		Vector3.new(-1, 0, 0),
		Vector3.new(0, 0, -1),
		Vector3.new(0, 0, 0)
	}
    local v209 = ({
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
	})[u55.GameData.Sea - 1]
    local t49 = {
		RandomWeapons = t44,
		Boats = t47,
		SeaBeastDirections = t48,
		SeaPositions = v209
	}
    local SubclassNetwork = Remotes:WaitForChild("SubclassNetwork")

    if u55.GameData.Sea == 3 then
        for k, v in pairs(t49.SeaPositions) do
            t49.SeaPositions[k] = {
				CFrame.new(v, 19, 500),
				CFrame.new(v - 3000, 19, 500),
				CFrame.new(v - 3000, 19, 2000),
				CFrame.new(v, 19, -1000)
			}
        end
    end

    local IsAlive = u55.IsAlive
    local FireRemote = u55.FireRemote
    local Count = u55.Inventory.Count
    local _ = u55.Inventory.Unlocked
    local UseSkills = u55.UseSkills
    local EquipTool = u55.EquipTool
    local Tween = u55.Tween
    local Sea = u55.GameData.Sea
    local u222 = false
    local v223 = Vector3.yAxis * 40
    local v224 = Vector3.yAxis * 20
    local n6 = 0
    local n7 = 1

    local function v227(p142)
        if p142 then
            p142 = not p142:FindFirstChild("Humanoid") or p142.Humanoid.Value > 0
        end

        return p142
    end
    local function v228(p143)
        return p143:FindFirstChild("Owner") and p143.Owner.Value == LocalPlayer
    end
    local function v229(p144)
        if p144:GetAttribute("Repairing") then
            return
        end

        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        p144.AncestryChanged:Wait()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end
    local function v230(p145, p146)
        if p146 <= tick() - n6 then
            n6 = tick()
            n7 = math.random(p145)
        end

        return n7
    end
    local function v231(p147, p148)
        if u222 and u222.Position.Y > -2 then
            return true
        end

        if p148.Position.Y > -2 then
            u222 = p148

            return true
        end

        for _, child in ipairs(Enemies:GetChildren()) do
            if not (p147 == child.Name and IsAlive(child)) then
                continue
            end

            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")
            local v743 = HumanoidRootPart

            if HumanoidRootPart then
                v743 = HumanoidRootPart.Position.Y > -2

                if v743 then
                    v743 = LocalPlayer:DistanceFromCharacter(HumanoidRootPart.Position) <= 500
                end
            end

            if v743 then
                u222 = HumanoidRootPart

                return true
            end
        end
    end

    function t49.GetRandomWeapon(p149)
        local RandomWeapons = p149.RandomWeapons
        local Debounce = RandomWeapons.Debounce

        if tick() - Debounce >= 2 then
            local Weapons = RandomWeapons.Weapons
            local v748 = table.find(Weapons, RandomWeapons.Selected) + 1
            local v749 = Weapons[v748] or Weapons[1]

            while not VerifyToolTip(v749) do
                v748 = ((if not (v748 > #Weapons) then v748 else 0)) + 1
                v749 = RandomWeapons.Weapons[v748]
            end

            local timestamp = tick()

            RandomWeapons.Selected = v749
            RandomWeapons.Debounce = timestamp

            return v749
        end

        return RandomWeapons.Selected
    end
    function t49.GetMyBoat(p150)
        if not IsAlive(LocalPlayer.Character) then
            return
        end

        local SeatPart = LocalPlayer.Character.Humanoid.SeatPart
        local v753 = SeatPart

        if SeatPart then
            v753 = SeatPart.Name == "VehicleSeat" and v227(SeatPart.Parent)
        end

        if v753 then
            return SeatPart.Parent, SeatPart.Parent.PrimaryPart
        end

        local MyBoat = p150.Boats.MyBoat
        local v755 = v227(MyBoat)

        if v755 then
            v755 = MyBoat.Parent

            if v755 then
                v755 = LocalPlayer:DistanceFromCharacter((MyBoat.PrimaryPart or MyBoat:GetPivot()).Position) <= 12000
            end
        end

        if v755 then
            return MyBoat, MyBoat.PrimaryPart
        end

        for _, child in ipairs(Boats:GetChildren()) do
            local v758 = v228(child)

            if v758 then
                v758 = v227(child)

                if v758 then
                    v758 = LocalPlayer:DistanceFromCharacter((child.PrimaryPart or child:GetPivot()).Position) <= 8000
                end
            end

            if v758 then
                if child.Name ~= p150.Boats.SelectedBoat then
                    p150.Boats.SelectedBoat = child.Name
                end

                p150.Boats.MyBoat = child

                return child, child.PrimaryPart
            end
        end
    end
    function t49.GetClosestBoatDealer(_, p152, p153)
        if #p153 < 2 then
            return p153[1]
        end
        local p152Position = p152.Position
        local v763
        local huge = math.huge
        for _, v in ipairs(p153) do
            local Magnitude = (p152Position - v.Position).Magnitude

            if Magnitude < huge then
                huge = Magnitude
                v763 = v
            end
        end

        return v763
    end
    function t49.BuyNewBoat(p154)
        if not IsAlive(LocalPlayer.Character) then
            return
        end

        local _ = LocalPlayer.Character.Humanoid
        local SelectedBoat = p154.Boats.SelectedBoat
        local OthersBoats = p154.Boats.OthersBoats
        local ClosestBoatDealer = p154:GetClosestBoatDealer(LocalPlayer.Character:GetPivot(), p154.Boats.Spawns)

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
    function t49.RepairBoat(p155, p156)
        if not p156 then
            p156 = p155:GetMyBoat()
        end

        if not IsAlive(LocalPlayer.Character) or not p156 then
            return
        end

        local Character = LocalPlayer.Character
        local Humanoid = p156.Humanoid
        local GetAttribute = p156.GetAttribute
        local _RepairHammer = Character:FindFirstChild("_RepairHammer")

        p156:SetAttribute("_Repairing", Humanoid.Value < (GetAttribute(p156, "MaxHealth") or Humanoid.Value))

        if not p156:GetAttribute("_Repairing") and _RepairHammer then
            return true, SubclassNetwork.UseSubclass:InvokeServer({
				Action = "RequestHammer"
			})
        end

        if _RepairHammer and _RepairHammer:WaitForChild("Marker") then
            local WorldCFrame = _RepairHammer.Marker.Value.WorldCFrame
            local v780 = Vector3.xAxis * 10

            MoveCharacter(WorldCFrame + v780)

            return true, task.spawn(v229, _RepairHammer)
        end

        if p156:FindFirstChild("VehicleSeat") then
            local v781 = p156.VehicleSeat.CFrame + Vector3.yAxis * 20

            if LocalPlayer:DistanceFromCharacter(v781.Position) <= 5 then
                SubclassNetwork.UseSubclass:InvokeServer({
					Action = "RequestHammer"
				})
            else
                MoveCharacter(v781)
            end
        end

        p155:StopMovingBoat(p156)

        return true
    end
    function t49.CanRepair(p157, p158)
        if not p158 then
            p158 = p157:GetMyBoat()
        end

        if v46.RepairBoat and p158 then
            local Humanoid = p158.Humanoid

            if Subclass.Value ~= "Shipwright" or Count["Wooden Plank"] == 0 then
                return false
            end

            local _Repairing = p158:GetAttribute("_Repairing")

            if not _Repairing then
                local GetAttribute = p158.GetAttribute

                _Repairing = Humanoid.Value < (GetAttribute(p158, "MaxHealth") or Humanoid.Value / 1.2)
            end

            if _Repairing then
                return true
            end
        end
    end
    function t49.MoveBoat(p159, p160, p161, p162)
        local Boats2 = p159.Boats

        if tick() - Boats2.MoveDebounce >= 0.5 then
            u55:RemoveBoatCollision(p160.Parent)

            local v792 = Tween
            local Unit = (p161.Position - p160.Position).Unit

            if not p162 then
                p162 = v46.BoatSpeed
            end

            v792.Velocity = Unit * p162
            Boats2.MoveDebounce = tick()
        end
    end
    function t49.GetCordinateCFrame(p163, p164, p165)
        if not p164 and Sea == 3 then
            p164 = v46.SeaLevel
        end

        local v797 = p164 and p163.SeaPositions[p164] or p163.SeaPositions
        local Boats3 = p163.Boats

        if #v797 == 1 then
            return v797[1]
        end

        if Boats3.NextNumber > #v797 then
            Boats3.NextNumber = 1
        end

        local v799 = v797[Boats3.NextNumber]

        if (p165.Position - v799.Position).Magnitude < 75 then
            Boats3.NextNumber = Boats3.NextNumber + 1

            return v797[Boats3.NextNumber] or v797[1]
        end

        return v799
    end
    function t49.StopMovingBoat(_)
        Tween.Velocity = Vector3.zero
    end
    function t49.DriveBoat(p167, p168)
        if not IsAlive(LocalPlayer.Character) then
            return
        end

        local Humanoid = LocalPlayer.Character.Humanoid
        local v804, v805 = p167:GetMyBoat()

        if v804 then
            local VehicleSeat = v804:FindFirstChild("VehicleSeat")

            if VehicleSeat and VehicleSeat ~= Humanoid.SeatPart then
                if LocalPlayer:DistanceFromCharacter(VehicleSeat.Position) <= 100 then
                    VehicleSeat:Sit(Humanoid)
                end

                return true, MoveCharacter(VehicleSeat.CFrame)
            end

            if VehicleSeat and v805 then
                if typeof(p168) ~= "CFrame" then
                    p168 = p167:GetCordinateCFrame(p168, v805)
                end

                if (v805.Position - p168.Position).Magnitude < 50 then
                    return true, p167:StopMovingBoat()
                end

                return true, p167:MoveBoat(v805, p168)
            end

            return
        end

        return p167:BuyNewBoat()
    end
    function t49.GetSeaEvents(p169, p170, p171, p172)
        for i = 1, #p170 do
            local v812 = p170[i]
            local v813 = p171[v812] or p172 and (p172[v812] and p169:GetSeaEvent(v812))

            if v813 then
                return v813
            end
        end
    end
    function t49.GetSeaBeast(p173)
        local SeaBeast = p173.SeaBeast
        if IsAlive(SeaBeast) and SeaBeast.Parent == SeaBeasts then
            return SeaBeast
        end
        if not SeaBeasts:FindFirstChildOfClass("Model") then
            return nil
        end
        local n8 = 5000
        local v817
        for _, child in ipairs(SeaBeasts:GetChildren()) do
            local v820 = LocalPlayer:DistanceFromCharacter((child.PrimaryPart or child:GetPivot()).Position)

            if IsAlive(child) and v820 < n8 then
                n8 = v820
                v817 = child
            end
        end
        p173.SeaBeast = v817

        return v817
    end
    function t49.GetSeaEvent(p174, p175)
        if p175 == "Sea Beast" then
            return p174:GetSeaBeast()
        end

        local v823, v824 = Enemies:FindFirstChild(p175)

        while v823 and not IsAlive(v823) do
            v824 = v824 or {}
            table.insert(v824, v823)
            v823.Name = "Died"
            v823 = Enemies:FindFirstChild(p175)
        end

        if v824 then
            for i = 1, #v824 do
                v824[i].Name = p175
            end
        end

        return v823
    end
    function t49.attackSeaEvent(p176, p177)
        if p177:GetAttribute("IsBoat") then
            return p176:attackSeaBoat(p177)
        end

        if p177.Parent == SeaBeasts then
            return p176:attackSeaBeast(p177)
        end

        return p176:attackSeaEnemy(p177)
    end
    function t49.attackSeaBoat(p178, p179)
        if not p179.PrimaryPart then
            return
        end

        local v830 = p179.PrimaryPart.CFrame + v224

        EnableBuso()
        MoveCharacter(v830)
        p178:StopMovingBoat()

        if LocalPlayer:DistanceFromCharacter(v830.Position) < 35 then
            local PrimaryPart = p179.PrimaryPart
            local SeaSkills = v46.SeaSkills

            UseSkills(PrimaryPart, SeaSkills)

            local GetRandomWeapon = p178.GetRandomWeapon

            EquipTool(GetRandomWeapon(p178), true)
        end
    end
    function t49.attackSeaEnemy(p180, p181)
        if not p181:FindFirstChild("HumanoidRootPart") then
            return
        end

        local HumanoidRootPart = p181.HumanoidRootPart
        local HumanoidRootPartCFrame = HumanoidRootPart.CFrame
        local v838 = p181.Name == "Terrorshark" or p181.Name == "Shark"

        if v838 then
            v838 = LocalPlayer:DistanceFromCharacter(HumanoidRootPartCFrame.Position) <= 250
        end

        local v839 = if not v838 then HumanoidRootPartCFrame + v223 else HumanoidRootPartCFrame + Vector3.yAxis * ((not v231(p181.Name, HumanoidRootPart) and 0 or 155) + 45)

        MoveCharacter(v839)
        EquipTool()
        EnableBuso()
        p180:StopMovingBoat()
    end
    function t49.attackSeaBeast(p182, p183)
        if not p183:FindFirstChild("HumanoidRootPart") then
            return
        end

        local SeaBeastDirections = p182.SeaBeastDirections
        local v843 = SeaBeastDirections[v230(#SeaBeastDirections, 1.5)] * 60
        local HumanoidRootPartPosition = p183.HumanoidRootPart.Position
        local v845 = CFrame.new(HumanoidRootPartPosition.X, 25, HumanoidRootPartPosition.Z) + v843

        EnableBuso()
        MoveCharacter(v845)
        p182:StopMovingBoat()

        local GetRandomWeapon = p182.GetRandomWeapon

        EquipTool(GetRandomWeapon(p182), true)
        UseSkills(v845, v46.SeaSkills)
    end

    return t49
end
function Managers.FruitManager()
    local t50 = {
		RandomDebounce = 0,
		MoneyToReroll = 0
	}
    local IsAlive = u55.IsAlive
    local Count = u55.Inventory.Count
    local _ = u55.Inventory.Unlocked

    function t50.GetRealFruitName(_, p185)
        local v849 = string.gsub(p185.Name, " Fruit", "")

        return v849 .. "-" .. v849
    end
    function t50.CanStoreFruit(p186, p187)
        return Count[p186:GetRealFruitName(p187)] < FruitCap.Value
    end
    function t50.StoreFruit(p188, p189)
        return u55.FireRemote("StoreFruit", p188:GetRealFruitName(p189), p189)
    end
    function t50.IsFruit(_, p191)
        return string.sub(p191.Name, -6, -1) == " Fruit" and p191:GetAttribute("DroppedBy")
    end
    function t50.GetInventoryItems(_)
        local children = LocalPlayer.Backpack:GetChildren()
        local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")

        if Tool then
            table.insert(children, Tool)
        end

        return children
    end
    function t50.CanBuyMicrochip(p193)
        if not IsAlive(LocalPlayer.Character) then
            return false
        end

        if LocalPlayer:GetAttribute("IslandRaiding") then
            return false
        end

        if LocalPlayer.Backpack:FindFirstChild("Microchip") or LocalPlayer.Character:FindFirstChild("Microchip") then
            return false
        end

        local GetInventoryItems = p193.GetInventoryItems

        for _, v in ipairs(GetInventoryItems(p193)) do
            if v:IsA("Tool") and p193:IsFruit(v) then
                return true
            end
        end

        return -1
    end
    function t50.GetStorableFruit(p194, p195)
        if not IsAlive(LocalPlayer.Character) then
            return false
        end

        local GetInventoryItems = p194.GetInventoryItems

        for _, v in ipairs(GetInventoryItems(p194)) do
            if p195 == v.Name then
                continue
            end

            if not IsAlive(LocalPlayer.Character) then
                return
            end

            local v868 = v:IsA("Tool")

            if v868 then
                v868 = p194:IsFruit(v) and p194:CanStoreFruit(v)
            end

            if v868 then
                return v
            end

            if v46.SmoothMode then
                task.wait()
            end
        end
    end
    function t50.RerollRandomFruit(p196)
        if Level.Value < 50 then
            return Level:GetPropertyChangedSignal("Value"):Wait()
        end

        if Beli.Value < p196.MoneyToReroll then
            return Beli:GetPropertyChangedSignal("Value"):Wait()
        end

        if tick() - p196.RandomDebounce >= 1 then
            local v870 = u55.FireRemote("Cousin", "Buy")

            if v870 == 1 then
                p196.RandomDebounce = tick() + 7200

                return
            end

            if v870 == 2 then
                local _, _, v873 = u55.FireRemote("Cousin", "Check")

                p196.MoneyToReroll = v873 or 0

                return
            end

            if type(v870) == "string" and v870:match("%d%d:%d%d") then
                local v874, v875 = v870:match("(%d+):(%d+)")
                local num = tonumber(v874)
                local num2 = tonumber(v875)

                if num and num2 then
                    local v878 = num * 60 * 60

                    p196.RandomDebounce = tick() + (v878 + num2 * 60)

                    return
                end
            else
                p196.RandomDebounce = tick() + 5
            end
        end
    end

    return t50
end
function t7.RunModules(p197)
    local _next = next
    local Managers2 = p197.Managers
    local v239
    while true do
        local v240

        v239, v240 = _next(Managers2, v239)

        if not v239 then
            break
        end

        local ok, result = pcall(v240)

        if ok then
            p197.Managers[v239] = result
            v38[v239] = result
        else
            v38[v239] = nil
            warn("falha ao carregar Module [ redz hub ]: " .. v239 .. " : " .. result)
        end
    end
end
function t7.Initialize(_)
    u54 = v4.load("{Owner}Library/refs/heads/main/V5/Source.lua")()
    u55 = v4.load("{Utils}BloxFruits/Module.luau", " return Module")(v46, v51)
    t7:RunModules()
end
function t7.LoadTabs(_, p200)
    local v246 = p200:MakeTab({
		"Discord",
		"Info"
	})
    local v247 = p200:MakeTab({
		"Farm",
		"Home"
	})
    local v248 = p200:MakeTab({
		"Sea",
		"Waves"
	})
    local MakeTab = p200.MakeTab
    local MakeTab2 = p200.MakeTab
    local v251 = MakeTab(p200, {
		"Islands",
		"PalmTree"
	})
    local v252 = MakeTab2(p200, {
		"Quests/Items",
		"Swords"
	})
    local v253 = p200:MakeTab({
		"Fruit/Raid",
		"Cherry"
	})
    local MakeTab3 = p200.MakeTab
    local v255 = p200:MakeTab({
		"Stats",
		"Signal"
	})
    local v256 = p200:MakeTab({
		"Teleport",
		"Locate"
	})
    local MakeTab4 = p200.MakeTab
    local v258 = MakeTab3(p200, {
		"Status",
		"scroll"
	})
    local v259 = MakeTab4(p200, {
		"Visual",
		"User"
	})

    return {
		Discord = v246,
		MainFarm = v247,
		Sea = v248,
		Islands = v251,
		Items = v252,
		FruitRaid = v253,
		Stats = v255,
		Teleport = v256,
		Status = v258,
		Visual = v259,
		Shop = p200:MakeTab({
			"Shop",
			"ShoppingCart"
		}),
		Misc = p200:MakeTab({
			"Misc",
			"Settings"
		})
	}
end
function t7.InstallPlugin(_)
    return {
		Toggle = u55.RunFunctions.LibraryToggle(v48, t2)
	}
end
function t7.GetTranslation(_, p203)
    local t51 = {
		BR = "Portuguese.json",
		VN = "Vietnamese.json",
		TH = "Thai.json"
	}

    if t51[p203] then
        local v264 = HttpService
        local t52 = { v4.get("{Translator}BloxFruits/" .. t51[p203]) }

        return v264:JSONDecode(v1(t52))
    end
end
function t7.Translator(p204, p205)
    if not v5.Translator then
        return p205
    end

    local ok, result, v270 = pcall(function()
        if readfile and (pcall(readfile, "PlayerCountry.txt") and type(nil) == "string") then
            return nil, true
        end

        return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
    end)
    local v271 = ok

    if ok then
        v271 = result

        if result then
            v271 = v270 ~= true and writefile
        end
    end

    if v271 then
        pcall(writefile, "PlayerCountry.txt", result)
    end

    local v272 = ok and p204:GetTranslation(result)

    if v272 then
        return u55.RunFunctions.Translator(p205, v272)
    end

    return p205
end
function t7.LoadLibrary(p206)
    local v274 = u54:MakeWindow({
		"redz Hub : Blox Fruits",
		"by real_redz",
		"redzHub-BloxFruits.json"
	})
    p206:Translator(v274)
    local v275 = p206:InstallPlugin(v274)
    local v276 = p206:LoadTabs(v274)
    local FruitManager = p206.Managers.FruitManager
    local _ = p206.Managers.QuestManager
    local FarmManager = p206.Managers.FarmManager
    local FireRemote = u55.FireRemote
    local Count = u55.Inventory.Count
    local Unlocked = u55.Inventory.Unlocked
    local Sea = u55.GameData.Sea
    local Toggle = v275.Toggle
    local MainFarm = v276.MainFarm
    local t53 = {
		Image = "rbxassetid://15298567397",
		BackgroundTransparency = 0
	}
    v274:SelectTab(MainFarm)
    local _UDim = UDim
    local AddMinimizeButton = v274.AddMinimizeButton
    local v289 = _UDim.new(0, 6)
    AddMinimizeButton(v274, {
		Button = t53,
		Corner = {
			CornerRadius = v289
		}
	})
    v276.Discord:AddDiscordInvite({
		Name = "redz Hub | Community",
		Description = "Join our discord community to receive Information about the next update, leaks, and Information about Blox Fruits!",
		Logo = "rbxassetid://17382040552",
		Invite = "https://discord.gg/7aR7kNVt4g"
	})
    local MainFarm2 = v276.MainFarm
    local t54 = {
		Bigger = 380,
		Large = 450,
		Medium = 620,
		Small = 760
	}
    local t55 = {
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
    local u293
    local function v294()
        local t56 = {}

        for k, _ in pairs(u55.Bosses) do
            local v885 = k

            if u55.Enemies.IsSpawned(v885) then
                table.insert(t56, v885)
            end
        end

        u293:Set(t56)
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
			v46,
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
		function(p207)
        pcall(u54.SetScale, u54, t54[p207] or 450)
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
				function(p208)
                v38.TradeBones = p208

                while v38.TradeBones do
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
		v294
	})
    u293 = MainFarm2:AddDropdown({
		"Boss List",
		{},
		false,
		{
			v46,
			"BossSelected"
		},
		"B-Selected"
	})
    v294()
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
			v46,
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
			v46,
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
			v46,
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
			v46,
			"mTool"
		},
		"M-Tool"
	})
    MainFarm2:AddDropdown({
		"Select Skills",
		t55[1],
		t55[2],
		{
			v46,
			"MasterySkills"
		},
		"M-Skills",
		MultiSelect = true
	})
    Toggle(MainFarm2, { "Auto Farm Mastery" }, "Mastery")
    local Sea3 = v276.Sea
    if Sea == 1 then
        Sea3:Destroy()
    elseif Sea == 2 then
        local t57 = {
			{
				"Sea Beast",
				"PirateBrigade"
			},
			CreateDictionary({ "Sea Beast" }, true)
		}
        local t58 = {
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
				v46,
				"autoDriveBoat"
			},
			"A-TweenBoat"
		})
        Sea3:AddSection("Farm Select")
        Sea3:AddDropdown({
			"Enemies",
			t57[1],
			t57[2],
			{
				v46,
				"seaEnemy"
			},
			"S-Enemies",
			MultiSelect = true
		})
        Sea3:AddDropdown({
			"Select Skills",
			t58[1],
			t58[2],
			{
				v46,
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
				v46,
				"BoatSpeed"
			},
			"S-BoatSpeed"
		})
        Sea3:AddToggle({
			"Auto Repair Boat [ BETA ]",
			false,
			{
				v46,
				"RepairBoat"
			},
			"S-RepairBoat"
		})
    elseif Sea == 3 then
        local t59 = {
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
        local t60 = {
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
        local t61 = {
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
				v46,
				"autoDriveBoat"
			},
			"A-TweenBoat"
		})
        Sea3:AddSection("Farm Select")
        Sea3:AddDropdown({
			"Fish",
			t60[1],
			t60[2],
			{
				v46,
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
				v46,
				"boatSelected"
			},
			"S-Boat",
			MultiSelect = true
		})
        Sea3:AddDropdown({
			"Select Skills",
			t59[1],
			t59[2],
			{
				v46,
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
				v46,
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
				v46,
				"BoatSpeed"
			},
			"S-BoatSpeed"
		})
        Sea3:AddToggle({
			"Auto Repair Boat [ BETA ]",
			false,
			{
				v46,
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
				v46,
				"selectedNpc"
			}
		})
        Sea3:AddToggle({
			"Teleport to NPC",
			false,
			function(p209)
            v38.teleporting = p209

            while v38.teleporting do
                task.wait()

                if v46.selectedNpc then
                    MoveCharacter(t61[v46.selectedNpc])
                end
            end

            if p209 and nil then
                (nil):Set(false, true)
            end
        end
		}):Callback(function(p210)
            if p210 then
                local TweenManager = p206.Managers.TweenManager
                local huge = math.huge

                if v38.teleporting then
                    if not (huge < 15) then
                    end
                end

                repeat
                    task.wait()

                    if TweenManager:GetLastPosition() then
                        local v890 = LocalPlayer
                        local t62 = { TweenManager:GetLastPosition() }

                        huge = v890:DistanceFromCharacter(v1(t62))
                    end
                until not v38.teleporting or huge < 15

                v38.teleporting = false
            end
        end)
        Sea3:AddSection("Quests/Items")
        Toggle(Sea3, { "Auto Unlock Shipwright Subclass [ BETA ]" }, "Shipwright")
        Toggle(Sea3, { "Auto Shark Anchor" }, "SharkAnchor")
    end
    local Stats = v276.Stats
    if Level.Value < u55.GameData.MaxLevel then
        local t63 = {}
        local Points = Data:WaitForChild("Points")
        local Stats2 = Data:WaitForChild("Stats")

        Stats:AddSlider({
			"Points Amount",
			1,
			100,
			1,
			3,
			{
				v46,
				"StatsPoints"
			},
			"P-Stats"
		})
        Stats:AddToggle({
			"Auto Stats",
			false,
			function(p211)
            v38.AutoStats = p211

            while task.wait() and v38.AutoStats do
                local PointsValue = Points.Value

                if PointsValue > 0 then
                    for k, v in pairs(t63) do
                        local v898 = k

                        if v and Stats2[v898].Level.Value < u55.GameData.MaxLevel then
                            local v899 = math.clamp(math.clamp(v46.StatsPoints or 3, 0, PointsValue), 0, u55.GameData.MaxLevel)

                            FireRemote("AddPoint", v898, v899)
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
		}, function(_, p213)
            Stats:AddToggle({
				p213,
				false,
				{
					t63,
					p213
				},
				"Stats-" .. p213
			})
        end)
    else
        Stats:Destroy()
    end
    local Islands = v276.Islands
    if Sea == 3 then
        local function v310(p214, p215)
            local v904 = Islands:AddParagraph({ p214 .. " : not Spawn" })

            if not p215 then
                p215 = string.gsub(p214, " ", "")
            end

            while task.wait() do
                local p215_2 = Map:FindFirstChild(p215)

                if p215_2 then
                    local floor = math.floor
                    local WorldPivotPosition = p215_2.WorldPivot.Position

                    v904:SetTitle(p214 .. " : Spawned | Distance : " .. floor(LocalPlayer:DistanceFromCharacter(WorldPivotPosition) / 5))
                else
                    v904:SetTitle(p214 .. " : not Spawn")
                    Map.ChildAdded:Wait()
                end
            end
        end

        Islands:AddSection("Islands Stats")
        task.spawn(v310, "Mirage Island", "MysticIsland")
        task.spawn(v310, "Kitsune Island")
        task.spawn(v310, "Prehistoric Island")
        Islands:AddSection("Prehistoric Island")
        Toggle(Islands, { "Auto Craft Volcanic Magnet" }, "CraftVolcanicMagnet")
        Toggle(Islands, { "Teleport to Prehistoric Island" }, "GotoVolcano")
        Toggle(Islands, { "Fully Prehistoric Island" }, "FullyVolcano")
        Islands:AddToggle({
			"Ignore Collect Bones [ Fully ]",
			false,
			{
				v46,
				"IgnoreBones"
			},
			"IgnoreBones"
		})
        Islands:AddToggle({
			"Ignore Collect Dragon Egg [ Fully ]",
			false,
			{
				v46,
				"IgnoreEggs"
			},
			"IgnoreEggs"
		})
        Islands:AddToggle({
			"Reset character after Finishing [ Fully ]",
			false,
			{
				v46,
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
				v46,
				"Azure"
			},
			"A-Amount"
		})
        Islands:AddToggle({
			"Auto Trade Azure Ember",
			false,
			function(p216)
            v38.TradeAzure = p216

            while v38.TradeAzure do
                if Lighting:GetAttribute("IsBlueMoon") and not Lighting:GetAttribute("BlueMoonEnded") and Count["Azure Ember"] >= v46.Azure then
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
			function(p217)
            v38.LookMoon = p217

            while v38.LookMoon do
                CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, Lighting:GetMoonDirection() + CurrentCamera.CFrame.Position)
                task.wait()
            end
        end,
			"MirageLookMoon"
		})
    else
        Islands:Destroy()
    end
    local FruitRaid = v276.FruitRaid
    local t64 = {
		"Rocket",
		"Spin",
		"Blade",
		"Spring",
		"Bomb",
		"Smoke",
		"Spike"
	}
    local u312 = true
    local u314
    FruitRaid:AddSection("Fruits")
    FruitRaid:AddToggle({
		"Auto Store Fruits",
		false,
		function(p218)
        v38.auto_store = p218

        while v38.auto_store do
            task.wait(not v46.SmoothMode and 0.2 or 0.3)
            u312 = false

            local v911 = not LocalPlayer:GetAttribute("IslandRaiding")

            if v911 then
                v911 = v38.unstore_common_fruits and u314
            end

            local StorableFruit = FruitManager:GetStorableFruit(v911)

            if StorableFruit then
                FruitManager:StoreFruit(StorableFruit)
                u314 = nil
            else
                u312 = true
            end
        end

        u312 = true
    end,
		"F-AutoStore"
	})
    Toggle(FruitRaid, { "Teleport To Fruits" }, "Fruits")
    FruitRaid:AddToggle({
		"Auto Random Fruit",
		false,
		function(p219)
        v38.random_fruit = p219

        while v38.random_fruit do
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
			u55.RaidList,
			"",
			{
				v46,
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
			function(p220)
            v38.raid_microchip = p220

            while v38.raid_microchip do
                if not u312 then
                    task.wait()
                elseif FruitManager:CanBuyMicrochip() then
                    FireRemote("RaidsNpc", "Select", v46.SelectedChip)
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
			function(p221)
            v38.unstore_common_fruits = p221

            while v38.unstore_common_fruits do
                if FruitManager:CanBuyMicrochip() == -1 and u312 then
                    for i = 1, #t64 do
                        local v915 = t64[i]
                        local v916 = v915 .. "-" .. v915

                        if LocalPlayer.Character:FindFirstChild(v916) or LocalPlayer.Backpack:FindFirstChild(v916) then
                            break
                        end

                        if Count[v916] > 0 then
                            u314 = v915 .. " Fruit"
                            FireRemote("LoadFruit", v916)

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
    local Teleport = v276.Teleport
    local cFrame = CFrame.new(28286, 14897, 103)
    local v317 = ({
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
    local t65 = {
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
        u55:TravelTo(1)
    end,
		Desc = "Main"
	})
    Teleport:AddButton({
		"Teleport to Sea 2",
		function()
        u55:TravelTo(2)
    end,
		Desc = "Dressrosa"
	})
    Teleport:AddButton({
		"Teleport to Sea 3",
		function()
        u55:TravelTo(3)
    end,
		Desc = "Zou"
	})
    Teleport:AddSection("Islands")
    Teleport:AddDropdown({
		"Select Island",
		v317,
		"",
		{
			v38,
			"SelectedIsland"
		}
	})
    Teleport:AddToggle({
		"Teleport to Island",
		false,
		function(p222)
        v38.teleporting = p222

        while v38.teleporting do
            task.wait()

            if t65[v38.SelectedIsland] then
                MoveCharacter(t65[v38.SelectedIsland])
            end
        end

        if p222 and nil then
            (nil):Set(false, true)
        end
    end
	}):Callback(function(p223)
        if p223 then
            local TweenManager = p206.Managers.TweenManager
            local huge = math.huge

            if v38.teleporting then
                if not (huge < 15) then
                end
            end

            repeat
                task.wait()

                if TweenManager:GetLastPosition() then
                    local GetLastPosition = TweenManager.GetLastPosition

                    huge = LocalPlayer:DistanceFromCharacter(GetLastPosition(TweenManager))
                end
            until not v38.teleporting or huge < 15

            v38.teleporting = false
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
    local Status = v276.Status
    local _ = FarmManager.Enemies.Elites
    local IsSpawned = u55.Enemies.IsSpawned
    local timestamp
    local t66 = {
		"ðŸŒ‘",
		"ðŸŒ˜",
		"ðŸŒ—",
		"ðŸŒ–",
		"ðŸŒ•",
		"ðŸŒ”",
		"ðŸŒ“",
		"ðŸŒ’"
	}
    local t67 = {}
    local n9 = 0
    local function v339(p224, p225)
        if p225 ~= false then
            table.insert(t67, {
				Paragraph = Status:AddParagraph({ "" }),
				Function = p224
			})
        end
    end
    v339(function()
        local Progress = u55:GetProgress("EliteProgress", "EliteHunter", "Progress")
        local EnemyByTag = u55.Enemies:GetEnemyByTag("Elite")

        if EnemyByTag then
            local EnemyByTagName = EnemyByTag.Name

            return ("Elite Progress: %i\nElite Hunter: %s %s").format("Elite Progress: %i\nElite Hunter: %s %s", Progress, EnemyByTagName, "ðŸŸ¢")
        end

        local v926 = timestamp

        if v926 then
            v926 = 600 - (tick() - timestamp) >= 0 and t6.GetTimer(600 - (tick() - timestamp) or "00:00")
        end

        local v927 = (v926 or "") .. "ðŸ”´"

        return ("Elite Progress: %i\nElite Hunter: %s").format("Elite Progress: %i\nElite Hunter: %s", Progress, v927)
    end, Sea == 3)
    v339(function()
        local v930 = if not IsSpawned("Cake Prince") then IsSpawned("Dough King") and "Dough King" else "Cake Prince"

        if v930 then
            return ("Katakuri: %s %s").format("Katakuri: %s %s", v930, "ðŸŸ¢")
        end

        local v931 = string.gsub(u55:GetProgress("Katakuri", "CakePrinceSpawner", true), "%D", "")

        return "Katakuri: " .. if v931:len() ~= 0 then v931 else "0"
    end, Sea == 3)
    v339(function()
        if IsSpawned("Tyrant of the Skies") then
            return "Tyrant of the Skies: ðŸŸ¢"
        end

        local TikiOutpost = Map.TikiOutpost
        local n10 = 0

        for i = 1, 4 do
            local v935 = TikiOutpost:FindFirstChild("Eye" .. i, true)

            if v935 and v935.Transparency == 0 then
                n10 += 1
            end
        end

        local v936 = n10 ~= 4 and "ðŸ”´" or "ðŸŸ "

        return ("Tyrant of the Skies: %i/4 %s").format("Tyrant of the Skies: %i/4 %s", n10, v936)
    end, Sea == 3)
    v339(function()
        local Progress = u55:GetProgress("Sword Dealer", "LegendarySwordDealer", "1")

        if type(Progress) == "string" then
            return ("Sword Dealer: %s %s").format("Sword Dealer: %s %s", Progress, "ðŸŸ¢")
        end

        return ("Sword Dealer: %s").format("Sword Dealer: %s", "ðŸ”´")
    end, Sea == 2)
    v339(function()
        local v938, v939 = u55:GetProgress("BaristaCousin", "ColorsDealer", "1")

        if type(v938) == "string" then
            local v940 = not ((v939 or 1) >= 3) and "Rare" or "LEGENDARY"

            return ("Barista Cousin: %s [ %s ] %s").format("Barista Cousin: %s [ %s ] %s", v938, v940, "ðŸŸ¢")
        end

        return "Barista Cousin: ðŸ”´"
    end)
    v339(function()
        local v941 = workspace:FindFirstChild("Fruit ")

        if v941 then
            local RealFruitName = u55:GetRealFruitName(v941)
            local v943 = ("Fruit [ %s-%s ]").format("Fruit [ %s-%s ]", RealFruitName, RealFruitName)

            return ("Devil Fruit: %s %s").format("Devil Fruit: %s %s", v943, "ðŸŸ¢")
        end

        return "Devil Fruit: ðŸ”´"
    end)
    v339(function()
        local t68 = {}

        for i = 1, #t5.Berries do
            local v946 = i

            if v946 % 10 == 0 then
                task.wait(0.1)
            end

            local v947 = t5.Berries[v946]
            local GetAttributes = v947.GetAttributes

            for _, v in pairs(GetAttributes(v947)) do
                table.insert(t68, (string.sub(v, 1, -7)))
            end
        end

        if #t68 > 0 then
            local v951 = #t68
            local v952 = table.concat(t68, ", ")

            return ("Berries: #%i [ %s ] %s").format("Berries: #%i [ %s ] %s", v951, v952, "ðŸŸ¢")
        end

        return "Berries: ðŸ”´"
    end)
    v339(function()
        return "Players: " .. #Players:GetPlayers() .. "/12"
    end)
    v339(function()
        local v953 = #v43
        local v954 = #v42
        local v955 = v46.RunningOption or "Null"
        local RunningMethod = v46.RunningMethod

        return ("Enabled Options: %i/%i\nFarm Status: %s [ %s ]").format("Enabled Options: %i/%i\nFarm Status: %s [ %s ]", v953, v954, v955, RunningMethod or "Null")
    end)
    v339(function()
        local MoonPhase = Lighting:GetAttribute("MoonPhase")
        local ClockTime = Lighting.ClockTime

        if ClockTime >= 6 and ClockTime < 12 then
            MoonPhase += 1
        end

        local v959 = t66[MoonPhase]
        local v960 = ClockTime > 18 or (not (ClockTime < 6) and "ðŸŸ " or "ðŸŸ¢")

        return ("MoonPhase: %s %i/8 %s").format("MoonPhase: %s %i/8 %s", v959, MoonPhase, v960)
    end, Sea == 3)
    local n11 = 1
    local connection
    connection = Stepped:Connect(function()
        if not Status or not Status.Cont then
            return connection:Disconnect()
        end

        local v961 = Sea == 3

        if v961 then
            v961 = n11 == 1 and tick() - n9 >= 1
        end

        if v961 then
            if not Status.Cont.Parent then
                n9 = tick()
            end

            if u55.Enemies:GetEnemyByTag("Elite") then
                timestamp = tick()
            end
        end

        if tick() - n9 >= 1 and Status.Cont.Parent then
            local v962 = t67[n11]

            n11 = if not (n11 >= #t67) then n11 + 1 else 0

            if n11 >= #t67 then
                n9 = tick()
            end

            if v962 and not v962.Updating then
                v962.Updating = true

                local Paragraph = v962.Paragraph
                local t69 = { v962.Function() }

                Paragraph:SetTitle(v1(t69))
                v962.Updating = false
            end
        end
    end)
    local Visual = v276.Visual
    local EspManager = p206.Managers.EspManager
    local SeaManager = p206.Managers.SeaManager
    local t70 = {}
    local color3 = Color3.fromRGB(220, 220, 220)
    local color3_2 = Color3.fromRGB(255, 0, 0)
    local color3_3 = Color3.fromRGB(0, 255, 255)
    local color3_4 = Color3.fromRGB(255, 255, 0)
    local color3_5 = Color3.fromRGB(255, 255, 0)
    local color3_6 = Color3.fromRGB(150, 150, 150)
    local color3_7 = Color3.fromRGB(255, 255, 0)
    local color3_8 = Color3.fromRGB(0, 255, 255)
    local color3_9 = Color3.fromRGB(150, 0, 255)
    local t71 = {
		Chest1 = color3_6,
		Chest2 = color3_7,
		Chest3 = color3_8,
		Other = color3_9
	}
    t70.MyBoat = EspManager.new("MyBoat"):SetEspColor(color3_5):SetCustomEspDisplay(function(p226, p227)
        local Humanoid = p226:FindFirstChild("Humanoid")
        local OriginalMaxHealth = p226:GetAttribute("OriginalMaxHealth")

        return ("My Boat<font color='rgb(170, 170, 0)'> [ %im ]</font>\n<font color='rgb(25, 240, 25)'>[%i/%i]</font>"):format(p227, Humanoid and Humanoid.Value or OriginalMaxHealth, OriginalMaxHealth)
    end):GetInstance(function()
        return select(1, SeaManager:GetMyBoat())
    end)
    t70.Players = EspManager.new("Players"):SetEspColor(color3):SetObjects(Characters):Validator(function(p228)
        return p228 ~= LocalPlayer.Character
    end)
    t70.Islands = EspManager.new("Islands"):SetEspColor(color3_3):SetObjects(Locations):Validator(function(p229)
        return p229.Name ~= "Sea" and string.sub(p229.Name, 1, 6) ~= "Trial "
    end)
    t70.Fruits = EspManager.new("Fruits"):SetEspColor(color3_2):SetObjects(workspace):WaitChildsAdded():Validator(function(p230)
        if p230.Name == "Fruit " then
            local RealFruitName = u55:GetRealFruitName(p230)
            local Fruits = t70.Fruits
            local t72 = { ("Fruit [ %s-%s ]").format("Fruit [ %s-%s ]", RealFruitName, RealFruitName) }

            Fruits:SetInstanceName(p230, v1(t72))
        end

        if string.find(p230.Name, "Fruit") and p230:IsA("Model") then
            return p230.ClassName ~= "Model" or p230.WorldPivot.Position ~= Vector3.zero
        end
    end)
    t70.Flowers = EspManager.new("Flowers"):SetObjects(workspace):WaitChildsAdded():SetEspColor(function(p231)
        return p231.Color
    end):Validator(function(p232)
        return string.sub(p232.Name, 1, 6) == "Flower"
    end)
    t70.Chests = EspManager.new("Chests"):SetObjects(t5.Chests):SetAlwaysValidate():SetEspColor(function(p233)
        return t71[p233.Name] or t71.Other
    end):Validator(function(p234)
        return not p234:GetAttribute("IsDisabled")
    end)
    t70.Berries = EspManager.new("Berries"):SetObjects(t5.Berries):SetAlwaysValidate():SetEspColor(color3_4):Validator(function(p235)
        local v980, v981, v982 = pairs(p235:GetAttributes())
        local v983, v984 = v980(v981, v982)

        if v983 then
            t70.Berries:SetInstanceName(p235, v984)

            return true
        end
    end)
    if not u55:IsBlacklistedExecutor() then
        Visual:AddSection("Aimbot Nearest")
        Visual:AddToggle({
			"Aimbot Gun",
			false,
			{
				v38,
				"AimBot_Gun"
			}
		})
        Visual:AddToggle({
			"Aimbot Tap",
			false,
			{
				v38,
				"AimBot_Tap"
			}
		})
        Visual:AddToggle({
			"Aimbot Skills",
			false,
			{
				v38,
				"AimBot_Skills"
			}
		})
        Visual:AddToggle({
			"Ignore Mobs",
			true,
			{
				v46,
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
				t70.Flowers,
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
				t70.MyBoat,
				"Enabled"
			},
			"Esp-MyBoat"
		})
    end
    Visual:AddToggle({
		"ESP Players",
		false,
		{
			t70.Players,
			"Enabled"
		},
		"Esp-Players"
	})
    Visual:AddToggle({
		"ESP Fruits",
		false,
		{
			t70.Fruits,
			"Enabled"
		},
		"Esp-Fruits"
	})
    Visual:AddToggle({
		"ESP Berries",
		false,
		{
			t70.Berries,
			"Enabled"
		},
		"Esp-Berry"
	})
    Visual:AddToggle({
		"ESP Chests",
		false,
		{
			t70.Chests,
			"Enabled"
		},
		"Esp-Chests"
	})
    Visual:AddToggle({
		"ESP Islands",
		false,
		{
			t70.Islands,
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
        local v985 = LocalPlayer.Backpack:FindFirstChild("Portal-Portal") or LocalPlayer.Character:FindFirstChild("Portal-Portal")

        if v985 then
            local _next = next
            local v987, v988 = getconnections(v985.Activated)

            while true do
                local v989

                v988, v989 = _next(v987, v988)

                if not v988 then
                    break
                end

                if #debug.getupvalues(v989.Function) == 9 then
                    while true do
                        local elapsed = task.wait()

                        if elapsed then
                            elapsed = v985 and v985:IsDescendantOf(game)
                        end

                        if not elapsed then
                            break
                        end

                        debug.setupvalue(v989.Function, 2, 0)
                    end
                end
            end
        end
    end
	})
    local Shop = v276.Shop
    for _, v in ipairs(u55.Shop) do
        Shop:AddSection(v[1])

        for _, v2 in ipairs(v[2]) do
            local v361 = v2
            local v362 = v361[2]

            if type(v361[2]) == "table" then
                function v362()
                    FireRemote(unpack(v361[2]))
                end
            end

            Shop:AddButton({
				v361[1],
				v362
			})
        end
    end
    local Misc = v276.Misc
    local u364
    local function v365(p236, p237)
        for i = #p237, 2, -1 do
            local v994 = p236:NextInteger(1, i)
            local v995 = p237[v994]
            local v996 = p237[i]

            p237[i] = v995
            p237[v994] = v996
        end
    end
    local function v366(p238)
        local v998 = string.reverse(p238)
        local num = tonumber("-" .. string.sub(v998, -2, -1))
        local v1000 = string.sub(v998, 1, -3)
        local t73 = {
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
        local t74 = {
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
        local t75 = {
			8,
			4,
			4,
			4,
			12
		}
        local random = Random.new(num)

        v365(random, t73)
        v365(random, t74)

        for i = 1, #t73 do
            local v1006 = t73[i]
            local v1007 = string.gsub(v1000, t74[i + 10], v1006 .. v1006)

            v1000 = string.gsub(v1007, t74[i], v1006)
        end

        local t76 = {}
        local n12 = 1

        for i = 1, #t75 do
            table.insert(t76, (string.sub(v1000, n12, n12 + t75[i] - 1)))
            n12 += t75[i]
        end

        return string.lower(table.concat(t76, "-"))
    end
    local function v367(p239)
        local v1017 = p239:gsub("\n", ""):gsub("```", ""):gsub("`", "")

        if string.sub(v1017, 1, 5) ~= "redz-" then
            return string.sub(v1017, 6, -1)
        end

        return v366(string.sub(v1017, 6, -1))
    end
    local function v368(p240)
        ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", p240)
    end
    local u369
    local u370
    if IsOwner then
        Misc:AddSection("Executor")
        Misc:AddButton({
			"Execute Clipboard",
			function()
            loadstring((getclipboard or fromclipboard)())()
        end
		})
    end
    if u55.JobIds then
        Misc:AddSection("Join Server")
        Misc:AddTextBox({
			"Input Job Id",
			"1",
			true,
			v368,
			"JobId"
		}).OnChanging = function(p241)
            return v367(p241)
        end
        Misc:AddButton({
			"Join Clipboard",
			function()
            v368((getclipboard or fromclipboard)())
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
			v46,
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
		function(p242)
        v46.FarmPos = Vector3.new(0, p242, 0)
        v46.FarmDistance = p242
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
			v46,
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
			v46,
			"BringDistance"
		},
		"S-BringDistance"
	})
    Misc:AddToggle({
		"Bring Mobs",
		true,
		{
			v46,
			"BringMobs"
		},
		"S-BringMobs"
	})
    Misc:AddToggle({
		"Auto Haki",
		true,
		{
			v46,
			"AutoBuso"
		},
		"S-AutoBuso"
	})
    Misc:AddToggle({
		"Auto Attack",
		true,
		{
			v46,
			"AutoClick"
		},
		"S-AutoClick"
	})
    Misc:AddToggle({
		"Auto Shoot",
		false,
		{
			v46,
			"AutoShoot"
		},
		"S-AutoShoot"
	})
    Misc:AddToggle({
		"Take Quest Debounce",
		false,
		{
			p206.Managers.QuestManager,
			"takeQuestDebounce"
		},
		"S-QuestDenounce",
		Desc = "Wait 75 seconds to take the next mission"
	})
    Misc:AddSection("Codes")
    Misc:AddButton({
		"Redeem all Codes",
		t6.AllCodes
	})
    Misc:AddSection("Server")
    Misc:AddButton({
		"Server Hop",
		function()
        u55:ServerHop()
    end
	})
    Misc:AddButton({
		"Rejoin",
		function()
        u55.Rejoin()
    end
	})
    Misc:AddSection("Team")
    Misc:AddButton({
		"Join Pirates Team",
		t4.Pirates
	})
    Misc:AddButton({
		"Join Marines Team",
		t4.Marines
	})
    Misc:AddSection("Race")
    Misc:AddToggle({
		"Auto Active Race V3",
		false,
		function(p243)
        v38.ActiveRaceV3 = p243

        while v38.ActiveRaceV3 do
            if Data.Race:FindFirstChild("Evolved") then
                Remotes.CommE:FireServer("ActivateAbility")
            else
                Data.Race.ChildAdded:Wait()
            end

            task.wait(not v46.SmoothMode and 1 or 2.5)
        end
    end,
		"S-RaceV3"
	})
    Misc:AddToggle({
		"Auto Active Race V4",
		false,
		function(p244)
        v38.ActiveRaceV4 = p244

        while v38.ActiveRaceV4 do
            local v1012 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local RaceTransformed = v1012:FindFirstChild("RaceTransformed")
            local RaceEnergy = v1012:FindFirstChild("RaceEnergy")

            if RaceEnergy then
                RaceEnergy = RaceEnergy.Value >= 1

                if RaceEnergy then
                    RaceEnergy = RaceTransformed and not RaceTransformed.Value
                end
            end

            if RaceEnergy then
                local v1015 = LocalPlayer.Backpack:FindFirstChild("Awakening") or v1012:FindFirstChild("Awakening")

                if v1015:FindFirstChild("RemoteFunction") then
                    v1015.RemoteFunction:InvokeServer(true)
                end
            end

            task.wait(not v46.SmoothMode and 0.5 or 1)
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
    if not u55:IsBlacklistedExecutor() then
        Misc:AddSection("Local-Player")
        Misc:AddToggle({
			"Enable Speed Hack",
			false,
			function(p245)
            if p245 then
                u55.Hooking:EnableBypass()
            end

            v38.WalkSpeedBypass = p245 and u370 or false
            u369 = p245
        end,
			"M-WalkSpeed:A"
		})
        Misc:AddSlider({
			"Walk Speed",
			10,
			300,
			5,
			150,
			function(p246)
            v38.WalkSpeedBypass = u369 and p246 or false
            u370 = p246
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
			v46,
			"SmoothMode"
		},
		"SmoothFarm",
		Desc = "Reduces calculation speed to improve FPS"
	})
    Misc:AddToggle({
		"Remove Damage",
		false,
		function(p247)
        ReplicatedStorage.Assets.GUI.DamageCounter.Enabled = not p247
    end,
		"M-DamageCounter"
	})
    Misc:AddToggle({
		"Remove Notifications",
		false,
		function(p248)
        LocalPlayer.PlayerGui.Notifications.Enabled = not p248
    end,
		"M-Notifications"
	})
    Misc:AddSection("Others")
    Misc:AddToggle({
		"Walk On Water",
		true,
		function(p249)
        v38.WalkOnWater = p249

        local v1019 = Map:WaitForChild("WaterBase-Plane", 9000000000)
        local v1020 = u364 or v1019.Size
        local vector3 = Vector3.new(v1020.X, 113, v1020.Z)

        u364 = v1020

        while task.wait(0.25) and v38.WalkOnWater do
            if u55.IsAlive(LocalPlayer.Character) and LocalPlayer.Character.Humanoid.Sit then
                v1019.Size = v1020
            else
                v1019.Size = vector3
            end
        end

        v1019.Size = v1020
    end,
		"M-WalkOnWater"
	})
    Misc:AddToggle({
		"Anti AFK",
		true,
		function(p250)
        v38.AntiAFK = p250

        while v38.AntiAFK do
            VirtualUser:CaptureController()

            local v1027 = VirtualUser
            local t77 = { Vector2.new(math.huge, math.huge) }

            v1027:ClickButton1(v1(t77))
            task.wait(600)
        end
    end,
		"M-AntiAFK"
	})
    local Items = v276.Items
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
        Toggle(Items, {
			"Auto Rip Indra",
			"Activates the plates and summons Rip Indra"
		}, "RipIndra")
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
				v46,
				"StartLaw"
			},
			"S-RaidLaw",
			Desc = "Automatically spawns and defeats Law (Order)"
		})
        Items:AddSection("Sword")
        Items:AddToggle({
			"Auto Buy Legendary Sword",
			false,
			function(p251)
            v38.LegendSword = p251

            while task.wait() and v38.LegendSword do
                local v1034 = FireRemote("LegendarySwordDealer", "1")

                if type(v1034) == "string" then
                    if Unlocked[v1034] then
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
			v46,
			"BerryHop"
		},
		"S-BerryHop"
	})
    if Sea ~= 1 then
        Items:AddSection("Aura Color")
        Items:AddToggle({
			"Auto Barista Cousin",
			false,
			function(p252)
            v38.barista_cousin = p252

            while v38.barista_cousin do
                local v1036, _ = FireRemote("ColorsDealer", "1")

                if type(v1036) == "string" then
                    local v1038 = FireRemote("ColorsDealer", "2")

                    if v1038 == 1 or v1038 == 2 then
                        task.wait(250)
                    elseif v1038 == 0 then
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
function t7.StartFarm(_)
    if not v38.loadedFarm then
        v38.loadedFarm = true
        task.spawn(u55.RunFunctions.FarmQueue, v43)
    end
end
function t7.StartFunctions(p254)
    local t78 = {}

    table.clear(v42)
    t78.value1 = {}

    local function v375(p255, p256, p257)
        if p257 ~= false then
            local t79 = {
				Name = p255,
				Function = p256
			}

            t78.value1[p255] = p256
            table.insert(v42, t79)
        end
    end

    t78.value2 = p254.Managers.QuestManager

    local ItemsManager = p254.Managers.ItemsManager

    t78.value3 = p254.Managers.FarmManager
    t78.value4 = p254.Managers.RaidManager
    t78.value5 = p254.Managers.SeaManager
    t78.value6 = p254.Managers.TweenManager
    t78.value7 = u55.GameData.MaxMastery
    t78.value8 = u55.GameData.MaxLevel
    t78.value9 = u55.GameData.Sea
    t78.value10 = u55.IsAlive

    local Inventory = u55.Inventory

    t78.value11 = u55.EquipTool
    t78.value12 = u55.FireRemote
    t78.value13 = Inventory.Unlocked
    t78.value14 = Inventory.Count
    t78.value15 = Inventory.Mastery
    t78.value16 = Inventory.Items
    t78.value17 = u55.Enemies.IsSpawned
    t78.value18 = u55.EnemySpawned
    t78.value19 = u55.EnemyLocations
    t78.value20 = t78.value3.Enemies.Elites
    t78.value21 = t78.value3.Enemies.Bones
    t78.value22 = t78.value3.Enemies.Katakuri
    t78.value23 = t78.value3.Enemies.Ectoplasm
    t78.value24 = t78.value3.attack
    t78.value25 = ItemsManager.CursedDualKatana
    t78.value26 = ItemsManager.DojoTrainer
    t78.value27 = Vector3.yAxis * 3
    t78.value28 = Vector3.yAxis * 5
    t78.value29 = Vector3.yAxis * 50
    t78.value30 = Vector3.yAxis * -10
    t78.value31 = CFrame.new(-1926, 13, 1738)
    t78.value32 = CFrame.new(-5556, 300, -2988)
    t78.value33 = CFrame.new(914, 126, 33100)
    t78.value34 = CFrame.new(-5410, 314, -2628)
    t78.value35 = CFrame.new(-5561, 314, -2663)
    t78.value36 = CFrame.new(-8932.85, 142.87, 6063.31)
    t78.value37 = CFrame.new(1346, 37, -1329)
    t78.value38 = CFrame.new(-2103, 70, -12165)
    t78.value39 = CFrame.new(224, 25, -12771)
    t78.value40 = CFrame.new(3779, 16, -3500)
    t78.value41 = CFrame.new(912, 186, 33591)
    t78.value42 = CFrame.new(-9513, 164, 5786)
    t78.value43 = CFrame.new(-1461, 30, -51)
    t78.value44 = CFrame.new(5864, 1209, 810)
    t78.value45 = CFrame.new(5251, 20, 454)
    t78.value46 = CFrame.new(-7739, 5657, -2289)
    t78.value47 = CFrame.new(-690, 15, 1583)
    t78.value48 = CFrame.new(-26952, 21, 329)
    t78.value49 = CFrame.new(-462, 73, 300)
    t78.value50 = CFrame.new(2289, 15, 808)
    t78.value51 = CFrame.new(-2777, 73, -3570)
    t78.value52 = CFrame.new(-1988, 124, -70)
    t78.value53 = CFrame.new(-12512, 340, -9872)
    t78.value54 = CFrame.new(-12445, 332, -7676)
    t78.value55 = CFrame.new(-16252, 153, 1394)
    t78.value56 = CFrame.new(-16649, 107, 1293)
    t78.value57 = Net:WaitForChild("RF/InteractSubclassQuest")
    Net:WaitForChild("RF/InteractDragonQuest")
    t78.value58 = Net:WaitForChild("RF/StartSubclassQuest")
    t78.value59 = Net:WaitForChild("RF/FruitCustomizerRF")
    Net:WaitForChild("RF/JuiceNetworkRF")
    t78.value60 = Net:WaitForChild("RF/DragonHunter")
    t78.value61 = Net:WaitForChild("RF/ClaimBerry")

    local t80 = {
		__index = function(p258, p259)
        rawset(p258, p259, NPCs:FindFirstChild(p259) or ReplicatedStorage.NPCs:FindFirstChild(p259))

        return (rawget(p258, p259))
    end
	}

    t78.value62 = Net:WaitForChild("RE/TouchKitsuneStatue")
    Net:WaitForChild("RE/CollectBlueEmber")
    Net:WaitForChild("RE/DragonDojoEmber")
    t78.value63 = Remotes:WaitForChild("SubclassNetwork")
    Remotes:WaitForChild("QuestUpdate")
    t78.value64 = setmetatable({}, t80)
    t78.value65 = nil
    t78.value66 = nil
    t78.value67 = nil
    t78.value68 = nil
    t78.value69 = nil
    t78.value70 = nil
    t78.value71 = nil
    t78.value72 = nil
    t78.value73 = nil
    t78.value74 = nil
    t78.value75 = nil
    t78.value76 = nil
    t78.value77 = nil
    t78.value78 = nil
    t78.value79 = nil
    t78.value80 = nil
    t78.value81 = nil
    t78.value82 = 0
    t78.value83 = 0
    t78.value84 = 0
    t78.value85 = 0
    t78.value86 = {
		"Forest Pirate",
		"Mythological Pirate"
	}
    t78.value87 = {
		"Stone",
		"Hydra Leader",
		"Kilo Admiral",
		"Captain Elephant",
		"Beautiful Pirate"
	}
    t78.value88 = {
		"Yama",
		"Tushita"
	}
    t78.value89 = {
		Tushita = "Good",
		Yama = "Evil"
	}
    t78.value90 = -1
    t78.value91 = nil
    t78.value92 = {}
    t78.value93 = {}
    t78.value94 = {
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
    t78.value95 = {
		SegmentVector = Vector3.yAxis * 75,
		Segment = nil
	}

    local t81 = {
		CFrame.new(-13335, 380, -7660),
		CFrame.new(-13138, 380, -7713),
		CFrame.new(-13298, 380, -7876),
		CFrame.new(-13512, 380, -7983),
		CFrame.new(-13632, 380, -7815)
	}
    local t82 = {
		CFrame.new(778, 110, 1129),
		CFrame.new(1018, 110, 1128),
		CFrame.new(1020, 110, 1366),
		CFrame.new(1016, 110, 1115)
	}

    t78.value96 = {
		["Forest Pirate"] = t81,
		["Swan Pirate"] = t82
	}

    local t83 = {
		Tushita = "Good",
		Yama = "Evil"
	}
    local _CFrame = CFrame
    local t84 = {
		Quest = {},
		Frags = -1
	}
    local v384 = _CFrame.new(-710, 382, -11150)
    local cFrame = CFrame.new(-12131, 578, -6707)
    local cFrame20 = CFrame.new(-13350, 332, -7645)
    local t85 = {
		CFrame.new(-12360, 603, -6551),
		CFrame.new(-12331, 603, -6551)
	}

    t78.value97 = {
		Quests = {
			"Yama",
			"Tushita"
		},
		Modes = t83,
		CurrentQuest = t84,
		BoatsDealer = {},
		CakeQueen = v384,
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
		CursedSkeleton = t85,
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

    t78.value98 = {
		RequestQuest = {
			Context = "RequestQuest"
		},
		Check = {
			Context = "Check"
		}
	}

    local v393 = CreateDictionary({ "Sea Beast" }, true)

    t78.value99 = {
		Human = {
			"Orbitus",
			"Diamond",
			"Jeremy"
		},
		Shark = v393
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

    t78.value100 = {
		["Really red"] = "Pure Red",
		Oyster = "Snow White",
		["Hot pink"] = "Winter Sky",
		_hotGreen = brickColor
	}

    local v395 = CreateDictionary({ "Shark" }, true)
    local v396 = CreateDictionary({ "Terrorshark" }, true)
    local self2 = setmetatable({}, {
		__index = function()
        return true
    end
	})
    local t86 = {
		["Fool's Gold"] = 20,
		["Terror Eyes"] = 2,
		["Electric Wings"] = 8,
		["Shark Teeth"] = 10
	}
    local t87 = {
		["Shark Teeth"] = "Shark",
		["Terror Eyes"] = "Terrorshark",
		["Fish Crew Member"] = "Electric Wings"
	}
    local t88 = {
		Terrorshark = v396,
		_Selected = self2,
		Materials = t86,
		Drops = t87
	}

    t78.value101 = {
		Shipwright = v395,
		SharkAnchor = t88
	}

    local function v401()
        if tick() - t78.value82 <= 30 then
            return t78.value75
        end

        t78.value82 = tick()

        local t89 = {
			Context = "GetSkinsInventory"
		}

        t78.value75 = t78.value59:InvokeServer(t89)

        return t78.value75
    end
    local function v402(p260, p261)
        if p260 then
            for i = 1, #p260 do
                p260[i].Name = p261
            end
        end
    end
    local function v403(p262, p263, p264)
        if p263 > Level.Value then
            return
        end

        t78.value76 = t78.value3:GetNpcVectorCFrame(p262)

        if p264 then
            local PrimaryPart = p264.PrimaryPart

            return LocalPlayer:DistanceFromCharacter(PrimaryPart.Position) >= LocalPlayer:DistanceFromCharacter(t78.value76.Position)
        end

        return true
    end
    local function v404(p265)
        if p265 then
            p265 = p265.PrimaryPart and p265.PrimaryPart.Anchored
        end

        return p265
    end
    local function v405()
        if t78.value65 and v404(t78.value65.Parent) then
            return t78.value65
        end
        local IslandModel = Map.Waterfall.IslandModel
        local v1055 = IslandModel:FindFirstChild("Meshes/bambootree", true)
        local v1056
        while v1055 do
            if v404(v1055.Parent) then
                v402(v1056, "Meshes/bambootree")
                t78.value65 = v1055

                return v1055
            end

            v1056 = v1056 or {}
            v1055.Name = "Meshes/notbambootree"
            v1055 = IslandModel:FindFirstChild("Meshes/bambootree", true)
            table.insert(v1056, v1055)
        end
    end
    local function v406()
        if t78.value66 and t78.value17(t78.value66) then
            return t78.value66
        end

        for k, _ in pairs(u55.Bosses) do
            local v1059 = k

            if t78.value17(v1059) then
                t78.value66 = v1059

                return v1059
            end
        end
    end
    local function v407(p266, p267, p268)
        local Quest = p266.Quest
        local v1064 = p268 ~= true

        if v1064 then
            v1064 = not t78.value2:VerifyQuest(p267) and v46.BossQuest
        end

        if v1064 and (Quest and Level.Value >= p266.Level) then
            t78.value2:StartQuest(Quest[1], Quest[3] or 3, Quest[2])

            return "Getting Boss Quest: " .. p267
        end

        local v1065 = t78.value18(p267)

        if v1065 and v1065.PrimaryPart then
            return "Defeating Boss: " .. p267, t78.value24(v1065, true)
        end

        if p266.Position then
            return "Waiting for: " .. p267, MoveCharacter(p266.Position)
        end

        return false
    end
    local function v408()
        t78.value67 = workspace:FindFirstChild("EmberTemplate")
        local v1066
        while t78.value67 do
            if t78.value67.Part.Position.Y > 0 then
                v402(v1066, "EmberTemplate")

                return true
            end

            v1066 = v1066 or {}
            t78.value67.Name = "notEmberTemplate"
            t78.value67 = workspace:FindFirstChild("EmberTemplate")
            table.insert(v1066, t78.value67)
        end
    end

    function t78.value102()
        MoveCharacter(t78.value67.Part.CFrame)

        return "Collecting Ember"
    end
    function t78.value103()
        local v1067 = v405()

        if v1067 then
            if LocalPlayer:DistanceFromCharacter(v1067.Position) >= 5 then
                return MoveCharacter(v1067.CFrame)
            end

            if t78.value13["Skull Guitar"] then
                if VerifyTool("Skull Guitar") then
                    u55.Hooking:SetTarget(Tree)
                    t78.value11("Skull Guitar")
                    u55.FastAttack:ShootInTarget(v1067.Position + t78.value30)

                    return
                end

                t78.value12("LoadItem", "Skull Guitar")

                return
            end

            t78.value11(t78.value5:GetRandomWeapon(), true)
            u55.UseSkills(v1067, v46.SeaSkills)
        end
    end

    local function v409(p269)
        EnableBuso()
        t78.value5:StopMovingBoat()

        if p269.Name == "Leviathan Segment" and p269:FindFirstChild("Head") then
            t78.value11(t78.value5:GetRandomWeapon(), true)
            u55.UseSkills(p269.Head.CFrame + t78.value95.SegmentVector, v46.SeaSkills)

            return true, MoveCharacter(p269.Head.CFrame + t78.value95.SegmentVector)
        end

        if p269:FindFirstChild("Head") then
            local cFrame25 = CFrame.new(p269.Head.Position.X, 60, p269.Head.Position.Z)

            EnableBuso()
            t78.value5:StopMovingBoat()
            t78.value11(t78.value5:GetRandomWeapon(), true)
            u55.UseSkills(cFrame25, v46.SeaSkills)

            return true, MoveCharacter(cFrame25)
        end
    end
    local function v410()
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

        if t78.value14["Alucard Fragment"] == 6 then
            return "FinalQuest"
        end

        if t78.value90 == t78.value14["Alucard Fragment"] then
            return unpack(t78.value91)
        end

        local v1075 = t78.value12("CDKQuest", "Progress")

        for _, v in ipairs(t78.value88) do
            local v1078
            local v1079 = t78.value89[v]
            local v1080 = v1075[v1079]
            local v1081
            if v1080 < -2 then
                v1081 = v
                v1078 = (v1080 + 2) * -1
            elseif v1080 >= 0 and v1080 < 3 then
                t78.value12("CDKQuest", "StartTrial", v1079)
                v1081 = v
                v1078 = v1080 + 1
            end
            if v1081 then
                t78.value90 = t78.value14["Alucard Fragment"]
                t78.value91 = {
					v1081,
					v1078
				}

                return v1081, v1078
            end
        end
    end
    local function v411()
        local ClosestByTag = u55.Enemies:GetClosestByTag("CakePrince")

        if not t78.value2:VerifyQuest(t78.value22[1]) and v403("Cake Quest Giver 2", 2275, ClosestByTag) then
            t78.value2:StartQuest("CakeQuest2", 2, t78.value76)
        elseif ClosestByTag and ClosestByTag.PrimaryPart then
            t78.value24(ClosestByTag, true, true)
        else
            MoveCharacter(t78.value38)
        end

        return true
    end
    local function v412()
        local v1083 = v401()
        local _hotGreen = t78.value100._hotGreen
        local value73 = t78.value73

        if not value73 then
            value73 = Map["Boat Castle"].Summoner.Circle:GetChildren()
        end

        t78.value73 = value73

        for i = 1, #t78.value73 do
            local v1087 = t78.value73[i]

            if not v1087:IsA("BasePart") then
                continue
            end

            local BrickColorName = v1087.BrickColor.Name
            local v1089 = t78.value100[BrickColorName]

            if not v1083[v1089] then
                return false
            end

            if _hotGreen ~= v1087.Part.BrickColor then
                if LocalPlayer:DistanceFromCharacter(v1087.Position) <= 3 then
                    local CFrame2 = v1087.CFrame

                    MoveCharacter(CFrame2 + t78.value28)
                    t78.value59:InvokeServer({
						StorageName = v1089,
						Type = "AuraSkin",
						Context = "Equip"
					})
                else
                    MoveCharacter(v1087.CFrame)
                end

                return 1
            end
        end

        return 2
    end
    local function v413()
        if v404(t78.value71) then
            return true
        end

        for _, child in ipairs(Map.TikiOutpost:FindFirstChild("EagleBossArena", true):GetChildren()) do
            if child.Name == "Tree" and v404(child) then
                t78.value71 = child

                return true
            end
        end
    end
    local function v414(p270)
        local value78 = t78.value78

        if value78 then
            value78 = t78.value78:IsDescendantOf(p270) and t78.value78.Enabled
        end

        if value78 then
            return t78.value78.Parent
        end

        local GetChildren = p270.GetChildren

        for _, v in ipairs(GetChildren(p270)) do
            local Specs = v:FindFirstChild("Specs", true)

            if Specs and Specs.Enabled then
                t78.value78 = Specs

                return Specs.Parent
            end
        end
    end
    local function v415()
        local SpawnedDragonEggs = Map.PrehistoricIsland:FindFirstChild("SpawnedDragonEggs", true)
        local v1100 = SpawnedDragonEggs and SpawnedDragonEggs:FindFirstChild("DragonEgg")

        if v1100 then
            local ProximityPrompt = v1100:FindFirstChild("ProximityPrompt", true)

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
    local function v416()
        if t78.value14["Dinosaur Bones"] >= 99 then
            return
        end

        local _ = Map.PrehistoricIsland
        local DinoBone = workspace:FindFirstChild("DinoBone")

        if DinoBone and LocalPlayer:DistanceFromCharacter(DinoBone.Position) <= 1500 then
            if LocalPlayer:DistanceFromCharacter(DinoBone.Position) <= 3 then
                MoveCharacter(DinoBone.CFrame + t78.value28)
            else
                MoveCharacter(DinoBone.CFrame)
            end

            return true
        end
    end
    local function v417()
        local v1104 = t78.value18("Lava Golem")

        if v1104 and v1104.PrimaryPart then
            return true, t78.value24(v1104, true)
        end
    end
    local function v418()
        if Fragments.Value >= 1000 then
            t78.value12("BlackbeardReward", "Microchip", "2")

            local timestamp = tick()

            while true do
                local v1106 = not VerifyTool("Microchip")

                if v1106 then
                    v1106 = tick() - timestamp <= 5
                end

                if not v1106 then
                    break
                end

                task.wait()
            end
        end
    end
    local function v419()
        return fireclickdetector(Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    end
    local function v420()
        return fireclickdetector(Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
    end
    local function v421(p271, p272, p273)
        if p272:GetAttribute("IsMinigameActive") then
            if tick() - t78.value83 >= 5 then
                t78.value83 = tick()
                u55:RemoveVolcanoLava()
            end

            if v417() then
                return true
            end

            local v1110 = v414(p273)

            if v1110 then
                if LocalPlayer:DistanceFromCharacter(v1110.Position) < 5 then
                    t78.value11(t78.value5:GetRandomWeapon(), true)
                    u55.UseSkills(v1110, v46.SeaSkills)
                else
                    MoveCharacter(v1110.CFrame, false, false, true)
                end

                return true
            end

            if v1110 then
                return true, MoveCharacter(v1110.CFrame, false, false, true)
            end
        elseif LocalPlayer:GetAttribute("PrehistoricIslandParticipant") then
            local v1111 = p271 or not v46.IgnoreEggs and v415()

            if not v1111 then
                v1111 = p271 or not v46.IgnoreBones and v416()
            end

            if v1111 then
                return true
            end
        end
    end
    local function v422(p274, p275)
        if p275 then
            local ProximityPrompt = p274:FindFirstChild("ProximityPrompt", true)

            if LocalPlayer:DistanceFromCharacter(p275.Position) <= 5 and ProximityPrompt then
                fireproximityprompt(ProximityPrompt)

                return
            end

            MoveCharacter(p275.CFrame)
        end
    end
    local function v423(p276)
        if p276 then
            for _, child in ipairs(p276:GetChildren()) do
                local v1118 = v422
                local v1119 = child:IsA("Model")

                if v1119 then
                    v1119 = child.PrimaryPart or child:FindFirstChildOfClass("MeshPart")
                end

                if v1118(child, v1119) then
                    return "Collecting Fire Flower"
                end
            end
        end

        local v1120 = t78.value18(t78.value86)

        if v1120 and v1120.PrimaryPart then
            t78.value24(v1120, true)
        else
            t78.value6:TweenToCFrameQueue(t78.value96["Forest Pirate"])
        end

        return true
    end
    local function v424(p277, _)
        local v1123 = not (p277 < 350) and "Yama" or "Tushita"

        if VerifyTool(v1123) then
            t78.value11(v1123)
            t78.value3.ToolDebounce()

            local v1124 = v48.PirateRaid and t78.value1.PirateRaid()

            if not v1124 then
                v1124 = v48.Fruits and t78.value1.Fruits()

                if not v1124 then
                    v1124 = v48.EliteHunter and t78.value1.EliteHunter() or t78.value1.Bones()
                end
            end

            return v1124
        end

        t78.value12("LoadItem", v1123)

        return "Getting 350 in: " .. v1123
    end
    local function v425(p279)
        local v1126 = t78.value12("CDKQuest", "OpenDoor")
        local v1127 = v1126 == "opened"

        if not v1127 then
            v1127 = v1126 == "can" and t78.value12("CDKQuest", "OpenDoor", true)
        end

        if v1127 then
            local FindFirstChild = p279.FindFirstChild

            t78.value80 = true

            if FindFirstChild(p279, "Breakable") then
                p279.Breakable:Destroy()
            end
        end
    end
    local function v426()
        local value81 = t78.value81

        if value81 then
            value81 = t78.value81:IsDescendantOf(Map)
        end

        if value81 then
            return t78.value81.Transparency ~= 1
        end

        for _, child in ipairs(Map.MysticIsland:GetChildren()) do
            if child:IsA("MeshPart") and child.MeshId == "rbxassetid://10153114969" then
                t78.value81 = child

                return child.Transparency ~= 1
            end
        end
    end
    local function v427()
        if HighestPoint and HighestPoint:IsDescendantOf(Map) then
            return HighestPoint
        end

        HighestPoint = Map.MysticIsland:FindFirstChild("dbz_map1_Cube.012", true)

        return HighestPoint
    end

    v375("Tushita", function()
        if t78.value13.Tushita then
            if t78.value17("rip_indra True Form") then
                local v1068 = t78.value18("rip_indra True Form")

                if v1068 and v1068.PrimaryPart then
                    t78.value24(v1068)
                else
                    MoveCharacter(t78.value34)
                end

                return true
            end

            return nil
        end

        local Progress = u55:GetProgress("Tushita", "TushitaProgress")

        t78.value68 = t78.value68 or Progress.OpenedDoor

        if t78.value68 then
            if t78.value17("Longma") then
                return v407(u55.Bosses.Longma, "Longma")
            end

            return nil
        end

        if VerifyTool("Holy Torch") then
            for i = 1, #Progress.Torches do
                local v1071 = i

                if not Progress.Torches[v1071] then
                    t78.value12("TushitaProgress", "Torch", v1071)
                end
            end

            return true
        end

        if t78.value17("rip_indra True Form") then
            local new = CFrame.new

            MoveCharacter(new(5713, 38, 255))

            return true
        end

        return not v48.EliteHunter and t78.value1.EliteHunter()
    end, t78.value9 == 3)
    v375("Darkbeard", function()
        if t78.value17("Darkbeard") then
            local v1132 = t78.value18("Darkbeard")

            if v1132 and v1132.PrimaryPart then
                t78.value24(v1132)
            else
                MoveCharacter(t78.value40)
            end

            return true
        end

        if VerifyTool("Fist of Darkness") then
            t78.value11("Fist of Darkness")

            local value40 = t78.value40

            MoveCharacter(value40)

            return true
        end
    end, t78.value9 == 2)
    v375("CursedCaptain", function()
        if t78.value17("Cursed Captain") then
            local v1134 = t78.value18("Cursed Captain")

            if v1134 and v1134.PrimaryPart then
                t78.value24(v1134)
            else
                MoveCharacter(t78.value41)
            end

            return true
        end
    end, t78.value9 == 2)
    v375("Factory", function()
        local v1135 = Enemies:FindFirstChild("Core") or ReplicatedStorage:FindFirstChild("Core")

        if v1135 and (t78.value10(v1135) and v1135.PrimaryPart) then
            return "Defeating Factory", t78.value3.GotoTargetCFrame(v1135.PrimaryPart.CFrame)
        end
    end, t78.value9 == 2)
    v375("CursedDualKatana", function()
        if t78.value13["Cursed Dual Katana"] then
            return
        end

        if not t78.value13.Tushita then
            return t78.value1.Tushita()
        end

        if not t78.value13.Yama then
            return t78.value1.Yama() or t78.value1.EliteHunter()
        end

        local Tushita = t78.value15.Tushita
        local Yama = t78.value15.Yama

        if Tushita >= 350 and Yama >= 350 then
            if not t78.value80 then
                return v425(Map.Turtle.Cursed)
            end

            local v1138, v1139 = v410()

            if v1138 then
                if v1139 then
                    if t78.value25[v1138][v1139](t78.value97, t78.value1) then
                        return v1138 .. v1139
                    end
                elseif t78.value25[v1138](t78.value97, t78.value1) then
                    return v1138
                end
            end

            return
        end

        return v424(Tushita, Yama)
    end, t78.value9 == 3)

    local v428 = t78.value9 == 2

    if not v428 then
        v428 = t78.value9 == 3
    end

    v375("Raid", function()
        local v1140 = Locations:FindFirstChild("l'Ã‰glise de ProphÃ©tie")

        if v1140 and LocalPlayer:DistanceFromCharacter(v1140.Position) <= 150 then
            local v1141 = t78.value12("Awakener", "Check")

            if type(v1141) == "table" then
                if Fragments.Value < (v1141.Cost or 0) then
                    return true, t78.value12("Awakener", "Teleport")
                end

                t78.value12("Awakener", "Awaken")
                t78.value12("Awakener", "Teleport")
            elseif v1141 ~= 0 then
                return true, t78.value12("Awakener", "Teleport")
            end
        end

        if t78.value4:IsRaiding() then
            local RaidIsland = u55:GetRaidIsland()

            if RaidIsland then
                for _, child in ipairs(Enemies:GetChildren()) do
                    local PrimaryPart = child.PrimaryPart

                    if t78.value10(child) and PrimaryPart and ((RaidIsland.Position - PrimaryPart.Position).Magnitude <= 1000 and PrimaryPart.Position.Y > 0) then
                        return true, t78.value24(child, true, true, v46.FarmMode ~= "Up" and v46.FarmMode or "Star")
                    end
                end

                if LocalPlayer:DistanceFromCharacter(RaidIsland.Position) <= 3000 then
                    MoveCharacter(RaidIsland.CFrame + t78.value29)
                end

                return true
            end

            return true
        end

        if VerifyTool("Special Microchip") then
            return true, t78.value4:start()
        end
    end, v428)
    v375("Leviathan", function()
        if not Map:FindFirstChild("FrozenHeart") then
            local Segment = t78.value95.Segment
            local v1147 = Segment

            if Segment then
                v1147 = t78.value10(Segment) and Segment:GetAttribute("HealthEnabled")
            end

            if v1147 then
                return v409(Segment)
            end

            local children = SeaBeasts:GetChildren()

            for i = 1, #children do
                local v1150 = children[i]

                if v1150.name:find("Leviathan") and (t78.value10(v1150) and v1150:GetAttribute("HealthEnabled")) then
                    t78.value95.Segment = v1150

                    return v409(v1150)
                end
            end
        end
    end, t78.value9 == 3)
    v375("KitsuneIsland", function()
        if Lighting:GetAttribute("BlueMoonEnded") then
            return
        end

        local KitsuneIsland = Map:FindFirstChild("KitsuneIsland")

        if KitsuneIsland and Lighting:GetAttribute("MoonPhase") == 5 then
            if v408() then
                return t78.value102()
            end

            local ShrineDialogPart = KitsuneIsland:FindFirstChild("ShrineDialogPart")

            if ShrineDialogPart then
                if LocalPlayer:DistanceFromCharacter(ShrineDialogPart.Position) <= 3 then
                    if Lighting:GetAttribute("MoonPhase") == 5 and not Lighting:GetAttribute("IsBlueMoon") then
                        t78.value62:FireServer()
                    end
                else
                    MoveCharacter(ShrineDialogPart.CFrame)
                end
            elseif KitsuneIsland.WorldPivot then
                MoveCharacter(KitsuneIsland.WorldPivot)
            end

            return true
        end
    end, t78.value9 == 3)
    v375("CraftVolcanicMagnet", function()
        if Map:FindFirstChild("PrehistoricIsland") then
            if v48.FullyVolcano or v48.GotoVolcano then
                return false
            end

            if LocalPlayer:GetAttribute("CurrentLocation") == "Prehistoric Island" then
                return false
            end
        elseif tick() - t78.value85 <= 30 then
            return false
        end

        if t78.value13["Volcanic Magnet"] then
            t78.value85 = tick()

            return
        end

        if t78.value14["Scrap Metal"] < 10 then
            return t78.value3:Material("Leather + Scrap Metal")
        end

        if t78.value14["Blaze Ember"] < 15 then
            return t78.value1.DragonHunter()
        end

        if LocalPlayer:DistanceFromCharacter(t78.value44.Position) < 3 then
            t78.value12("CraftItem", "Craft", "Volcanic Magnet")
        else
            MoveCharacter(t78.value44)
        end

        return true
    end, t78.value9 == 3)
    v375("FullyVolcano", function(p280, p281)
        local PrehistoricIsland = Map:FindFirstChild("PrehistoricIsland")

        if PrehistoricIsland then
            local Core = PrehistoricIsland:FindFirstChild("Core")
            local v1157 = Core and Core:FindFirstChild("ActivationPrompt")
            local v1158 = Core and Core:FindFirstChild("VolcanoRocks")

            if v421(p280, PrehistoricIsland, v1158) then
                t78.value84 = tick()

                return true
            end

            if v1157 or PrehistoricIsland:GetAttribute("IsMinigameActive") then
                t78.value84 = tick()
            end

            if v1157 then
                if not PrehistoricIsland:GetAttribute("IsMinigameActive") and LocalPlayer:DistanceFromCharacter(v1157.Position) <= 3 then
                    local WaitForChild = v1157.WaitForChild

                    fireproximityprompt(WaitForChild(v1157, "ProximityPrompt", 9000000000))
                else
                    MoveCharacter(v1157.CFrame)
                end
            else
                local v1160 = Core

                if Core then
                    v1160 = Core:FindFirstChild("PrehistoricRelic") and Core.PrehistoricRelic:FindFirstChild("Skull")
                end

                if v1160 then
                    local v1161 = Core.PrehistoricRelic.Skull.CFrame + Vector3.yAxis * 25

                    MoveCharacter(v1161)

                    if not p281 then
                        p281 = v46.VolcanoReset
                    end

                    if p281 and LocalPlayer:GetAttribute("PrehistoricIslandParticipant") and (tick() - t78.value84 >= 15 and t78.value10(LocalPlayer.Character)) and LocalPlayer:DistanceFromCharacter(v1161.Position) <= 10 then
                        LocalPlayer.Character.Humanoid.Health = 0
                    end
                end
            end

            return true
        end

        if not v48.Sea then
            return t78.value5:DriveBoat("inf")
        end
    end, t78.value9 == 3)
    v375("PirateRaid", function()
        local PirateRaid = u55.Enemies:GetTagged("PirateRaid")

        if #PirateRaid > 0 or tick() - u55.PirateRaid <= 10 then
            for i = 1, #PirateRaid do
                local v1164 = i

                if PirateRaid[v1164].PrimaryPart then
                    return true, t78.value24(PirateRaid[v1164], true, true)
                end
            end

            return true, MoveCharacter(t78.value32)
        end
    end, t78.value9 == 3)
    v375("Fruits", function(p282)
        if not p282 then
            p282 = workspace:FindFirstChild("Fruit ") or workspace:FindFirstChildOfClass("Tool")
        end

        local v1166 = p282

        if p282 then
            v1166 = p282:IsA("Model") or p282:IsA("Tool")
        end

        if v1166 then
            local v1167 = p282:FindFirstChild("Handle") and p282.Handle.CFrame

            if not v1167 and p282:IsA("Model") then
                local Pivot = p282:GetPivot()

                if Pivot.Position ~= Vector3.zero then
                    v1167 = Pivot
                end
            end

            if v1167 then
                if LocalPlayer:DistanceFromCharacter(v1167.Position) <= 2 then
                    MoveCharacter(v1167 + t78.value27)
                else
                    MoveCharacter(v1167)
                end

                return true
            end
        end
    end)
    v375("DracoV2V3", function()
        local v1169 = t78.value26:EvoDracoRace(t78.value1)

        if v1169 == "FireFlowers" then
            return v423(workspace:FindFirstChild("FireFlowers"))
        end

        return v1169
    end, t78.value9 == 3)
    v375("DojoTrainer", function()
        local v1170 = t78.value92["Dragon Talon"]

        if not v1170 or v1170 < 500 then
            if not VerifyTool("Dragon Talon") then
                t78.value12("BuyDragonTalon")
            else
                if v1170 then
                    t78.value92["Dragon Talon"] = GetToolMastery("Dragon Talon")
                    t78.value11("Dragon Talon")
                    t78.value3.ToolDebounce()

                    return t78.value1.Bones()
                end

                t78.value92["Dragon Talon"] = GetToolMastery("Dragon Talon")
            end

            return true
        end

        return t78.value26:Train(t78.value1)
    end, t78.value9 == 3)
    v375("DragonHunter", function()
        if t78.value77 == "Locked" then
            return
        end

        if v408() then
            return t78.value102()
        end

        if not t78.value77 or not t78.value77.Text then
            if LocalPlayer:DistanceFromCharacter(t78.value44.Position) < 5 then
                t78.value77 = t78.value60:InvokeServer(t78.value98.Check)

                if t78.value77 and not t78.value77.Text then
                    pcall(t78.value60.InvokeServer, t78.value60, t78.value98.RequestQuest)
                end
            else
                MoveCharacter(t78.value44)
            end

            return "Getting Dragon Hunter Quest"
        end

        local value77Text = t78.value77.Text

        if value77Text:find("Defeat") then
            local v1172 = not value77Text:find("Venomous") and "Hydra Enforcer" or "Venomous Assailant"
            local v1173 = t78.value18(v1172)
            local v1174 = t78.value19[v1172]

            if v1173 and v1173.PrimaryPart then
                t78.value24(v1173, true)
            elseif v1174 then
                t78.value6:TweenToCFrameQueue(v1174)
            end

            return "Killing: " .. v1172
        end

        if value77Text:find("Destroy") then
            t78.value103()

            return "Breaking Hydra Island Tree's"
        end
    end, t78.value9 == 3)
    v375("MirageFruitDealer", function()
        if Map:FindFirstChild("MysticIsland") then
            local v1175 = t78.value64["Advanced Fruit Dealer"]

            if v1175 and v1175.PrimaryPart then
                return true, MoveCharacter(v1175.PrimaryPart.CFrame)
            end
        end
    end, t78.value9 == 3)
    v375("MirageGear", function()
        if Map:FindFirstChild("MysticIsland") and v426() then
            local value81CFrame = t78.value81.CFrame

            MoveCharacter(value81CFrame)

            return true
        end
    end, t78.value9 == 3)
    v375("MirageChests", function()
        if Map:FindFirstChild("MysticIsland") then
            return t78.value1.ChestTween(" from Mirage Island", Map.MysticIsland)
        end
    end, t78.value9 == 3)
    v375("TeleportMirage", function()
        if Map:FindFirstChild("MysticIsland") and v427() then
            local v1177 = HighestPoint.CFrame + Vector3.yAxis * 211.8

            MoveCharacter(v1177)

            return true
        end
    end, t78.value9 == 3)
    v375("GotoVolcano", function()
        if Map:FindFirstChild("PrehistoricIsland") then
            local Core = Map.PrehistoricIsland:FindFirstChild("Core")
            local v1179 = Core and Core:FindFirstChild("ActivationPrompt")

            if v1179 then
                return true, MoveCharacter(v1179.CFrame)
            end

            local v1180 = Core

            if Core then
                v1180 = Core:FindFirstChild("PrehistoricRelic") and Core.PrehistoricRelic:FindFirstChild("Skull")
            end

            if v1180 then
                return true, MoveCharacter(Core.PrehistoricRelic.Skull.CFrame + Vector3.yAxis * 25)
            end
        end
    end, t78.value9 == 3)
    v375("Shipwright", function()
        if Subclass.Value == "Shipwright" then
            return nil
        end

        local v1181, v1182 = t78.value57:InvokeServer("Shipwright")

        if v1181 == 1 then
            t78.value58:InvokeServer("Shipwright")

            return
        end

        if v1181 == 3 then
            if (tonumber(v1182) or 0) < 20 then
                return t78.value1.Sea(t78.value101.Shipwright)
            end
        elseif v1181 == 4 or v1181 == 2 then
            if t78.value63.GetPlayerData:InvokeServer().Purchased.Shipwright ~= nil then
                t78.value63.EquipSubclass:InvokeServer("Shipwright")

                return
            end

            if Fragments.Value >= 3000 then
                t78.value63.PurchaseSubclass:InvokeServer("Shipwright")
            end
        end
    end, t78.value9 == 3)
    v375("RaceV2", function()
        local v1183 = Data.Race.Value == "Draco"

        if not v1183 then
            v1183 = not t78.value13["Warrior Helmet"] or Data.Race:FindFirstChild("Evolved")
        end

        if v1183 then
            return nil
        end

        local Progress = u55:GetProgress("RaceV2", "Alchemist", "1")

        if Progress == 0 or Progress == 2 then
            if Progress ~= 2 or Beli.Value >= 500000 then
                if LocalPlayer:DistanceFromCharacter(t78.value51.Position) < 5 then
                    t78.value12("Alchemist", Progress ~= 0 and "3" or "2")
                else
                    MoveCharacter(t78.value51)
                end

                return true
            end
        elseif Progress == 1 then
            for i = 1, 2 do
                local v1186 = i
                local v1187 = workspace:FindFirstChild("Flower" .. v1186)
                local v1188 = v1187

                if v1187 then
                    v1188 = v1187.Transparency ~= 1 and not VerifyTool("Flower " .. v1186)
                end

                if v1188 then
                    return "Collecting Flower: " .. v1186, MoveCharacter(v1187.CFrame)
                end
            end

            if not VerifyTool("Flower 3") then
                local v1189 = t78.value18("Swan Pirate")

                if v1189 and v1189.PrimaryPart then
                    t78.value24(v1189)
                else
                    t78.value6:TweenToCFrameQueue(t78.value96["Swan Pirate"])
                end

                return "Getting Flower: 3"
            end
        end
    end, t78.value9 == 2)
    v375("RaceV3", function()
        local RaceValue = Data.Race.Value
        local v1191 = RaceValue == "Draco"

        if not v1191 then
            v1191 = not Data.Race:FindFirstChild("Evolved")

            if not v1191 then
                v1191 = t78.value93.RaceV3 and t78.value93.RaceV3[RaceValue]
            end
        end

        if v1191 then
            return nil
        end

        local Progress = u55:GetProgress("RaceV3", "Wenlocktoad", "1")

        if Progress == -2 then
            if not t78.value93.RaceV3 then
                t78.value93.RaceV3 = {
					[RaceValue] = true
				}
            else
                t78.value93.RaceV3[RaceValue] = true
            end

            return nil
        end

        if Progress == 0 or Progress == 2 then
            if Progress ~= 2 or Beli.Value >= 2000000 then
                if LocalPlayer:DistanceFromCharacter(t78.value52.Position) < 5 then
                    t78.value12("Wenlocktoad", Progress ~= 0 and "3" or "2")
                else
                    MoveCharacter(t78.value52)
                end

                return true
            end
        elseif Progress == 1 then
            if RaceValue == "Fishman" then
                return t78.value1.Sea(t78.value99.Shark)
            end

            if RaceValue == "Human" then
                for _, v in ipairs(t78.value99.Human) do
                    if t78.value17(v) then
                        return v407(u55.Bosses[v], v)
                    end
                end

                return
            end

            if RaceValue == "Mink" then
                return t78.value1.ChestTween(" for Mink V3")
            end
        end
    end, t78.value9 == 2)
    v375("SharkAnchor", function()
        if t78.value13["Shark Anchor"] then
            return
        end

        local SharkAnchor = t78.value101.SharkAnchor

        if t78.value13["Monster Magnet"] then
            return t78.value1.Sea(SharkAnchor.Terrorshark, false)
        end

        local t90 = {}
        local v1197 = false

        for k, v in pairs(SharkAnchor.Materials) do
            local v1200 = k

            if v > t78.value14[v1200] then
                local v1201 = SharkAnchor.Drops[v1200]

                if v1201 then
                    t90[v1201] = true
                elseif v1200 == "Fool's Gold" then
                    v1197 = SharkAnchor._Selected
                end
            end
        end

        if next(t90) then
            return t78.value1.Sea(t90, v1197)
        end

        t78.value12("CraftItem", "Check", "SharkAnchor")
        t78.value12("CraftItem", "Craft", "SharkAnchor")
    end, t78.value9 == 3)
    v375("Sea", function(p283)
        if not p283 then
            p283 = v46.seaEnemy
        end

        local SeaEvents = t78.value5:GetSeaEvents(t78.value94.SecondSea, p283)

        if SeaEvents then
            return true, t78.value5:attackSeaEvent(SeaEvents)
        end

        if t78.value5:CanRepair() then
            return t78.value5:RepairBoat()
        end

        if v46.autoDriveBoat then
            return t78.value5:DriveBoat()
        end
    end, t78.value9 == 2)
    v375("Sea", function(p284, p285)
        if not p284 then
            p284 = v46.fishSelected
        end

        local v1206 = p285 ~= false

        if v1206 then
            v1206 = p285 or v46.boatSelected
        end

        local SeaEvents = t78.value5:GetSeaEvents(t78.value94.ThirdSea, p284, v1206)

        if SeaEvents then
            return true, t78.value5:attackSeaEvent(SeaEvents)
        end

        if t78.value5:CanRepair() then
            return t78.value5:RepairBoat()
        end

        if v46.autoDriveBoat then
            return t78.value5:DriveBoat()
        end
    end, t78.value9 == 3)
    v375("Rengoku", function()
        local Rengoku = t78.value13.Rengoku

        if not Rengoku then
            Rengoku = v48.Level and Level.Value < 1350
        end

        if Rengoku then
            return nil
        end

        if VerifyTool("Library Key") then
            return t78.value12("OpenLibrary")
        end

        if VerifyTool("Hidden Key") then
            return t78.value12("OpenRengoku")
        end

        if t78.value17("Awakened Ice Admiral") then
            return v407(u55.Bosses["Awakened Ice Admiral"], "Awakened Ice Admiral")
        end

        if Level.Value >= 1425 or not v48.Level then
            local v1209 = t78.value18("Arctic Warrior", "Snow Lurker")

            if v1209 and v1209.PrimaryPart then
                t78.value24(v1209)

                return true
            end
        end
    end, t78.value9 == 2)
    v375("Bartilo", function()
        if Level.Value < 850 or t78.value13["Warrior Helmet"] then
            return nil
        end

        local Progress = u55:GetProgress("Bartilo", "BartiloQuestProgress")

        if Progress.KilledSpring then
            t78.value12("BartiloQuestProgress", "DidPlates")

            return
        end

        if Progress.KilledBandits then
            if t78.value17("Jeremy") then
                local v1211 = t78.value18("Jeremy")

                if v1211 and v1211.PrimaryPart then
                    t78.value24(v1211)
                else
                    MoveCharacter(CFrame.new(2316, 449, 787))
                end

                return true
            end
        elseif not Progress.KilledBandits then
            if t78.value2:VerifyQuest("Swan Pirate") and t78.value2:VerifyQuest("50") then
                local v1212 = t78.value18("Swan Pirate")

                if v1212 and v1212.PrimaryPart then
                    t78.value24(v1212)
                else
                    t78.value6:TweenToCFrameQueue(t78.value96["Swan Pirate"])
                end
            else
                t78.value2:StartQuest("BartiloQuest", 1, t78.value49)
            end

            return true
        end
    end, t78.value9 == 2)
    v375("Yama", function()
        if t78.value13.Yama then
            return nil
        end

        if u55:GetProgress("EliteProgress", "EliteHunter", "Progress") >= 30 then
            if LocalPlayer:DistanceFromCharacter(t78.value45.Position) < 5 then
                pcall(v420)
                task.wait(1)
            else
                MoveCharacter(t78.value45)
            end

            return true
        end
    end, t78.value9 == 3)
    v375("Citizen", function()
        if Level.Value < 1800 or t78.value13["Musketeer Hat"] then
            return nil
        end

        local Progress = u55:GetProgress("Citizen", "CitizenQuestProgress")
        local NpcVectorCFrame = t78.value3:GetNpcVectorCFrame("Citizen")

        if Progress.KilledBoss then
            return true, MoveCharacter(t78.value53)
        end

        if Progress.KilledBandits then
            if t78.value17("Captain Elephant") then
                if not t78.value2:VerifyQuest("Captain Elephant") then
                    if LocalPlayer:DistanceFromCharacter(NpcVectorCFrame.Position) >= 5 then
                        t78.value12("CitizenQuestProgress", "Citizen")
                    else
                        MoveCharacter(NpcVectorCFrame)
                    end

                    return true
                end

                local v1215 = t78.value18("Captain Elephant")

                if v1215 and v1215.PrimaryPart then
                    t78.value24(v1215)
                else
                    MoveCharacter(t78.value54)
                end

                return true
            end

            return
        end

        if t78.value2:VerifyQuest("Forest Pirate") and t78.value2:VerifyQuest("50") then
            local v1216 = t78.value18("Forest Pirate")

            if v1216 and v1216.PrimaryPart then
                t78.value24(v1216, true)
            else
                t78.value6:TweenToCFrameQueue(t78.value96["Forest Pirate"])
            end

            return true
        end

        if LocalPlayer:DistanceFromCharacter(NpcVectorCFrame.Position) >= 5 then
            t78.value12("CitizenQuest", 1)
        else
            MoveCharacter(NpcVectorCFrame)
        end

        return true
    end, t78.value9 == 3)
    v375("RainbowHaki", function()
        if t78.value79 then
            return
        end

        local v1217 = t78.value2:VerifyQuest(t78.value87)

        if v1217 then
            if t78.value17(v1217) then
                return v407(u55.Bosses[v1217], v1217, true)
            end
        else
            if t78.value12("HornedMan") ~= 1 then
                t78.value12("HornedMan", "Bet")

                return
            end

            t78.value79 = true
        end
    end, t78.value9 == 3)
    v375("EliteHunter", function()
        local v1218 = t78.value2:VerifyQuest(t78.value20)
        local DoughKing = v48.DoughKing

        if not DoughKing then
            DoughKing = v48.CakePrince or v48.RipIndra
        end

        if DoughKing then
            DoughKing = t78.value17("rip_indra True Form")

            if not DoughKing then
                DoughKing = t78.value17("Dough King") or t78.value17("Cake Prince")
            end

            if not DoughKing then
                DoughKing = VerifyTool("God's Chalice") or VerifyTool("Sweet Chalice")
            end
        end

        if DoughKing then
            return nil
        end

        if v1218 then
            local v1220 = t78.value18(v1218)

            if v1220 and v1220.PrimaryPart then
                return "Killing Elite Hunter: " .. v1218, t78.value24(v1220)
            end
        else
            local EnemyByTag = u55.Enemies:GetEnemyByTag("Elite")

            if EnemyByTag then
                local NpcVectorCFrame = t78.value3:GetNpcVectorCFrame("Elite Hunter")

                MoveCharacter(NpcVectorCFrame)
                t78.value6:InteractWithNpc(NpcVectorCFrame, "EliteHunter")

                return "Getting Elite Quest: " .. EnemyByTag.Name
            end
        end
    end, t78.value9 == 3)
    v375("BerryBush", function(p286, p287)
        local v1225 = u55.Berry(p286)

        if v1225 and v1225.Parent then
            local v1226, v1227, v1228 = pairs(v1225:GetAttributes())
            local v1229, v1230 = v1226(v1227, v1228)

            if v1229 then
                local Parent = v1225.Parent
                local GetAttribute = Parent.GetAttribute
                local v1233 = Parent:GetPivot() * GetAttribute(Parent, v1229)

                if LocalPlayer:DistanceFromCharacter(v1233.Position) < 3 then
                    t78.value61:InvokeServer(Parent.Name, v1229)
                else
                    MoveCharacter(v1233)
                end

                return "Collecting Berry: " .. v1230
            end
        else
            if not p287 then
                p287 = p287 == nil and v46.BerryHop
            end

            if p287 then
                u55:ServerHop()
            end
        end
    end)
    v375("ThirdSea", function()
        if Level.Value < 1500 or Level.Value >= 1850 then
            return nil
        end

        local Progress = u55:GetProgress("Zou1", "ZQuestProgress")

        if not t78.value93.Zou2 and not u55:GetProgress("Zou2", "ZQuestProgress", "Check") then
            if u55:GetProgress("Unlockables", "GetUnlockables").FlamingoAccess then
                return t78.value1.DonSwan()
            end

            return nil
        end

        if not t78.value93.Zou2 then
            t78.value93.Zou2 = true
        end

        if LocalPlayer:DistanceFromCharacter(t78.value48.Position) < 1200 then
            local rip_indra = Enemies:FindFirstChild("rip_indra")
            local v1236 = rip_indra

            if rip_indra then
                v1236 = rip_indra.PrimaryPart and rip_indra.PrimaryPart.Position.Y > 0
            end

            if v1236 then
                t78.value24(rip_indra)
            end

            return true
        end

        if Progress.KilledIndraBoss then
            return u55:TravelTo(3)
        end

        if LocalPlayer:DistanceFromCharacter(t78.value31.Position) < 5 then
            t78.value12("ZQuestProgress", "Begin")
            v38.OnFarm = false

            if not (LocalPlayer:DistanceFromCharacter(t78.value48.Position) < 1200) then
                local _ = v48[v46.RunningOption]
            end

            repeat
                task.wait()
            until LocalPlayer:DistanceFromCharacter(t78.value48.Position) < 1200 or not v48[v46.RunningOption]

            return true
        end

        MoveCharacter(t78.value31)
    end, t78.value9 == 2)
    v375("DonSwan", function()
        if not t78.value13["Warrior Helmet"] then
            return nil
        end

        if t78.value17("Don Swan") then
            local v1238 = t78.value18("Don Swan")

            if v1238 and v1238.PrimaryPart then
                t78.value24(v1238)
            else
                MoveCharacter(t78.value50)
            end

            return true
        end
    end, t78.value9 == 2)
    v375("SecondSea", function()
        if Level.Value < 700 then
            return
        end

        local Progress = u55:GetProgress("Dressrosa", "DressrosaQuestProgress")
        local KilledIceBoss = Progress.KilledIceBoss

        if KilledIceBoss then
            KilledIceBoss = not t78.value13["Warrior Helmet"] and Level.Value < 1250
        end

        if KilledIceBoss then
            return u55:TravelTo(2)
        end

        if not Progress.TalkedDetective then
            t78.value12("DressrosaQuestProgress", "Detective")
        elseif not Progress.UsedKey then
            if not VerifyTool("Key") then
                t78.value12("DressrosaQuestProgress", "Detective")
            end

            t78.value11("Key")
            t78.value12("DressrosaQuestProgress", "UseKey")
        elseif not Progress.KilledIceBoss then
            local v1241 = t78.value18("Ice Admiral")

            if v1241 and v1241.PrimaryPart then
                t78.value24(v1241)
            else
                MoveCharacter(t78.value37)
            end
        end

        return true
    end, t78.value9 == 1)
    v375("Order", function(p288)
        local Order = Enemies:FindFirstChild("Order")

        if t78.value10(Order) and Order.PrimaryPart then
            return "Defeating Law", t78.value24(Order, true)
        end

        if not VerifyTool("Microchip") and not Order then
            return v418()
        end

        if VerifyTool("Microchip") and p288 or v46.StartLaw then
            return pcall(v419)
        end
    end, t78.value9 == 2)
    v375("Saber", function()
        if Level.Value < 200 or t78.value13.Saber then
            return nil
        end

        local Progress = u55:GetProgress("Shanks", "ProQuestProgress")

        if Progress.UsedRelic then
            if t78.value17("Saber Expert") then
                local v1245 = t78.value18("Saber Expert")

                if v1245 and v1245.PrimaryPart then
                    t78.value24(v1245)
                else
                    MoveCharacter(t78.value43)
                end

                return true
            end
        else
            if Progress.KilledMob then
                if VerifyTool("Relic") then
                    t78.value12("ProQuestProgress", "PlaceRelic")
                else
                    t78.value12("ProQuestProgress", "RichSon")
                end

                return true
            end

            if not Progress.UsedCup then
                if Progress.UsedTorch then
                    if VerifyTool("Cup") then
                        t78.value12("ProQuestProgress", "FillCup", LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Cup") or LocalPlayer.Backpack:FindFirstChild("Cup"))
                    else
                        t78.value12("ProQuestProgress", "GetCup")
                    end

                    t78.value12("ProQuestProgress", "SickMan")

                    return true
                end
                local _next = next
                local Plates = Progress.Plates
                local v1248
                repeat
                    local v1249

                    v1248, v1249 = _next(Plates, v1248)

                    if not v1248 then
                        if VerifyTool("Torch") then
                            t78.value12("ProQuestProgress", "DestroyTorch")
                        else
                            t78.value12("ProQuestProgress", "GetTorch")
                        end

                        return true
                    end
                until not v1249
                t78.value12("ProQuestProgress", "Plate", v1248)

                return true
            end

            if not Progress.TalkedSon then
                return t78.value12("ProQuestProgress", "RichSon")
            end

            if t78.value17("Mob Leader") then
                local v1250 = t78.value18("Mob Leader")

                if v1250 and v1250.PrimaryPart then
                    t78.value24(v1250)
                else
                    MoveCharacter(CFrame.new(-2880, 9, 5430))
                end

                return true
            end
        end
    end, t78.value9 == 1)
    v375("PoleV1", function()
        if Level.Value < 450 or t78.value13["Pole (1st Form)"] then
            return
        end

        if t78.value17("Thunder God") then
            local v1251 = t78.value18("Thunder God")

            if v1251 and v1251.PrimaryPart then
                t78.value24(v1251)
            else
                MoveCharacter(t78.value46)
            end

            return true
        end
    end, t78.value9 == 1)
    v375("TheSaw", function()
        if Level.Value < 100 or t78.value13["Shark Saw"] then
            return nil
        end

        if t78.value17("The Saw") then
            local v1252 = t78.value18("The Saw")

            if v1252 and v1252.PrimaryPart then
                t78.value24(v1252)
            else
                MoveCharacter(t78.value47)
            end

            return true
        end
    end, t78.value9 == 1)
    v375("SoulReaper", function()
        local v1253 = t78.value18("Soul Reaper")

        if v1253 and v1253.PrimaryPart then
            t78.value24(v1253)

            return true
        end

        if VerifyTool("Hallow Essence") then
            t78.value11("Hallow Essence")
            MoveCharacter(t78.value36)

            return true
        end
    end, t78.value9 == 3)
    v375("RipIndra", function()
        if t78.value17("rip_indra True Form") then
            local v1254 = t78.value18("rip_indra True Form")

            if v1254 and v1254.PrimaryPart then
                t78.value24(v1254)
            else
                MoveCharacter(t78.value34)
            end

            return "Defeating: rip_indra True Form"
        end

        if VerifyTool("God's Chalice") then
            local v1255 = v412()

            if v1255 == 1 then
                return "Activating Places"
            end

            if v1255 == 2 then
                return "God's Chalice: rip_indra True Form", MoveCharacter(t78.value35)
            end
        end
    end, t78.value9 == 3)
    v375("BossSelected", function()
        local BossSelected = v46.BossSelected

        if BossSelected and t78.value17(BossSelected) then
            return v407(u55.Bosses[BossSelected], BossSelected)
        end
    end)
    v375("AllBosses", function()
        local v1257 = v406()

        if v1257 then
            return v407(u55.Bosses[v1257], v1257)
        end
    end)
    v375("MasterySwords", function()
        local value69 = t78.value69

        if value69 then
            value69 = t78.value70

            if not value69 then
                local value69_2 = t78.value69

                value69 = t78.value15[value69_2] < t78.value7
            end
        end

        if value69 then
            if not VerifyTool(t78.value69) then
                return t78.value12("LoadItem", t78.value69)
            end

            local value69_3 = t78.value69

            t78.value11(value69_3)
            t78.value3.ToolDebounce()

            local TyrantSkies = v48.TyrantSkies

            if not TyrantSkies then
                TyrantSkies = v48.CakePrince

                if not TyrantSkies then
                    TyrantSkies = v48.DoughKing

                    if not TyrantSkies then
                        TyrantSkies = v48.Bones

                        if not TyrantSkies then
                            TyrantSkies = v48.Level or v48.Material
                        end
                    end
                end
            end

            if not TyrantSkies then
                return t78.value1.Bones()
            end
        else
            local v1262
            local n13 = -1
            for k, v in pairs(t78.value16) do
                local v1266 = k
                local v1267 = v.Type == "Sword"

                if v1267 then
                    v1267 = t78.value15[v1266] < t78.value7 and n13 <= v.Rarity
                end

                if v1267 then
                    v1262 = v1266
                    n13 = v.Rarity
                end
            end
            if v1262 then
                t78.value69 = v1262

                return
            end
            t78.value70 = true
        end
    end, t78.value9 == 3)
    v375("TyrantSkies", function()
        local v1268 = t78.value18("Tyrant of the Skies")

        if v1268 then
            local t91 = { t78.value24(v1268, true) }

            return "Defeating Tyrant of the Skies", v1(t91)
        end

        if not t78.value72 then
            t78.value72 = Map.TikiOutpost:FindFirstChild("Eye4", true)

            return false
        end

        if t78.value72.Transparency == 0 then
            if v413() then
                local PrimaryPart = t78.value71.PrimaryPart

                t78.value11(t78.value5:GetRandomWeapon(), true)
                u55.UseSkills(PrimaryPart.CFrame, v46.MasterySkills)

                return "Breaking Breakables", MoveCharacter(PrimaryPart.CFrame)
            end

            return "Waiting Breakables", MoveCharacter(t78.value55)
        end

        local ClosestByTag = u55.Enemies:GetClosestByTag("TyrantSkies")

        if not t78.value2:VerifyQuest("Skull Slayer") and v403("Tiki Quest Giver 3", 2575, ClosestByTag) then
            t78.value2:StartQuest("TikiQuest3", 2, t78.value76)
        elseif ClosestByTag and ClosestByTag.PrimaryPart then
            t78.value24(ClosestByTag, true, true)
        else
            MoveCharacter(t78.value56)
        end

        return "Making Red Eyes"
    end, t78.value9 == 3)
    v375("DoughKing", function()
        local v1272 = t78.value18("Dough King") or t78.value18("Cake Prince")

        if VerifyTool("Red Key") then
            t78.value12("CakeScientist", "Check")

            return true
        end

        if v1272 and v1272.PrimaryPart then
            t78.value24(v1272)

            return true
        end

        if not VerifyTool("Sweet Chalice") and VerifyTool("God's Chalice") then
            if t78.value14["Conjured Cocoa"] < 10 then
                return t78.value3:Material("Conjured Cocoa")
            end

            MoveCharacter(t78.value39)
            t78.value6:InteractWithNpc(t78.value39, "SweetChaliceNpc")

            return true
        end

        return v411()
    end, t78.value9 == 3)
    v375("CakePrince", function()
        if v48.DoughKing then
            return nil
        end

        local v1273 = t78.value18("Dough King") or t78.value18("Cake Prince")

        if v1273 and v1273.PrimaryPart then
            t78.value24(v1273)

            return true
        end

        return v411()
    end, t78.value9 == 3)
    v375("ChestTween", function(p289, p290)
        local v1276 = u55.Chests()

        if v1276 then
            local Pivot = v1276:GetPivot(p290)

            if LocalPlayer:DistanceFromCharacter(Pivot.Position) < 3 then
                local v1278 = Pivot + t78.value28

                MoveCharacter(v1278)
                task.wait(0.15)
            else
                MoveCharacter(Pivot)
            end

            return "Collecting Chest" .. (p289 or "")
        end
    end)
    v375("Ectoplasm", function()
        local v1279 = t78.value18(t78.value23)

        if v1279 and v1279.PrimaryPart then
            return "Killing: " .. v1279.Name, t78.value24(v1279, true, true)
        end

        return "Waiting for: Enemy Spawn", MoveCharacter(t78.value33)
    end, t78.value9 == 2)
    v375("Bones", function()
        if v48.Level and Level.Value < t78.value8 then
            return
        end

        local ClosestByTag = u55.Enemies:GetClosestByTag("Bones")

        if not t78.value2:VerifyQuest(t78.value21[4]) and v403("Haunted Castle Quest Giver 2", 2050, Target) then
            t78.value2:StartQuest("HauntedQuest2", 2, t78.value76)

            return true
        end

        if ClosestByTag and ClosestByTag.PrimaryPart then
            return "Killing: " .. ClosestByTag.Name, t78.value24(ClosestByTag, true, true)
        end

        local t92 = { MoveCharacter(t78.value42) }

        return "Waiting for: Enemy Spawn", v1(t92)
    end, t78.value9 == 3)
    v375("Level", function()
        local Quest = t78.value2:GetQuest()

        if not Quest then
            return nil
        end

        local EnemyName = Quest.Enemy.Name
        local EnemyPosition = Quest.Enemy.Position
        local v1285 = t78.value2:VerifyQuest(EnemyName)

        if v1285 and u55.IsBoss(v1285) then
            return v407(u55.Bosses[v1285], v1285, false)
        end

        if v1285 then
            local v1286 = t78.value18(v1285)

            if v1286 and v1286.PrimaryPart then
                return "Killing: " .. v1286.Name, t78.value24(v1286, true)
            end

            local QuestPosition = t78.value2:GetQuestPosition(Quest.Name)

            if #EnemyPosition > 0 then
                t78.value6:TweenToCFrameQueue(EnemyPosition)
            elseif QuestPosition then
                MoveCharacter(QuestPosition * t78.value2._Position)
            end

            return "Waiting for: " .. v1285
        end

        local value2 = t78.value2
        local QuestName = Quest.Name
        local Count = Quest.Count
        local QuestName2 = Quest.Name
        local t93 = { t78.value2:GetQuestPosition(QuestName2) }

        return value2:StartQuest(QuestName, Count, v1(t93))
    end)
    v375("Mastery", function()
        if t78.value9 == 3 and Level.Value >= t78.value8 then
            return t78.value1.Bones()
        end

        return t78.value1.Level()
    end)
    v375("Material", function()
        if v46.fMaterial then
            return t78.value3:Material(v46.fMaterial)
        end
    end)
    v375("Nearest", function()
        local v1293 = t78.value74 and t78.value74.PrimaryPart
        if v1293 then
            local v1294 = t78.value10(t78.value74)

            if v1294 then
                v1294 = LocalPlayer:DistanceFromCharacter(v1293.Position) < 1500
            end

            v1293 = v1294
        end
        if v1293 then
            return "Killing: " .. t78.value74.Name, t78.value24(t78.value74, true, true)
        end
        local n14 = 1500
        local v1296
        for _, child in ipairs(Enemies:GetChildren()) do
            local PrimaryPart = child.PrimaryPart

            if t78.value10(child) and PrimaryPart then
                local v1300 = LocalPlayer:DistanceFromCharacter(PrimaryPart.Position)

                if v1300 < n14 then
                    n14 = v1300
                    v1296 = child
                end
            end
        end
        if v1296 then
            t78.value74 = v1296
            t78.value24(v1296, true, true)

            return true
        end
        task.wait(0.4)
    end)

    if t78.value9 == 3 then
        local u429 = false

        local function v430()
            t78.value77 = nil
        end

        local t94 = {
			["Obtained <Color=Purple><Mutant Tooth><Color=/> (1x)"] = function()
            t78.value26:UpdateBeltProgress("Red", 1)
        end,
			["<Color=Yellow><QUEST COMPLETED!><Color=/>"] = function()
            t78.value26:UpdateBeltProgress("White", 8)
        end,
			["Head back to the Dojo to complete more tasks."] = v430,
			["Dojo quest abandoned!"] = v430
		}
        local insert = table.insert
        local v433 = v51
        local t95 = { u55.Signals.Notify:Connect(function(p291)
            local v1302 = t94[p291]

            if v1302 then
                return v1302()
            end

            if p291:find("Earned <Color=Green>%$%d+<Color=/>") then
                if LocalPlayer:GetAttribute("DangerLevel") >= 100 then
                    t78.value26:UpdateBeltProgress("Yellow", 1)

                    return
                end

                local v1303 = v48.DoughKing and VerifyTool("Sweet Chalice")

                if not v1303 then
                    v1303 = not VerifyTool("God's Chalice") and v48.CakePrince
                end

                if v1303 and not u429 then
                    u429 = true

                    if string.find(t78.value12("CakePrinceSpawner", true) or "Error", "Do you want to open the portal now?") then
                        t78.value12("CakePrinceSpawner")
                    end

                    CheckingDebounce = false
                end
            end
        end) }

        insert(v433, v1(t95))
    end
end
function t7.Webhooks(_)
    if u55.Webhooks then
        v4.load("{Utils}/BloxFruits/Webhooks.lua")(u55)
    end
end
local function v63(p293, ...)
    local timestamp = tick()

    t7[p293](t7, ...)
    print(p293, tick() - timestamp)
end
v63("Initialize")
v63("StartFarm")
v63("StartFunctions")
task.spawn(v63, "LoadLibrary")
task.spawn(v63, "Webhooks")
