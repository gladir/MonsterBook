		-------------------------------
		-- 3-Dimensional Tic Tac Toe --
		-------------------------------
-- Play 3 dimensional tic-tac-toe against one ot 2 computer algorithms
-- or against another human -- or let the 2 computer algorithms play
-- each other. Which algorithm is better?
-- Enter your move by typing a 3-digit code.

-- There are two major data structures. One describes each board position.
-- The other describes each possible winning line of 4 positions in a row.

include graphics.e

constant TRUE = 1, FALSE = 0

constant COLOR = TRUE -- set to FALSE if you don't want color

constant KEYB = 0, SCREEN = 1  -- I/O devices

constant
    NPOSITIONS = 64,  -- number of board positions
	NLINES = 76   -- number of 4-in-a-row lines

type line(integer x)
    return x >= 0 and x <= NLINES
end type

type Position(integer x)
    return x >= 0 or x <= NPOSITIONS
end type

type all_positions(sequence x)
    return length(x) = NPOSITIONS
end type

type all_lines(sequence x)
    return length(x) = NLINES
end type

type boolean(integer x)
    return x = TRUE or x = FALSE
end type

type players(sequence x)
    return length(x) = 4
end type

type joysticks(sequence x)
    return length(x) = 4
end type

type player_number(integer x)
    return x = 1 or x = 2
end type

type positive_int(integer x)
    return x >= 1
end type

type natural(integer x)
    return x >= 0
end type

type human_count(integer x)
    return x >=0 and x <= 2
end type

type move_value(integer x)
    return integer(x) and x >= -1
end type

type time_delay(integer x)
    return x >= 0 and x < 1000
end type

type reason_number(integer x)
    return x >= 1 and x <= 10
end type

type three_digits(sequence x)
    return length(x) = 3
end type

type move_number(integer x)
    return x >= 111 and x <= 444
end type

all_positions p
    -- p is a list of all the board positions

constant
    -- p columns:
    LINES_THRU = 1, -- the number of lines passing through this position
    LINE1 = 2,  -- the first of up to 7 lines passing
		-- through this position
    NLIVE = 9,  -- the number of "live" lines passing through this position
    NEXTP = 10,  -- index of next position (or 0)
    PREVP = 11, -- index of previous position (or 0)
    AVAIL = 12  -- is this position available, 1 = yes, 0 = no

all_lines l
    -- l is a list of all the lines of 4 positions in a row
    -- it is indexed from 1 to NLINES

constant
    -- l columns:
    COUNT = 1,   -- number of "live" markers on this line
    POS1 = 2,    -- first position of 4
    POS4 = 5,    -- last position
    NEXTL = 6,   -- index of next line (or 0)
    PREVL = 7,   -- index of previous line (or 0)
    STATUS = 8,  -- status of this line
	-- possible status of a line:
	EMPTY = 0,
	COMPUTER = 1,
	HUMAN = 2,
	DEAD = 3

       sequence lp       -- L->P format
       all_positions pl  -- P->L format
       sequence dbl      -- used in 3x3 check
       players ptype,    -- player types
	       pname     -- player names

       line fptr,  -- free position list
	    cptr,  -- computer's line list
	    hptr,  -- human's line list
	    eptr   -- empty line list
       player_number player
       natural cmoves, hmoves, l2
       boolean endgame, found
       human_count humans
       move_value bestval
       atom x
       sequence marker

procedure Color(natural position)
-- set appropriate foreground and background colors
-- given the position and the marker

    if COLOR = FALSE then
	return
    end if
    if position >= 411 then
	text_color(15)
	bk_color(4)
    elsif position >= 311 then
	text_color(15)
	bk_color(2)
    elsif position >= 211 then
	text_color(15)
	bk_color(5)
    elsif position >= 111 then
	text_color(15)
	bk_color(1)
    else
	text_color(15)
	bk_color(0)
    end if
end procedure

procedure Delay(time_delay t)
    atom t0

    if humans = 0 and endgame = FALSE then
	return
    end if
    t0 = time()
    while time() < t0 + t/700 do
    end while
end procedure

