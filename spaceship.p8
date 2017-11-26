pico-8 cartridge // http://www.pico-8.com
version 14
__lua__
function _init()
 fort = {x = 60,
 							 y = 50,
 							 points = 0,
 							 hp	= 3,
 							 box = {x1=0,y1=0,x2=10,y2=10}
 							}
	bullets = {}
	enemies = {}
	t  = 0
	bc = 1
	start()
end

--states
function start()
	_draw = draw_mgame
	_update = update_mgame
end

function fire (i,sprite,dix,diy)
 local	bullet = {
		sp = sprite, 
		x  = fort.x,
		y  = fort.y, 
		dx = dix,
		dy = diy,
		dire = i,
		box = {x1 = 0, y1 = 0,x2=3,y2=3}
	}
	add(bullets,bullet)
	bc = 0
end

function spawn (sprite,sx,sy,dix,diy)
	local enemy = {
		sp = sprite,
		x  = sx,
		y  = sy,
		dx = dix,
		dy = diy,
		box= {x1=0,y1=0,x2=3,y2=3}
		}
	add(enemies,enemy)
end

-- colisoes

function up_box(b)
	local box= {}
	
	box.x1 = b.box.x1 + b.x
	box.x2 = b.box.x2 + b.x
	box.y1 = b.box.y1 + b.y
	box.y2 = b.box.y2 + b.y
	return box
	
end

function coll(ba,bb)

	local box_ba = up_box(ba)
	local	box_bb = up_box(bb)
	
	if box_ba.x1 > box_bb.x2 or
    box_ba.y1 > box_bb.y2 or
    box_bb.x1 > box_ba.x2 or
    box_bb.y1 > box_ba.y2 then
    return false
	end
	return true
end

function update_mgame()
	t += 1
-- bullet  control
		for bullet in all(bullets) do
				bullet.x += bullet.dx
				bullet.y += bullet.dy
				if bullet.x < 0 or bullet.x > 128 or bullet.y < 0 or bullet.y > 128 then
					del(bullets,bullet)
					bc = 1
				end
				for enemy in all(enemies) do
					if coll(bullet,enemy) then
						del(enemies,enemy)
						del(bullets,bullet)
						fort.points += 10
						bc=1
     end
				end
		end

  if btnp(0) and bc == 1 then fire(0,22,-3,0) end
		if btnp(1) and bc == 1 then fire(1,19,3,0) end
		if btnp(2) and bc == 1 then fire(2,20,0,-3) end
		if btnp(3) and bc == 1 then fire(3,21,0,3) end
-- enemy spawn 
	for enemy in all(enemies) do
		enemy.x += enemy.dx
		enemy.y += enemy.dy
		if coll(fort,enemy) then
			del(enemies,enemy)
			if(fort.hp > 0) then
				fort.hp -= 1
			end
		end
	end
		if t%100 == 0 then spawn(14,0,fort.y,0.9,0) end
		if t%125 == 0 then spawn(15,fort.x,0,0,1.5) end
		if t%150 == 0 then spawn(14,128,fort.y,-2,0) end
		if t%185 == 0 then spawn(15,fort.x,128,0,-0.5) end
end

--function _draw_title()
--	cls()
--	print("we've been discovered!",30,30,2)
--end
	
function draw_mgame() 
	cls()
	map(0,0,0,0,17,16)
	for bullet in all(bullets) do
		spr(bullet.sp,bullet.x,bullet.y)
	end
	for enemy in all(enemies) do
		spr(enemy.sp,enemy.x,enemy.y)
	end
	print("score:",0,0,1)
	print(fort.points,25,0,2)
	print("health:",90,0,1)
	print(fort.hp,120,0,2)
