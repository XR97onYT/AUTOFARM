--[[
	XRAF v3
	Created by XR97
	Description: An autofarm that was updated to versions 2 and 1, specifically looking at bypassing the new anti-cheat.
	How It Works: Finds a player, teleports to them, raycasts down to detect if you're looking at a player, shoots, kills, repeat until game ends.
	Then server hop and repeat.
]]

function ServerHop()
	local Servers = {}
	local URL = "https://games.roblox.com/v1/games/286090429/servers/Public?sortOrder=Asc&limit=100"
	
	for index, server in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(URL)).data) do
		if type(server) == "table" and server.playing <= 15 and server.id ~= game.JobId then
			table.insert(Servers, server.id)
		end
	end
	
	if #Servers > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(286090429, Servers[math.random(1, #Servers)])
	end
end

coroutine.resume(coroutine.create(function()
	while true do
		if game:GetService("GuiService"):GetErrorMessage() ~= nil and game:GetService("GuiService"):GetErrorMessage() ~= "" then
			ServerHop()
			break
		end
		wait(1)
	end
end))

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local gmt = getrawmetatable(game)
local index = gmt.__index
setreadonly(gmt, false)

gmt.__index = function(item, property)
	if item == "HumanoidRootPart" or item == "UpperTorso" or item == "LowerTorso" or item == "PrimaryPart" then
		if property == "Position" or property == "Velocity" then
			return Vector3.new(0, 0, 0)
		elseif property == "CFrame" then
			return CFrame.new(0, 0, 0)
		end
	end
	return index(item, property)
end

setreadonly(gmt, true)

mousemoverel(50, 50)
wait(0.5)
mouse1click()

local Farming = false
local Hopped = false
local TimeLeft = 30
local CheckTick = tick()
local PlayerLocked

function DetectPlayer()
	local Blacklist = {workspace.CurrentCamera}
	if game:GetService("Players").LocalPlayer.Character then
		table.insert(Blacklist, game:GetService("Players").LocalPlayer.Character)
	end
	if workspace:FindFirstChild("Map") then
		table.insert(Blacklist, workspace.Map)
	end
	
	local RaycastParam = RaycastParams.new()
	RaycastParam.FilterType = Enum.RaycastFilterType.Blacklist
	RaycastParam.FilterDescendantsInstances = Blacklist
	
	local NewRay = Ray.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0), workspace.CurrentCamera.CFrame.LookVector * 50000, RaycastParam)
	local PlayerGot
	
	if NewRay.Instance then
		if NewRay.Instance:IsDescendantOf(workspace) then
			if NewRay.Instance.Parent:IsA("Model") then
				if game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent) then
					PlayerGot = game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent)
				end
			elseif NewRay.Instance.Parent:IsA("Accessory") then
				if game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent.Parent) then
					PlayerGot = game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent.Parent)
				end
			end
		end
		
		if PlayerGot and PlayerGot.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value and PlayerGot.NRPBS.Health.Value > 0 then
			return true
		end
	end
	
	return false
end

function sayMessage(option)
	if game.Players.LocalPlayer.Status.Team.Value ~= "Spectator" then
		local Message = option
		game.ReplicatedStorage.Events.PlayerChatted:FireServer(Message, false, true, false)
	end
end

function StartAutofarm()
	Farming = true
	
	coroutine.resume(coroutine.create(function()
		wait(2.5)

		game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("TRC")
		game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()

		game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
		game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
		game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
		game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
		game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("TRC")
			game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
		end

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("TBC")
			game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
		end

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("TGC")
			game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
		end

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("TYC")
			game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
		end

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("Random")
			game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
		end
	end))
	
	coroutine.resume(coroutine.create(function()
		repeat
			if game:GetService("Players").LocalPlayer.Status.Team.Value ~= "Spectator" then
				for i,v in pairs(game:GetService("Players"):GetPlayers()) do
					if v ~= game:GetService("Players").LocalPlayer then
						if v.Character then
							if v.NRPBS.Health.Value > 0 then
								if v.Status.Team.Value ~= "Spectator" then
									if v.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value then
										if v.Status.Alive.Value == true then
											TimeLeft = 25
											
											repeat
												PlayerLocked = v
												wait()
											until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value or not v or v.NRPBS.Health.Value <= 0 or not v.Character or v.Status.Team.Value == "Spectator" or v.Status.Alive.Value == false
										end
									end
								end
							end
						end
					end
				end
			end
			wait()
		until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true
		
		wait(5)
		ServerHop()
	end))
end

game:GetService("RunService").RenderStepped:Connect(function()
	if Farming then
		if (tick() - CheckTick) >= 1 then
			TimeLeft = TimeLeft - 1
			
			if TimeLeft <= 0 then
				ServerHop()
			else
				if game:GetService("Players").LocalPlayer.Status.Team.Value ~= "Spectator" then
				    game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
					sayMessage("XR97 HAS NEVER LEFT THIS GAME!")
				end
				
				local Vals = {}
				for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do if v.Name:lower():find("gamemode") then table.insert(Vals, v) end end
				for i,v in pairs(Vals) do if v.Value:lower():find("odd") or v.Value:lower():find("hackula") then if not Hopped then Hopped = true ServerHop() end break end end
				
				CheckTick = tick()
			end
		end
		
		if PlayerLocked and PlayerLocked.Character and PlayerLocked.NRPBS.Health.Value > 0 and PlayerLocked.Character:FindFirstChild("HeadHB") then
			workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, PlayerLocked.Character.HeadHB.Position)
			game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(
				PlayerLocked.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
			)
			mouse1click()
		end
	end
	
	if not game:GetService("Players").LocalPlayer.Character then PlayerLocked = nil end
	if game:GetService("Players").LocalPlayer.NRPBS.Health.Value <= 0 then PlayerLocked = nil end
end)

StartAutofarm()
