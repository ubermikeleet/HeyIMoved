-- Config
local updateInterval = 1     -- time in seconds between checks
local distanceThreshold = 10 -- distance in yards (from starting point, or from last time alarm sounded)
local soundId = 1495882      -- sound file id


-- Addon
local lastX, lastY
local HeyIMoved = CreateFrame("Frame")

function HeyIMoved:OnUpdate(elapsed)
  self.TimeSinceLastUpdate = (self.TimeSinceLastUpdate or 0) + elapsed; 	

  if (self.TimeSinceLastUpdate >= updateInterval) then
    local currentX, currentY = UnitPosition("player")
    local distance = ((lastX - currentX) ^ 2 + (lastY - currentY) ^ 2) ^ 0.5/1.075
    
    if (distance >= distanceThreshold) then
        PlaySoundFile(soundId)
        lastX, lastY = currentX, currentY
    end

    self.TimeSinceLastUpdate = 0;
  end
end

HeyIMoved:RegisterEvent("PLAYER_ENTERING_WORLD")
HeyIMoved:SetScript("OnEvent", function()
    lastX, lastY = UnitPosition("player")
    HeyIMoved:SetScript("OnUpdate", HeyIMoved.OnUpdate)
end)