end



	
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000004444440000000000000000000000000000000000000000000000000
000dd000000dd000000dd000000dd00000808000000000000550055000222200003333004040040400bbbb000055550000111100099009900000000002022020
00dccd0000d00d0000d00d0000d0000008080800000ddd000005500002200220003003000404404000b00b00005005000110011000099000000ddd0000200200
0dccccd00dccccd00d0000d00d0000d08008008000d0d0d0005005000020020000033000004004000b0000b000055000001001000090000000d0d0d000022000
00dccd0000dccd0000dccd0000d00d008080808000d0d0d0000550000202202030300303040000400bbbbbb000500500000110000009900000d0d0d000200200
000dd000000dd000000dd0000000d00008080800000ddd0005500550002002000300003000400400b0b00b0b050000500011110009900990000ddd0002000020
000000000000000000000000000000000000000000d0d0d0000000000000000000000000000000000b0bb0b000000000000000000000000000d000d000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000aa0000005500000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000555a00000550000005500000a55500000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000555a00000550000005500000a55500000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000055000000aa00000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbcccccccc9999999911111111111161116666111111111bbb
00000000000000000000000000000000000000000000005550000000bbbbbbbbbbbbbbbbbbbbbbbbcccccccc99999999111111111116661166611111bbb11bbb
00000000000000000000000000000000000000000000005850000000bbbbbbbbbbbbbbbbbbbbbbbbcccccccc99999999111111111166666166111111bbb11bbb
00000000000000000000000000000000000000000000005850000000bbbbbbbbbbbbbbbbbbbbbbbbcccccccc99999999111111111116661161111111bbb11141
00000000000000000000000000000000000000000000005850000000bbbbbccccccbbbbbbbbbbbbbcccccccc9999999911111111111161111111111114111141
00000000000000000000000000000000000000000000005550000000bbbbcccccccccbbbbbbbbbbbbbbbbbbb4444444499999999111111111111111134333343
00000000000000000000000000000000000000000000000500000000bbbccccccccccbbbbbbbbbbbbbbbbbbb4444444499999999111111111111111133333333
00000000000000000000000000000000000000000000000500000000bbbcccccccccbbbbbbbbbbbbbbbbbbbb4444444499999999111111111111111133333333
00000000000000000000000000000000000000000000555555500000bbbbccccccbbbbbb00000000111111113333333300000000dddd77777777dddd77777777
00000000000000000000000000000000000000000000000500000000bbbbbbcccbbbbbbb00000000111111113333333300000000ddddd777777ddddd77777777
00000000000000000000000000000000000000000000000500000000bbbbbbbbbbbbbbbb00000000111111113333333300000000dddddd7777dddddd77777777
00000000000000000000000000000000000000000000055555000000bbbbbbbbbbbbbbbb00000000111111113333333300000000ddddddd77ddddddd66666666
00000000000000000000000000000000000000000000050005000000bbbbbbbbbbbbbbbb00000000111111113333333355555555dddddddddddddddd66666666
00000000000000000000000000000000000000000000050005000000bbbbbbbbbbbbbbbb00000000333333333333333355555555dddddddddddddddd66666666
00000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbb00000000333333333333333355555555dddddddddddddddd66666666
00000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbb00000000333333333333333355555555dddddddddddddddd66666666
000000005444444444444445bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004555555555555554bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004554444444444554bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333bbbbbbbbbbbbbb33bbbbbbbbbbbbb33bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004545000000005454bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb333333bbbbbbbbbbbb3333bbbbbbbbbbb3333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004540500000050454bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333bbbbbbbbbb333333bbbbbbbbb333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004540055555500454bbbbbbbbbbbbbbbbbbbbbb3333bbbbbbbbb33333333bbbbbbbbbb333333bbbbbbbb33333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004540054444500454bbbbbbbbbbbbbbbbbbbbb333333bbbbbbbb33333333bbbbbbbbbb333333bbbbbbb3333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004540054444500454bbbbbbbbbbbbbbbbbbbb33333f33bbbbbbbb333333bbbbbbbbbbb333333bbbbbbb3333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004540054444500454bbbbbbbbbbbbbbbbbbbb33333333bbbbbbbbb3333bbbbbbbbbbbb333333bbbbbbbb33333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004540054444500454bbbbbbbbbbbbbbbbbbbb33333333bbbbbbbbbb44bbbbbbbbbbbbb333333bbbbbbbbb33f333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004540055555500454bbbbbbbbbbbbbbbbbbbbb333333bbbbbbbbbbb44bbbbbbbbbbbbbb3333bbbbbbbbbbb3333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004540500000050454bbbbbbbbbbbbbbbbbbbbbb3333bbbbbbbbbbbb44bbbbbbbbbbbbbbb44bbbbbbbbbbbbb33bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004545000000005454bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44bbbbbbbbbbbbbbb44bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004544444444444554bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000004555555555555554bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
000000005444444444444445bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
00000000544444444444444554444444444444450000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000455555555555555445555555555555540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000455444444444455445544444444445540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454500000000545445450000000054540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454050000005045445405000000504540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454005555550045445400555555004540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454005444450045445400544445004540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454005444450045445400544445004540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454005444450045445400544445004540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454005444450045445400544445004540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454005555550045445400555555004540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454050000005045445405000000504540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454500000000545445450000000054540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000454444444444455445444444444445540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000455555555555555445555555555555540000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
00000000544444444444444554444444444444450000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbb
0000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbccccbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbcccbbbbbbbbbbbbbbbbcccccccbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbcccccccccbbbbbbbbbbbccccccccbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bcccccccccccbbbbbbbbbcccccccccbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bcccccccccccbbbbbbbbccccccccccccccbbbbbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bcccccccccccbbbbbbbcccccccccccccccccbbbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbccccccccccbbbbbbbccccccccccccccccccbbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbcccccccccccbbbbbccccccccccccccccccccbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbccccccccccbbbbbccccccccccccccccccccbbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbbcccccccccbbbbbcccccccccccccccccccccbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbbbcccccccbbbbbbcccccccccccccccccccccbbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbbbbbccccbbbbbbbbcccccccccccccccccccccbbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbccccccccccccccccccccccbbbbbbb0000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbcccccccc3333cccccccccccbbbbbb0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000bbbcccccccc33f3cccccccccccbbbbbb0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000bbbbccccccc3333ccccccccccccbbbbb0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000bbbbccccccc3333ccccccccccccbbbbb0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000bbbbbcccccc3333cccccccccccccbbbb0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000bbbbbbcccccccccccccccccccccbbbbb0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000bbbbbbccccccccccccccccccccbbbbbb0000000000000000000000000000000000000000
000000000fd77e5d10acf8c6e8641d0feaddf2180d52e62d00000000bbbbbbccccccccccccccccccccbbbbbb0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000bbbbbbcccccccccccccccccccbbbbbbb0000000000000000000000000000000000000000
55500055550555505550005555055500055000555055550000000000bbbbbbbccccccccccccccccccbbbbbbb0000000000000000000000000000000000000000
50050050000500005005005000050050500505000050000000000000bbbbbbbbccccccccccccccccbbbbbbbb0000000000000000000000000000000000000000
50005050000500005005005000050050500505000050000000000000bbbbbbbbbbcccccccccccbbbbbbbbbbb0000000000000000000000000000000000000000
50005055500555005550005555055500555505000055500000000000bbbbbbbbbbbbccccccccbbbbbbbbbbbb0000000000000000000000000000000000000000
50005050000500005000000005050000500505000050000000000000bbbbbbbbbbbbbccccccbbbbbbbbbbbbb0000000000000000000000000000000000000000
50050050000500005000000005050000500505000050000000000000bbbbbbbbbbbbbbbcccbbbbbbbbbbbbbb0000000000000000000000000000000000000000
55500055550555505000005555050000500500555055550000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffffffffff000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00fffffffff0
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffffffffffff0
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffffffffffff0
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fff00000fffff0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffff0
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffffff0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffffffff0
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffffffffffff0
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00fffffffff0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffffffff0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f0ff00fff0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffff00000fff0
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffff000fffff0
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

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
292929292929292929298a8a2929292900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8a878889494a2929292947482929292900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8a979899595a8a29292957584b4c292900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8aa7a8a9aa8a8a29442929295b5c292900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
494ab8b9494a2953542929292947482900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
595a8a29595a2929292929292957582900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2929294429442941422929454629292900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2929535453542951522929555629292900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2929292929292929292929292929292900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
29444b4c2944294429442944294b4c4400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
53545b5c5354494a53542929535b5c5400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
434443292944595a434429442728434400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
53494a292954535453546d543738474800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
43595a44434443444344436d43445758eaddf2180d52e62d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5354535453545354535453545354535400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787c0c1c2c3c0c1c2c387878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787d0d1d2d3d0d1d2d387878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787e0e1e2e3e0e1e2e387878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787f0f1f2f3f0f1f2f387878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787c0c1c2c3c0c1c2c387878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787d0d1d2d3d0d1d2d387878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787e0e1e2e3e0e1e2e387878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787f0f1f2f3f0f1f2f387878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787878787878787878787878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787878787878787878787878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787878787878787878787878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787878787878787878787878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787878787878787878787878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787878787878787878787878787878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a00001e0503b0501505016050130501d050200502305026050290502e05031050330503a0503a0503a0503a0503a0503a0503a0503a0503805038050380502205022050200501f0501f0501c0501b05018050
000900000f0500f0501105015050180502d050390503c0503e0503d050280502a0503f050340503f0502505024050200501d0501d050170501a05020050230501f050230502a0502c050370503d0503f0503f050
000a00000905000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000fd7725d102cf042e8641d8762dd72180552ee25000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 41024344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

