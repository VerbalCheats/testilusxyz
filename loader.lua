if shotgun then
    loadstring(game:HttpGetAsync("https://testilus.xyz/shotgun.lua"))()
else
    local plr = game:GetService("Players").LocalPlayer
    plr:Kick("Option Not Chosen")
end
