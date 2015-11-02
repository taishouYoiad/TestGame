local baseAnimation = class("baseAnimation")

function baseAnimation:ctor() 
end

function baseAnimation:createAnimation(filename,t) --t => {table1,table2}  | table1 => {heightIndex,Speed,animationName}
	local image = display.loadImage(filename)
	local eWidth = image:getPixelsWide() / 4
	local eHeight = image:getPixelsHigh() / 8
	for _,k in pairs(t) do
		local frames = {}
		for i = 0,3,1 do 
			local frame = display.newSpriteFrame(image,cc.rect(eWidth * i,eHeight * k[1] ,eWidth,eHeight))
			frames[#frames + 1] = frame
		end
		local animation = display.newAnimation(frames,k[2])
		display.setAnimationCache(k[3],animation)
	end
end

function baseAnimation:createTestSkill(infotable)
	local frames = {}
	local count = tonumber(infotable[3])
	for i = 0,count do
		local filename = infotable[1]..i..".png"
		local image = display.loadImage(filename)
		local eWidth = image:getPixelsWide()
		local eHeight = image:getPixelsHigh()
		local frame = display.newSpriteFrame(image, cc.rect(0, 0, eWidth, eHeight))
		frames[#frames + 1] = frame
	end
	local animation = display.newAnimation(frames,0.05)
	display.setAnimationCache(infotable[2],animation)
end

function baseAnimation:changeSpeed(filename,typetable)
	local image = display.loadImage(filename)
	local eWidth = image:getPixelsWide() / 4
	local eHeight = image:getPixelsHigh() / 8
	local frames = {}
	for i = 0,3,1 do 
		local frame = display.newSpriteFrame(image,cc.rect(eWidth * i,eHeight * typetable[1],eWidth,eHeight))
		frames[#frames + 1] = frame
	end
	local animation = display.newAnimation(frames,typetable[2])
	display.removeAnimationCache(typetable[3])
	display.setAnimationCache(typetable[3],animation)
end




return baseAnimation