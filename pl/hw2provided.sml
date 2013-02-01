(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option (string, string_list) =
    case string_list of
	[] => NONE
      | head::tail => if same_string(head, string) 
		      then SOME tail
		      else
			  case all_except_option(string, tail) of
				  NONE => NONE
				| SOME str_list => SOME (head::str_list)

fun get_substitutions1 (string_list_list, string) =
    case string_list_list of
	[] => []
      | head_list::tail_list_list => case all_except_option(string, head_list) of 
					 NONE => get_substitutions1(tail_list_list, string)
				       | SOME str_list => str_list @ get_substitutions1(tail_list_list, string)

(* Use a tail-recursive local helper function *)
fun get_substitutions2 (string_list_list, string) =
    let
	fun aux (list_list, acc) =
	    case list_list of
		[] => acc
	     | head_list::rest_list_list => case all_except_option(string, head_list) of
						NONE => aux(rest_list_list, acc)
					      | SOME str_list => aux(rest_list_list, str_list @ acc) 
    in
	aux(string_list_list, [])
    end

fun similar_names (string_list_list, {first=first_name, middle=middle_name, last=last_name}) =
    let
	fun sub (names_list, {first=x, middle=y, last=z}) =
	    case names_list of
		[] => []
	      | name::rest => {first=name, middle=y, last=z} :: sub(rest, {first=x, middle=y, last=z})
	   
	val substitutions = get_substitutions2(string_list_list, first_name);
    in
	 {first=first_name, middle=middle_name, last=last_name} :: sub(substitutions, {first=first_name, middle=middle_name, last=last_name})
    end
	
	
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
fun card_color ((suit, rank)) = 
    case suit of
	Spades => Black
     | Clubs => Black
     | Diamonds => Red
     | Hearts => Red

fun card_value ((suit, rank)) =
    case rank of
	Jack => 10
      | Queen => 10
      | King => 10
      | Ace => 11
      | Num n => n

fun remove_card (cs, c, e) =
    case cs of
	[] => raise e
      | head_card::rest => if head_card=c
			   then rest
			   else head_card::remove_card(rest, c, e)

fun all_same_color (cs) =
    case cs of
	[] => true
     | _::[] => true
     | head_card::neck_card::rest => card_color(head_card) = card_color(neck_card) andalso all_same_color(rest)

fun sum_cards (cs) =
    let
	fun aux(cs, acc) =
	    case cs of
		[] => acc
	     | card::rest => aux(rest, card_value(card) + acc)
    in
	aux(cs, 0)
    end

fun score (cs, goal) = 
    let 
	val sum = sum_cards(cs);
	val all_colors_same = all_same_color(cs);
	fun preliminary_score(sum, goal) =
	    if sum > goal
	    then 3*(sum - goal)
	    else goal - sum
    in
	case all_colors_same of
	    true => Int.div (preliminary_score(sum, goal), 2)
	 | false  => preliminary_score(sum, goal)
    end

fun officiate (card_list, move_list, goal) = 
    let
	fun game (card_list, move_list, held_cards, goal) =
	    case move_list of
		(* Game ends when there are no more moves *)
		[] => score(held_cards, goal)
	     | move::rest_of_moves => case move of 
					  Discard c => let val head_card::rest = card_list;
						       in 
							   game(rest, rest_of_moves, remove_card (held_cards, c, IllegalMove), goal) 
						       end
					| Draw => if card_list=[] 
						  then score(held_cards, goal) 
						  else 
						      let
							  val sum_held = sum_cards(held_cards)
						      in
							  if sum_held > goal 
							  then score(held_cards, goal) 
							  else 
							      let val head::rest = card_list;
							      in 
								  game(rest, rest_of_moves, head::held_cards, goal) 
							      end
						      end
							  
    in
	game(card_list, move_list, [], goal)
    end
