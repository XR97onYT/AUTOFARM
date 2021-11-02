local Kicked = false

function hopServer()
	local x = {}
	for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/286090429/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v) == "table" and v.playing <= 15 and v.id ~= game.JobId then
			x[#x + 1] = v.id
		end
	end
	if #x > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
	end
end

spawn(function()
	while wait(1) do
		if not Kicked then
			if game:GetService("GuiService"):GetErrorMessage() ~= nil and game:GetService("GuiService"):GetErrorMessage() ~= "" then
				Kicked = true
				hopServer()
			end
		end
	end
end)

if not game:IsLoaded() then
	game.Loaded:Wait()
end

mousemoverel(50, 50)
wait(1)
mouse1click()

local AutofarmOn = false
local Started = false
local Time = 40
local PlayerLockedOn

function sayMessage(option)
	if game.Players.LocalPlayer.Status.Team.Value ~= "Spectator" then
		local Message = option
		game.ReplicatedStorage.Events.PlayerChatted:FireServer(Message, false, true, false)
	end
end

function Autofarm()
	spawn(function()
		repeat
		    wait(1)
			if Started then
				if not AutofarmOn then
					Time = Time - 1
					print("[XRAF v2]: Fail Prevention: " .. tostring(Time))
				end
			end
		until Time <= 0
		hopServer()
	end)

	game:GetService("ReplicatedStorage").Events.CoolNewRemote:FireServer("Touch")

	repeat
		wait()
	until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == false

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
	

	Started = true
	serverHoppedCuzSC = false
	spawn(function()
		local works,no = pcall(function()
			repeat
			    if game:GetService("ReplicatedStorage").wkspc.lastmap.Value == "Street Corner" and not serverHoppedCuzSC then serverHoppedCuzSC = true hopServer() end
			    game.Players.LocalPlayer.PlayerGui.GUI.TeamSelection.Visible = false
				if game.Players.LocalPlayer.Status.Team.Value ~= "Spectator" then
				    sayMessage("Im probably AFK right now, do not try talk to me.")
					for i,v in pairs(game:GetService("Players"):GetPlayers()) do
						if v ~= game.Players.LocalPlayer then
							if v.Status.Team.Value ~= "Spectator" and v.Status.Team.Value ~= game.Players.LocalPlayer.Status.Team.Value then
								if v.NRPBS.Health.Value > 0 then
									if v.Status.Alive.Value == true then
										if v.Character then
											if not AutofarmOn then
												AutofarmOn = true
												Time = 25
											end

                                            pcall(function()
						local s = 1
                                                repeat
                                                    if s == 1  then -- Used to be a check for weapons but we dont need it now, because new anti exploits force me to use teleportation :)
                                                        PlayerLockedOn = v
							spawn(function()
							    local Vals = {}
							    for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do if v.Name:lower():find("gamemode") then table.insert(Vals, v) end end
							    for i,v in pairs(Vals) do if v.Value:lower():find("odd") or v.Value:lower():find("hackula") then s = 2 hopServer() break end end
							end)
							local tweenService = game:GetService("TweenService")
							local partToTween = game.Players.LocalPlayer.Character.HumanoidRootPart + CFrame.new(-7, 10, 7)
							local finalCframe = v.Character.HumanoidRootPart.CFrame
							local tweenInfo = TweenInfo.new(0, Enum.EasingStyle.Quad)								
							local tween = tweenService:Create(partToTween, tweenInfo, {CFrame = finalCframe})
							tween:Play() 

                                                        wait()
                                                    end
                                                until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true or not v or not v.Character or v.NRPBS.Health.Value <= 0
                                            end)
										end
									end
								end
							end
						end
					end
				end
				if AutofarmOn then
					AutofarmOn = false
				end
				wait()
			until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true
		end)
		
		if not works then print(no) end

		local Messages = {
			"You guys are literally so bad, how can people be this bad?",
			"Get better at the game kids YOU BAD",
			"Wow I think Im becoming fusionboys!",
			"Jeez, yall suck",
			"Im probably the best arsenal player of all time"
		}

		sayMessage(Messages[math.random(1, #Messages)])

		wait(5)

		hopServer()
	end)
end

spawn(function()
	local VirtualUser = game:GetService("VirtualUser")
	while wait(1) do
		VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		wait(.5)
		VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	end
end)

spawn(function()
	while true do
		if Started then
			if game.Players.LocalPlayer.NRPBS.Health.Value <= 0 and game.Players.LocalPlayer.Status.Team.Value ~= "Spectator" then
				game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()
			end
		end
		wait(.01)
	end
end)

local MyMouse = game:GetService("Players").LocalPlayer:GetMouse()
local printItTick = tick()
local pressmvtc = tick()
local switchTick = tick()
local random1 = math.random(-2, 2)
local random3 = math.random(-2, 2)
local random2 = math.random(0, 3)

game:GetService("RunService").RenderStepped:Connect(function()
    if game:GetService("Players").LocalPlayer.Status.Team.Value ~= "Spectator" then
        if PlayerLockedOn and PlayerLockedOn.Character and PlayerLockedOn.NRPBS.Health.Value > 0 and PlayerLockedOn.Character:FindFirstChild("HeadHB") then
             workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	     workspace.CurrentCamera.CFrame = CFrame.new(game.Players.LocalPlayer.Character.Head.Position + Vector3.new(1, 0, 1), PlayerLockedOn.Character.HeadHB.Position - Vector3.new(0, 0.5, 0))
             if (tick() - switchTick) >= 0.5 then -- I may use the random thing later, it was mostly for positioning the head to the player. Due to exploit fixes, I now have to try other things...
		random1 = math.random(-2, 2)
		random2 = math.random(0, 3)
		random3 = math.random(-2, 2)
		switchTick = tick()
	     end
        end
        local Ray = Ray.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.LookVector * 1000)
        local List = {}
        if workspace:FindFirstChild("Map") then
            List = {workspace.Map}
        end
        if (tick() - pressmvtc) >= 1 then
            mouse1click()
            mousemoverel(1, 1)
            pressmvtc = tick()
        end
        local Target = workspace:FindPartOnRayWithIgnoreList(Ray, List)
        if Target then
            if Target.Parent:IsA("Model") then
                if game:GetService("Players"):FindFirstChild(Target.Parent.Name) then
                    local ThisPlayer = game:GetService("Players"):FindFirstChild(Target.Parent.Name)
                    if ThisPlayer.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value then
                        if ThisPlayer.Status.Team.Value ~= "Spectator" then
                            if ThisPlayer.NRPBS.Health.Value > 0 then
                                mouse1press()
                                mouse1rel()
                                if (tick() - printItTick) >= 1 then
                                    print(PlayerLockedOn)
                                    printItTick = tick()
                                end
                            end
                        end
                    end
                end
	    elseif Target.Parent:IsA("Accessory") then
	    	if game:GetService("Players"):FindFirstChild(Target.Parent.Parent.Name) then
                    local ThisPlayer = game:GetService("Players"):FindFirstChild(Target.Parent.Parent.Name)
                    if ThisPlayer.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value then
                        if ThisPlayer.Status.Team.Value ~= "Spectator" then
                            if ThisPlayer.NRPBS.Health.Value > 0 then
                                mouse1press()
                                mouse1rel()
                                if (tick() - printItTick) >= 1 then
                                    print(PlayerLockedOn)
                                    printItTick = tick()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

Autofarm()