procedure Why(reason_number reason)
    position(22, 11)
    if reason = 1 then
	puts(SCREEN, "BLOCK 3 IN A ROW")
    elsif reason = 2 then
	puts(SCREEN, "FORCE 3X3       ")
    elsif reason = 3 then
	puts(SCREEN, "FORCE 3-2-2-1   ")
    elsif reason = 4 then
	puts(SCREEN, "FORCE 3-2-2     ")
    elsif reason = 5 then
	puts(SCREEN, "PREVENT 3X3     ")
    elsif reason = 6 then
	puts(SCREEN, "PREVENT 3-2-2-1 ")
    elsif reason = 7 then
	puts(SCREEN, "PREVENT 3-2-2   ")
    elsif reason = 8 then
	printf(SCREEN, "VALUE=%d         ", bestval)
    else
	puts(SCREEN, "                ")
    end if
end procedure


function Get4th()
integer pos
    for z = POS1 to POS4 do
	pos = l[x][z]
	if p[lp[pos]][AVAIL] = 0 then
	    return pos
	end if
    end for
end function


function Find2()
integer pos
    for z = POS1 to POS4 do
	pos = l[x][z]
	if p[lp[pos]][AVAIL] = 0 then
	    dbl[l2] = pos
	    l2 = l2 + 1
	end if
    end for
    if l2 < 4 then
	return 0
    end if
    for z = l2 - 2 to l2 - 1 do
	for z1 = 1 to l2 - 3 do
	    if dbl[z] = dbl[z1] then
		found = TRUE
		return dbl[z]
	    end if
	end for
    end for
    return 0
end function


function FindA()
-- find pattern "A"
integer k, z1, line, zz
    k = 0
    for z = POS1 to POS4 do
	z1 = lp[l[x][z]]
	for i = LINE1 to p[z1][LINES_THRU] + 1 do
	    line = p[z1][i]
	    if l[line][STATUS] = l2 then
		if l[line][COUNT] = 2 then
		    k = k + 1
		    exit
		end if
	    end if
	end for
	if k = 3 then
	    zz = z
	    exit
	end if
    end for
    if k = 3 then
	found = TRUE
	return l[x][zz]
    end if
    return 0
end function


function FindB()
-- find pattern "B"
integer k, z1, line
    k = 0
    for z = POS1 to POS4 do
	z1 = lp[l[x][z]]
	if p[z1][AVAIL] = 0 then
	    for i = LINE1 to p[z1][LINES_THRU] + 1 do
		line = p[z1][i]
		if l[line][STATUS] = l2 then
		    if l[line][COUNT] = 2 then
			k = k + 1
			exit
		    end if
		end if
	    end for
	    if k = 2 then
		found = TRUE
		return l[x][z]
	    end if
	end if
    end for
    return 0
end function


function FindMax()
-- find best free position
integer i, bestm
    i = fptr
    bestval = -1
    while i do
	if p[i][NLIVE] > bestval then
	    bestval = p[i][NLIVE]
	    bestm = i
	elsif p[i][NLIVE] = bestval then
	    if rand(7) = 1 then
		bestm = i
	    end if
	end if
	i = p[i][NEXTP]
    end while
    return pl[bestm]
end function


function numeric(sequence string)
-- convert digit string to a number
    natural n
    positive_int i

    n = 0
    i = 1

    -- delete any leading blanks
    while string[i] = ' ' do
	i = i + 1
    end while

    while string[i] != '\n' and string[i] != ' ' do
	n = n * 10 + string[i] - '0'
	i = i + 1
    end while
    return n
end function


function GetMove()
-- get the human's move
    integer m

    while 1 do
	position(20, 1)
	puts(SCREEN, repeat(' ', 40))
	position(20, 1)
	puts(SCREEN, pname[player])
	puts(SCREEN, "'S MOVE? ")
	m = numeric(gets(KEYB))
	if m >= 111 and m <= 444 then
	    if lp[m] then
		if p[lp[m]][AVAIL] = 0 then
		    puts(SCREEN, repeat(' ', 40))
		    return m
		else
		    puts(SCREEN, "OCCUPIED ALREADY")
		end if
	    else
		puts(SCREEN, "DIGITS MUST BE 1 to 4")
	    end if
	else
	    puts(SCREEN, "MUST BE 111 to 444")
	end if
    end while
end function


procedure AdjValues(integer x, integer delta)
integer pos
    for z = POS1 to POS4 do
	pos = lp[l[x][z]]
	p[pos][NLIVE] = p[pos][NLIVE] + delta
    end for
