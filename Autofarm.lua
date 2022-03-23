--[[
	XRAF v3.3 (Update: Fixed a little thing that bans you :D GOod job XONAE)
	Created by XR97
	Description: An autofarm that was updated to versions 2 and 1, specifically looking at bypassing the new anti-cheat.
	How It Works: Finds a player, teleports behind them, uses mouse.target to detect if you're looking at a player, shoots, kills, repeat until game ends.
	Then server hop and repeat.
]]

function ServerHop()
	local Servers = {}
	local URL = "https://games.roblox.com/v1/games/286090429/servers/Public?limit=100"

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



mousemoveabs(50, 50)
wait(0.5)
mouse1click()

local N = game:GetService("VirtualInputManager")    

local Farming = false
local Hopped = false
local TimeLeft = 30
local TurnBack = 4
local CheckTick = tick()
local Message = getfenv().Message or "YOU CANNOT LOSE. YOU CANNOT WIN. YOU'VE BEEN B0T ROLLED AND THAT IS THE FACT."
local PlayerLocked
local Back = true

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
		game.ReplicatedStorage.Events.PlayerChatted:FireServer("Trolling42", Message, false, false, true)
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

		game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
		game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
		game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
		game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
		game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
		game.Players.LocalPlayer.PlayerGui.MapVoting.MapVote.Visible = false

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("TRC")

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
			game.Players.LocalPlayer.PlayerGui.MapVoting.MapVote.Visible = false
		end

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("TBC")

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
			game.Players.LocalPlayer.PlayerGui.MapVoting.MapVote.Visible = false
		end

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("TGC")

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
			game.Players.LocalPlayer.PlayerGui.MapVoting.MapVote.Visible = false
		end

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("TYC")

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
			game.Players.LocalPlayer.PlayerGui.MapVoting.MapVote.Visible = false
		end

		wait(1.25)

		if game.Players.LocalPlayer.Status.Team.Value == "Spectator" then
			game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer("Random")

			game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false
			game.Players.LocalPlayer.PlayerGui.GUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.BottomFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.GUI.Interface.Visible = true
			game.Players.LocalPlayer.PlayerGui.MapVoting.Enabled = false
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
									if v.Character:FindFirstChild("Spawned") and v.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value then
										TimeLeft = 25
										TurnBack = 4
										Back = true
										repeat
											PlayerLocked = v
											if game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Bow") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Acid") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Launcher") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Water") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Present") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Flaming") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Bomb") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Barrel") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("RPG") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Rocket") or game:GetService("Players").LocalPlayer.NRPBS.EquippedTool.Value:find("Cannon") and v.Character:FindFirstChild("Hitbox") then
												N:SendKeyEvent(true, 51, false, game)
												N:SendKeyEvent(false, 51, false, game)
											end
											wait(.1)
											TurnBack = TurnBack - 0.1
											if TurnBack <= 0 then
												Back = false
											elseif TurnBack <= -4 then
												break
											end
										until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value or not v or not v.Character or not v.Character:FindFirstChild("Spawned") or v.NRPBS.Health.Value <= 0 or v.Status.Team.Value == "Spectator" or v.Status.Alive.Value == false or game:GetService("Players").LocalPlayer.Status.Team.Value == v.Status.Team.Value
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
	end
end)

spawn(function()
	while wait(1) do
		if Farming then
			TimeLeft = TimeLeft - 1

			if TimeLeft <= 0 then
				ServerHop()
				break
			else
				game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
				game.Players.LocalPlayer.PlayerGui.MapVoting.MapVote.Visible = false
				if game:GetService("ReplicatedStorage").wkspc.Status.LastGamemode.Value:lower():find("hackula") then 
					ServerHop() 
					break 
				end
				sayMessage(Message)
			end
		end
	end
end)
local num = 6
local up = 0
game:GetService("RunService").RenderStepped:Connect(function()
	if Farming then
		if workspace:FindFirstChild("Map") and PlayerLocked and PlayerLocked.Character and PlayerLocked.NRPBS.Health.Value > 0 and PlayerLocked.Character:FindFirstChild("HeadHB") then
			workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, PlayerLocked.Character.HeadHB.Position)
			if Back then num = 6 up = 0 else num = -2 up = 4 end
			game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(
				PlayerLocked.Character.HumanoidRootPart.CFrame * CFrame.new(-1.5, up, num)
			)
			
			local RayParams = RaycastParams.new()
			RayParams.FilterType = Enum.RaycastFilterType.Blacklist
			RayParams.FilterDescendantsInstances = {workspace.CurrentCamera, game:GetService("Players").LocalPlayer.Character, workspace.Map.Ignore, workspace.Map.Clips}
				
			local Result = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.LookVector * 10000, RayParams)
			local Player
			
			if Result and Result.Instance then
				if Result.Instance:IsDescendantOf(PlayerLocked.Character) then
					game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				end
			end
		end
	end
	
	if game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true then PlayerLocked = nil end
	if not game:GetService("Players").LocalPlayer.Character then PlayerLocked = nil end
	if game:GetService("Players").LocalPlayer.NRPBS.Health.Value <= 0 then PlayerLocked = nil end
end)

StartAutofarm()
