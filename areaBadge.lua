local Players = game:GetService("Players")
local BadgeService = game:GetService("BadgeService")
local borderPart = workspace:WaitForChild("Border") -- Assuming the part is in the Workspace

local badgeId = 12345678 -- replace with badge id

local function onTouch(other)
    local player = Players:GetPlayerFromCharacter(other.Parent)
    
    if player then
        -- check if player already has badge
        local success, hasBadge = pcall(function()
            return BadgeService:UserHasBadgeAsync(player.UserId, badgeId)
        end)
        
        if success and not hasBadge then
            -- award badge
            local success, message = pcall(function()
                BadgeService:AwardBadge(player.UserId, badgeId)
            end)

            if success then
                print(player.Name .. " has been awarded badge")
            else
                warn("Failed to award badge: " .. message)
            end
        end
    end
end

borderPart.Touched:Connect(onTouch)
