--== Sistema de Mensagens ==--
local function Message(Title, Text, Time)
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Time or 5
    })
end

--== Loader ==--
Message("DesplockHub", "Detectando jogo...", 3)

local PlaceId = game.PlaceId

-- Lista dos jogos
local Scripts = {
    -- Ink Game
    [18406536871] = {
        Url = "https://raw.githubusercontent.com/PlockScripts/InkGame-BETA-ACESSE-/refs/heads/main/Plock.lua",
        Nome = "Ink Game"
    },

    -- Blox Fruits
    [2753915549] = {
        Url = "https://raw.githubusercontent.com/PlockScripts/DesplockHub10/refs/heads/main/Plock.lua",
        Nome = "Blox Fruits"
    },
    [4442272183] = {
        Url = "https://raw.githubusercontent.com/PlockScripts/DesplockHub10/refs/heads/main/Plock.lua",
        Nome = "Blox Fruits"
    },
    [7449423635] = {
        Url = "https://raw.githubusercontent.com/PlockScripts/DesplockHub10/refs/heads/main/Plock.lua",
        Nome = "Blox Fruits"
    },
}

task.wait(1)

local GameData = Scripts[PlaceId]

if GameData then
    Message("DesplockHub", "Carregando script de " .. GameData.Nome .. "...", 3)
    loadstring(game:HttpGet(GameData.Url))()
    Message("DesplockHub", "Script de " .. GameData.Nome .. " carregado!", 4)
else
    Message("DesplockHub", "Nenhum script detectado para este jogo.", 3)
    Message("DesplockHub", "Carregando script universal...", 3)

    loadstring(game:HttpGet("https://raw.githubusercontent.com/PlockScripts/DesplockHubUniversal/refs/heads/main/Plock.lua"))()

    Message("DesplockHub", "Script universal carregado!", 4)
end
