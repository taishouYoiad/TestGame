
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    display.newSprite("start.png")
        :move(display.center)
        :addTo(self)
    local playButton = cc.MenuItemImage:create("play.png","plau.png")
    				:onClicked(function() self:getApp():enterScene("PlayScene")	end)
    cc.Menu:create(playButton)
    		:move(display.center)
    		:addTo(self)

end

return MainScene
