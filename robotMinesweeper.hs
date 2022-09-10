import Debug.Trace
type Cell = (Int,Int)
data MyState = Null | S Cell [Cell] String MyState deriving (Show,Eq)

up :: MyState -> MyState
up (S (x,y) a b c)	 = (S (x-1,y) a "Up" (S (x,y) a b c))
						
down :: MyState -> MyState
down (S (x,y) a b c)	 = (S (x+1,y) a "down" (S (x,y) a b c))

left :: MyState -> MyState
left (S (x,y) a b c) = (S (x,y-1) a "left" (S (x,y) a b c))

right :: MyState -> MyState
right (S (x,y) a b c) = (S (x,y+1) a "right" (S (x,y) a b c))

collect :: MyState -> MyState
collect (S a b c d)	= (S a b "collect" (S a b c d))
					
removeTarget a [] = []
removeTarget a (h:t) = if a == h then t else h:(removeTarget a t)

nextMyStates::MyState->[MyState]
nextMyStates a = removeNulls ((up a):(down a):(left a):(right a):(collect a):[])

removeNulls :: [MyState]->[MyState]
removeNulls [] = []
removeNulls (h:t) = if h == Null then removeNulls t else h:(removeNulls t)

isGoal::MyState->Bool
isGoal (S a b c d) = if (length b) == 0 then True else False

search::[MyState]->MyState
search (((S a b c d)):t) = collect ( combineStates (search3 (S a b c d)) (search4 (S a b c d))) 

abs2 x y = if(x>y) then x-y else y-x

combineStates a Null =    a
combineStates  Null a =    a
combineStates (S a b c d) state =  if (d == Null) then    (S a b c state)  else  (S a b c (combineStates d state)) 


search3((S (x1,y1) ((x2,y2):t) c d)) = if(x1>x2) then  helperHeight (abs2 x1 x2) True (S (x1,y1) ((x2,y2):t) c d) 
										else  helperHeight (abs2 x1 x2) False (S (x1,y1) ((x2,y2):t) c d)
		
		
search4((S (x1,y1) ((x2,y2):t) c d)) = if(y1>y2) then helperWidth (abs2 y1 y2) False (S (x1,y1) ((x2,y2):t) c d) 
									else   helperWidth(abs2 y1 y2) True (S (x1,y1) ((x2,y2):t) c d)

helperHeight 0 b s = s
helperHeight x b s = if (b==True) then  helperHeight (x-1) b (up s) else  helperHeight (x-1) b (down s)

helperWidth 0 b s = s
helperWidth x b s = if (b==True) then helperWidth (x-1) b (right s) else helperWidth (x-1) b (left s)

searchCaller a [] = []
searchCaller (S a b c d) (h:t) = (search[(S a [h] c d)]):(searchCaller(S h t c d) t)

 
constructSolution_h [] =  [] 
constructSolution_h ((S a b c d):t) =if(d == Null) then  c :(constructSolution_h t) else c:(constructSolution_h ((d):t) )
--- if(d == Null) then c :(constructSolution_h t) else c:constructSolution_h ((S a b c d):t)

constructSolution a = reverse (constructSolution_h a)

solve :: Cell->[Cell]->[String]
solve a b = removeEmpty(constructSolution ( reverse (searchCaller (S a b ("") Null) b)))

removeEmpty[] = []
removeEmpty (h:t) = if h == "" then removeEmpty t else h:(removeEmpty t)
