
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
    -- cc.MenuItem:onClicked(function()	return self:enterScene(PlayScene)	end)
    -- add HelloWorld label
    -- cc.Label:createWithSystemFont("Hello World", "Arial", 40)
    --     :move(display.cx, display.cy + 200)
    --     :addTo(self)

end

return MainScene