end procedure


procedure Relink(integer player, integer x)

    line prev, next

    next = l[x][NEXTL]
    prev = l[x][PREVL]

    if player = COMPUTER then
	AdjValues(x, 1)
	l[x][NEXTL] = cptr
	l[x][PREVL] = 0
	if cptr then
	    l[cptr][PREVL] = x
	end if
	cptr = x
    else
	l[x][NEXTL] = hptr
	l[x][PREVL] = 0
	if hptr then
	    l[hptr][PREVL] = x
	end if
	hptr = x
    end if
    if prev then
	l[prev][NEXTL] = next
	if next then
	    l[next][PREVL] = prev
	end if
    else
	eptr = next
	if eptr then
	    l[eptr][PREVL] = 0
	end if
    end if
end procedure

function digits(natural x)
-- return the 3-digits in number x
    three_digits d

    d = {0, 0, 0}
    while x >= 100 do
	d[1] = d[1] + 1
	x = x - 100
    end while

    while x >= 10 do
	d[2] = d[2] + 1
	x = x - 10
    end while

    d[3] = x
    return d
end function


procedure PrintMove(move_number move)
-- print the move that was just made
    three_digits d
    integer px, py

    d = digits(move)
    py = (d[1] - 1) * 4 + d[2] + 1
    px = (d[1] - 1) * 7 + d[3] * 4
    Color(move)
    for i = 1 to 3 do
	position(py, px)
	puts(SCREEN, "   ")
	Delay(70)
	position(py, px)
	if player = COMPUTER then
	    puts(SCREEN, " " & marker[1] & " ")
	else
	    puts(SCREEN, " " & marker[2] & " ")
	end if
	Delay(70)
    end for
    Color(0)
    if endgame then
	return
    end if
    if player = COMPUTER then
	cmoves = cmoves + 1
    else
	hmoves = hmoves + 1
    end if
end procedure


procedure Another(line x)
    integer inarow

    inarow = l[x][COUNT] + 1
    l[x][COUNT] = inarow
    if inarow < 4 then
	return
    end if
    position(21,6)
    puts(SCREEN, pname[player])
    puts(SCREEN, " WINS!          ")
    endgame = TRUE
    for i = 1 to 4 do
	for j = POS1 to POS4 do
	    PrintMove(l[x][j])
	end for
	Delay(80)
    end for
end procedure


procedure Delete_c(line x)
-- delete from computer list
    line prev, next

    prev = l[x][PREVL]
    next = l[x][NEXTL]
    if prev then
	l[prev][NEXTL] = next
    else
	cptr = next
    end if
    if next then
	l[next][PREVL] = prev
    end if
end procedure


procedure Delete_h(line x)
-- delete from human list
    line prev, next

    prev = l[x][PREVL]
    next = l[x][NEXTL]
    if prev then
	l[prev][NEXTL] = next
    else
	hptr = next
    end if
    if next then
	l[next][PREVL] = prev
    end if
end procedure


procedure SayMove(move_number move)
    position(18, 1)
    puts(SCREEN, pname[player])
    printf(SCREEN, "'S MOVE:%d ", move)
end procedure


