repeat wait() until game:IsLoaded()
local vu = game:GetService("VirtualUser");
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame);
   wait(1);
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame);
end);

if game.PlaceId == 0 then 
    print'soon'
elseif game.PlaceId == 0 then 
    print'soon'
end;
