--[[
	XRAF v3
	Created by XR97
	Description: An autofarm that was updated to versions 2 and 1, specifically looking at bypassing the new anti-cheat.
	How It Works: Finds a player, teleports behind them, uses mouse.target to detect if you're looking at a player, shoots, kills, repeat until game ends.
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

spawn(function()
	while true do
		if game:GetService("GuiService"):GetErrorMessage() ~= nil and game:GetService("GuiService"):GetErrorMessage() ~= "" then
			ServerHop()
			break
		end
		wait(1)
	end
end)

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

mousemoveabs(50, 50)
wait(0.5)
mouse1click()

local Farming = false
local Hopped = false
local TimeLeft = 30
local CheckTick = tick()
local Message = getfenv().Message or "Xonae. Give me purple team on my account Hax892 then I'll stop."
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
	repeat wait() until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == false
	if game:GetService("ReplicatedStorage").wkspc.Status.LastGamemode.Value:lower():find("hackula") then ServerHop() return end
	
	Farming = true
	for i,v in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do if v.Name:lower():find("curse") then v.Value = "Infinite Ammo" end end
	-- lol infinite ammo, didn't feel like making my own script to modify the client's local variables, so I figure why not just use hackula's built in infinite ammo?
	
	spawn(function()
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
	end)

	spawn(function()
		repeat
			if game:GetService("Players").LocalPlayer.Status.Team.Value ~= "Spectator" then
				for i,v in pairs(game:GetService("Players"):GetPlayers()) do
					if v ~= game:GetService("Players").LocalPlayer then
						if v.Character then
							if v.NRPBS.Health.Value > 0 then
								if v.Status.Team.Value ~= "Spectator" then
									if v.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value then
										TimeLeft = 25
										repeat
											PlayerLocked = v
											if game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Bow") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Bomb") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Barrel") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("RPG") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Rocket") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Cannon") and v.Character:FindFirstChild("Hitbox") then game:GetService("ReplicatedStorage").Events.FallDamage:FireServer(100, v.Character.Hitbox) end
											wait(.1)
										until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value or not v or not v.Character or v.NRPBS.Health.Value <= 0 or v.Status.Team.Value == "Spectator" or v.Status.Alive.Value == false or game:GetService("Players").LocalPlayer.Status.Team.Value == v.Status.Team.Value
									end
								end
							end
						end
					end
				end
			end
			wait(1)
		until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true

		wait(5)
		ServerHop()
	end)
end

spawn(function()
	while wait(3) do
		game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		wait(1)
		game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	end
end)

spawn(function()
	while wait(.05) do
		if game:GetService("Players").LocalPlayer.NRPBS.Health.Value <= 0 and game:GetService("Players").LocalPlayer.Status.Team.Value ~= "Spectator" then
			game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()
		end
			
		local args = {
			[1] = {
				[1] = "createparticle",
				[2] = "Blood",
				[3] = game:GetService("ReplicatedStorage").Pilots.AcePilot.Humanoid,
				[4] = Vector3.new(0, 0, 0),
				[5] = Vector3.new(0, 0, 0),
				[6] = game:GetService("ReplicatedStorage").Weapons.Musket,
				[7] = false,
				[8] = false,
				[9] = true,
				[10] = game:GetService("ReplicatedStorage").Sounds.Taunt3
			}
		}
		
		game:GetService("ReplicatedStorage").Events.RemoteEvent:FireServer(unpack(args))
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if Farming then
		if (tick() - CheckTick) >= 1 then
			TimeLeft = TimeLeft - 1

			if TimeLeft <= 0 then
				ServerHop()
			else
				game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
				if game:GetService("ReplicatedStorage").wkspc.Status.LastGamemode.Value:lower():find("hackula") then ServerHop() else sayMessage(Message) CheckTick = tick() end
			end
		end

		if workspace:FindFirstChild("Map") and PlayerLocked and PlayerLocked.Character and PlayerLocked.NRPBS.Health.Value > 0 and PlayerLocked.Character:FindFirstChild("HeadHB") then
			workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, PlayerLocked.Character.HeadHB.Position)
			
			game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(
				PlayerLocked.Character.HumanoidRootPart.CFrame * CFrame.new(1.5, 0, 6)
			)
			
			local RayParams = RaycastParams.new()
			RayParams.FilterType = Enum.RaycastFilterType.Blacklist
			RayParams.FilterDescendantsInstances = {workspace.CurrentCamera, game:GetService("Players").LocalPlayer.Character, workspace.Map.Ignore, workspace.Map.Clips}
				
			local Result = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.LookVector * 10000, RayParams)
			local Player
			
			if Result and Result.Instance then
				if Result.Instance:IsDescendantOf(PlayerLocked.Character) then
					game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				else
					game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				end
			else
				game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			end
		end
	end
	
	if game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true then PlayerLocked = nil end
	if not game:GetService("Players").LocalPlayer.Character then PlayerLocked = nil end
	if game:GetService("Players").LocalPlayer.NRPBS.Health.Value <= 0 then PlayerLocked = nil end
end)

StartAutofarm()