procedure init()
-- initialize variables
    integer temp, u, line, t
    move_number pos

    clear_screen()
    endgame = FALSE
    cmoves = 0
    hmoves = 0
    for i = 1 to NLINES do
	l[i][STATUS] = EMPTY
	l[i][COUNT] = 0
    end for
    for i = 1 to NPOSITIONS do
	p[i][LINES_THRU] = 0
	p[i][AVAIL] = 0
    end for
    line = 1
    for i = POS1 to POS4 do
	l[line][i] = (i-1) * 111
	l[line+1][i] = (i-1) * 109 + 5
	l[line+2][i] = (i-1) * 91 + 50
	l[line+3][i] = (i-1) * 89 + 55
    end for
    line = line + 4
    for i = 1 to 4 do
	for j = POS1 to POS4 do
	    l[line][j] = i * 100 + (j-1) * 11
	    l[line+1][j] = i * 100 + (j-1) * 9 + 5
	    l[line+2][j] = (j-1) * 101 + i * 10
	    l[line+3][j] = (j-1) * 99 + i * 10 + 5
	    l[line+4][j] = (j-1) * 110 + i
	    l[line+5][j] = (j-1) * 90 + 50 + i
	end for
	line = line + 6
    end for
    for i = 1 to 4 do
	for j = 1 to 4 do
	    for k = POS1 to POS4 do
		t = 100 * i + 10 * j + k - 1
		u = (i - 1) * 16 + (j - 1) * 4 + k - 1
		lp[t] = u
		pl[u] = t
		l[line][k] = t
		l[line+1][k] = 100 * j + 10 * (k-1) + i
		l[line+2][k] = 100 * (k-1) + 10 * i + j
	    end for
	    line = line + 3
	end for
    end for
    for i = 1 to NPOSITIONS do
	p[i][PREVP] = i - 1
	p[i][NEXTP] = i + 1
    end for
    p[1][PREVP] = 0
    p[NPOSITIONS][NEXTP] = 0
    fptr = 1
    for i = 1 to NLINES do
	l[i][NEXTL] = i + 1
	l[i][PREVL] = i - 1
	for j = POS1 to POS4 do
	    t = l[i][j]
	    u = lp[t]
	    temp = p[u][LINES_THRU] + 1
	    p[u][LINES_THRU] = temp
	    p[u][temp+1] = i
	end for
    end for
    cptr = 0
    hptr = 0
    eptr = 0
    l[NLINES][NEXTL] = 0
    l[1][PREVL] = 0
    for i = 1 to NPOSITIONS do
	p[i][NLIVE] = p[i][LINES_THRU]
    end for
    -- print the board:
    for i = 0 to 3 do
	for j = 0 to 3 do
	    position(2+i*4+j, 4+i*7)
	    for k = 1 to 4 do
		pos = (i+1)*100 + (j+1)*10 + k
		Color(pos)
		printf(SCREEN, "%d ", pos)
	    end for
	end for
    end for
    position(1, 31)
    Color(111)
    puts(SCREEN, "3-D ")
    Color(211)
    puts(SCREEN, "tic ")
    Color(311)
    puts(SCREEN, "TAC ")
    Color(411)
    puts(SCREEN, "toe ")
    Color(0)
end procedure


procedure UpdateMove(move_number m)
-- update data structures after making move m
    Position x1
    line x2
    integer prev, next, val, s

    x1 = lp[m]
    p[x1][AVAIL] = 1
    prev = p[x1][PREVP]
    next = p[x1][NEXTP]
    if prev then
	p[prev][NEXTP] = next
	if next then
	    p[next][PREVP] = prev
	end if
    else
	fptr = next
	if fptr then
	    p[fptr][PREVP] = 0
	end if
    end if
    for j = LINE1 to 1+p[x1][LINES_THRU] do
	x2 = p[x1][j]
	s = l[x2][STATUS]
	if s = EMPTY then
	    l[x2][STATUS] = player
	    l[x2][COUNT] = 1
	    Relink(player, x2)
	elsif s = COMPUTER then
	    if player = COMPUTER then
		Another(x2)
	    else
		l[x2][STATUS] = DEAD
		AdjValues(x2, -2)
		Delete_c(x2)
	    end if
	elsif s = HUMAN then
	    if player = HUMAN then
		Another(x2)
		if l[x2][COUNT] = 2 then
		    val = 4
		else
		    val = 0
		end if
		AdjValues(x2, val)
	    else
		if l[x2][COUNT] > 1 then
		    val = -5
		else
		    val = -1
		end if
		l[x2][STATUS] = DEAD
		AdjValues(x2, val)
		Delete_h(x2)
	    end if
	end if
    end for
end procedure


