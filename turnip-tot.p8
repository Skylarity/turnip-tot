pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
--ˇturnip totˇ
--made with ♥ by skyler rexroad

-- globals --
-------------
room = {x=0, y=0}
objects = {}
classes = {}

shake = 0

-- obj management --
--------------------
function init_obj(class,x,y)
	local obj = {}
	obj.class = class
	obj.collideable = true
	
	obj.spr = class.tile
	obj.flip = {x=false,y=false}
	
	obj.x = x
	obj.y = y
	obj.hitbox = {
		x=0,y=0,
		w=8,h=8
	}
	
	obj.collide = function(class,ox,oy)
		local other
		for i=1,count(objects) do
		other = objects[i]
			if other != nil
				and other.class == class
				and other != obj
				and other.collideable
				and other.x+other.hitbox.x+other.hitbox.w > obj.x+obj.hitbox.x+ox
				and other.y+other.hitbox.y+other.hitbox.h > obj.y+obj.hitbox.y+oy
				and other.x+other.hitbox.x < obj.x+obj.hitbox.x+obj.hitbox.w+ox
				and other.y+other.hitbox.y < obj.y+obj.hitbox.y+obj.hitbox.h+oy
				then return other
			end
		end
		return nil
	end
	
	obj.check = function(class,ox,oy)
		return obj.collide(class,ox,oy) != nil
	end
	
	add(objects,obj)
	if obj.class.init != nil then
		obj.class.init(obj)
	end
	return obj
end

function destroy_obj(obj)
	del(objects,obj)
end

function draw_object(obj)
	if obj.class.draw!=nil then
		obj.class.draw(obj)
	elseif obj.spr > 0 then
		spr(obj.spr,obj.x,obj.y,1,1,obj.flip.x,obj.flip.y)
	end
end

-- room management --
---------------------
function load_room(x,y)
	room.x = x
	room.y = y
	
	
end

-- saving --
------------
save_id = "sr_turnip_friend"
saved = 0
save_game_saved = 0
save_age = 1
save_health = 2
save_hunger = 3


-- game loop --
---------------
function _init()
	-- initialize storage --
	cartdata(save_id)
	saved = dget(save_game_saved)
	
	-- initialize tot --
	init_obj(turnip_tot,60,60)
end

function _update()
	--todo
	
	-- screenshake --
	if shake>0 then
		shake-=1
		camera()
		if shake>0 then
			camera(-2+rnd(5),-2+rnd(5))
		end
	end
	
	-- update objects --
	foreach(objects,function(obj)
		if obj.class.update!=nil then
			obj.class.update(obj)
		end
	end)
end

function _draw()
	-- reset palette --
	pal()
	
	-- clear screen --
	cls()
	
	-- draw objects --
	foreach(objects,draw_object)
	
	-- debug --
	--print(saved,0,0,7)
end

-->8
--turnip tot class

turnip_tot = {
	--game loop
	init=function(this)
		-- gfx --
		this.spr = 4
		
		-- stats --
		this.age = 0
		this.health = 255
		this.hunger = 0
	
		-- get saved data --
		if saved == 1 then
			this.age = dget(save_age)
			this.health = dget(save_health)
			this.hunger = dget(save_hunger)
		end
		
		-- init stats --
		this.spr += this.age
	end,
	update=function(this)
		this.x = this.x+sin(time())
		this.y = this.y+cos(time())
	end,
	draw=function(this)
		spr(this.spr,this.x,this.y,1,1,this.flip.x,this.flip.y)
	end
}
add(classes,turnip_tot)

__gfx__
000000000000000000000000000000000000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000003b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000007737000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000000000000003b000077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000003000077676700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000003b000000077700077171700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000066d6600066366000071710006d777d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006660000066600000d77700006006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00bb00000003b00000bb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007737000000b0000077370000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777770007737000777777000000000000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0776767007777770077676700003b0000000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07717170077676700771717000077700000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06d777d00771717006d777d000717100000777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600006006d777d00006600000d77700007171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000600600000000000000000000d777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000550000000000005555555555555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000550000000000005555555555555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000550000000000005500000000555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000550000000000005500000000555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000550000000000005500000000555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000550000000000005500000000555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555550000000000005500000000555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555550000000000005500000000555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55000000555555555555555500000055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55000000555555555555555500000055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55000000550000000000005500000055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55000000550000000000005500000055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55000000550000000000005500000055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55000000550000000000005500000055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555550000000000005555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555550000000000005555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ba00000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bba0000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003bb0000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003b0000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003ddddddddddddddddddddddddd000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d3777d7d7d777d77dd777d777ddd00
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddd7dd7d7d7d7d7d7dd7dd7d7dddd0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddd7dd7d7d77dd7d7dd7dd777dddd0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddd7dd7d7d7d7d7d7dd7dd7dddddd0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddd7dd777d7d7d7d7d777d7dddddd0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddddddddddddddddddddddd00
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dd6666666666666666666666dd000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000677777767777776777777600000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000677777767777776777777600000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000666776667766776667766600000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006776067766776067760000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006776067766776067760000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006776067766776067760000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006776067777776067760000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006776067777776067760000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666066666666066660000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003b0000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000737700000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777770000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007767670000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007717170000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000556d777d5500000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055655655000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005555550000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000b00000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000003b00000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000077370000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000777777000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000776767000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000771717000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000006d777d000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000060060000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__map__
3123232323232323232323232323233200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2100000000000000000000000000002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2100000000000000000000000000002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2100000000000000000000000000002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2100000000000000000000000000002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2100000000000000000000000000002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2100000000000000000000000000002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2100000000000000000000000000002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2100000000000000000000000000002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3020202020202020202020202020203300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000