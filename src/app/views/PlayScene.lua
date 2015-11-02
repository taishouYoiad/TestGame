local PlayScene = class("PlayScene" , cc.load('mvc').ViewBase)

local ZS = import("..models.ZS")
local HR = import("..models.HR")

function PlayScene:onCreate()
	--产生坏人的时间
	self.hrT = 3
	local Xzs = ZS:create()
	self.Xzs = Xzs

	local Xhr_table = {}
	local testH_table = {}
	self.Xhr_table = Xhr_table
	self.testH_table = testH_table
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
									local s,ok = self.Xzs:shaAction()
									if ok == 1 then
										s:addTo(self,102)
										self:onSha()
									end
							   end)
	cc.Menu:create(shaButton):move(128,display.height - 32):addTo(self,100)

	local skillButton = cc.MenuItemImage:create("skill.png","skill2.png")
					:onClicked(function()	
									local s1 , s2 , ok = self.Xzs:skillAction()
									if ok == 1 then
										pcall(s1:addTo(self,101))
										pcall(s2:addTo(self,101))
									end
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


function PlayScene:createHR()
	local Xhr = HR:create()
	table.insert(self.Xhr_table,Xhr)
	local testH = Xhr:newHR():addTo(self,101)
	table.insert(self.testH_table,testH)
end

function PlayScene:startstep()
	self:scheduleUpdate(handler(self,self.step))
end

function PlayScene:step(dt)
	self.hrT = self.hrT - dt
	if self.hrT <= 0 then
		self:createHR()
		self.hrT = math.random(0,#self.Xhr_table) + 30
	end
	self.Xzs:step(dt)
	if #self.Xhr_table == 0 then
		return
	end
	for i,k in pairs(self.Xhr_table) do
		k:cooldownStep(dt)
		if k.x - self.Xzs.x <= 300 then
			self:hrSkillAction(k)
		else
			k:step(dt)
		end
	end
end

function PlayScene:hrSkillAction(xhr)
	local s1,s2,ok = xhr:skillAction()
	if ok == 1 then
		pcall(s1:addTo(self,102))
		pcall(s2:addTo(self,102))
	end
end

function PlayScene:onSha()
	local x = self.Xzs.x
	local y = self.Xzs.y
	for i,k in pairs(self.Xhr_table) do
		if k.x - x <= 80 then
			k:hitedAction():addTo(self,110)
			k.ghost.testS:removeSelf()
			table.remove(self.Xhr_table,i)
		end
	end
end

function PlayScene:onTouched(event)
	local this = self
	print(event.name..'--'..event.x..'--'..event.y)
	this:startstep()
	self.Xzs:setTx(event.x)
end

return PlayScene