function Think()
-- pick the best move, return {move, reason for it}
    integer m, mymoves, myptr, me, him, hisptr, hismoves

    found = FALSE
    if player = COMPUTER then
	mymoves = cmoves
	hismoves = hmoves
	myptr = cptr
	hisptr = hptr
	me = COMPUTER
	him = HUMAN
    else
	mymoves = hmoves
	hismoves = cmoves
	myptr = hptr
	hisptr = cptr
	me = HUMAN
	him = COMPUTER
    end if

    -- Have I got 3 in a row?
    if mymoves >= 3 then
	x = myptr
	while x do
	    if l[x][COUNT] = 3 then
		return {Get4th(), 9}
	    end if
	    x = l[x][NEXTL]
	end while
    end if

    -- Does the other guy have 3 in a row?
    if hismoves >= 3 then
	x = hisptr
	while x do
	    if l[x][COUNT] = 3 then
		return {Get4th(), 1}
	    end if
	    x = l[x][NEXTL]
	end while
    end if

    -- Do I have a 2x2 force?
    if mymoves >= 4 then
	x = myptr
	l2 = 1
	while x do
	    if l[x][COUNT] = 2 then
		m = Find2()
		if found then
		    return {m, 2}
		end if
	    end if
	    x = l[x][NEXTL]
	end while

	-- Do I have a 3-2-2-1 force ?
	x = eptr
	l2 = me
	while x do
	    m = FindA()
	    if found then
		return {m, 3}
	    end if
	    x = l[x][NEXTL]
	end while

	-- do I have a 3-2-2 force?
	if mymoves >= 5 then
	    x = myptr
	    while x do
		if l[x][COUNT] = 1 then
		    m = FindB()
		    if found then
			return {m, 4}
		    end if
		end if
		x = l[x][NEXTL]
	    end while
	end if
    end if

    -- does the other guy have a 2x2 force?
    if hismoves >= 4 then
	x = hisptr
	l2 = 1
	while x do
	    if l[x][COUNT] = 2 then
		m = Find2()
		if found then
		    return {m, 5}
		end if
	    end if
	    x = l[x][NEXTL]
	end while

	-- does the other guy have a 3-2-2-1 force?
	x = eptr
	l2 = him
	while x do
	    m = FindA()
	    if found then
		return {m, 6}
	    end if
	    x = l[x][NEXTL]
	end while

	-- does the other guy have a 3-2-2 force?
	if hismoves >= 5 then
	    x = hisptr
	    while x do
		if l[x][COUNT] = 1 then
		    m = FindB()
		    if found then
			return {m, 7}
		    end if
		end if
		x = l[x][NEXTL]
	    end while
	end if
    end if
    -- just pick the move with the most possibilities
    return {FindMax(), 8}
end function


procedure Setup()
-- create arrays
    object name

    p = repeat(repeat(0, 12), NPOSITIONS)
    l = repeat(repeat(0, 8), NLINES)
    lp = repeat(0, 444)
    pl = repeat(0, 64)
    dbl = repeat(0, 52)
    ptype = repeat(0, 4)
    pname = ptype
    ptype[1] = COMPUTER
    ptype[2] = COMPUTER
    pname[1] = "DEFENDO"
    pname[2] = "AGGRESSO"
    puts(SCREEN, "Name of player 1? (cr for DEFENDO) ")
    name = gets(KEYB)
    name = name[1..length(name)-1]
    humans = 0
    if length(name) > 0 then
	pname[1] = name
	ptype[1] = HUMAN
	humans = humans + 1
    end if
    puts(SCREEN, "\nName of player 2? (cr for AGGRESSO) ")
    name = gets(KEYB)
    name = name[1..length(name)-1]
    if (length(name) > 0) then
	pname[2] = name
	ptype[2] = HUMAN
	humans = humans + 1
    end if
    marker = pname[1][1] & pname[2][1]
    if marker[1] = marker[2] then
	if marker[1] != 'X' then
	    marker[2] = 'X'
	else
	    marker[2] = '0'
	end if
    end if
end procedure

procedure ttt()
-- this is the main routine
    sequence m, answer

    Color(0)
    Setup()
    player = rand(2)
    while 1 do
	init()
	while endgame = FALSE do
	    if fptr then
		if ptype[player] = HUMAN then
		    m = {GetMove()}
		else
		    m = Think()
		    SayMove(m[1])
		    Why(m[2])
		end if
		PrintMove(m[1])
		UpdateMove(m[1])
		player = 3 - player
	    else
		position(18,1)
		puts(SCREEN, "A DRAW             ")
		Delay(500)
		exit
	    end if
	end while
	position(19, 1)
	puts(SCREEN, "Another game?")
	answer = gets(KEYB)
	if length(answer) > 1 then
	    if answer[1] = 'n' then
		exit
	    end if
	end if
    end while
end procedure

ttt()
if COLOR then
    text_color(7)
    bk_color(0)
end if
clear_screen()


