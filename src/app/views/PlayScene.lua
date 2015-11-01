local PlayScene = class("PlayScene" , cc.load('mvc').ViewBase)

local ZS = import("..models.ZS")

function PlayScene:onCreate()
	local Xzs = ZS:create()
	self.Xzs = Xzs
	--以下初始化背景
	self:createButton()
	display.newSprite("bg.png")
		:move(display.center)
		:addTo(self,0)
	--创建Touch绑定
	display.newLayer():onTouch(handler(self,self.onTouched)):addTo(self)
	--以下是测试
	self.testS = self.Xzs:newZS()
	self.testS:addTo(self,101)
	
	self:startstep()
end

function PlayScene:createButton()
	local backButton = cc.MenuItemImage:create("back.png","back.png")
					:onClicked(function()	self:getApp():enterScene("MainScene")	end)
	cc.Menu:create(backButton):move(32,display.height - 32):addTo(self,100)

	local shaButton = cc.MenuItemImage:create("sha.png","sha2.png")
					:onClicked(function()	
									pcall(self.Xzs:shaAction():addTo(self,102))
							   end)
	cc.Menu:create(shaButton):move(128,display.height - 32):addTo(self,100)

	local skillButton = cc.MenuItemImage:create("skill.png","skill2.png")
					:onClicked(function()	
									local s1 , s2 = self.Xzs:skillAction()
									pcall(s1:addTo(self,102))
									pcall(s2:addTo(self,102))
								end)
	cc.Menu:create(skillButton):move(224,display.height - 32):addTo(self,100)

	local jsButton = cc.MenuItemImage:create("js.png","js2.png")
					:onClicked(function()
										local tmpS = self.Xzs:jsAction()
										if tmpS ~= false then
											self.testS:removeSelf()
											self.testS = tmpS:addTo(self,100) 
										end
								end)
	cc.Menu:create(jsButton):move(320,display.height - 32):addTo(self,100)
end


function PlayScene:startstep()
	self:scheduleUpdate(handler(self,self.step))
end

function PlayScene:step(dt)
	self.Xzs:step(dt)
end

function PlayScene:onTouched(event)
	local this = self
	print(event.name..'--'..event.x..'--'..event.y)
	this:startstep()
	self.Xzs:setTx(event.x)
end

return PlayScene
