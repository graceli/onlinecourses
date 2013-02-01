(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option (string_list, string) =
    case string_list of
	[] => NONE
      | head::tail => if same_string(head, string) 
		      then SOME tail
		      else
			  case all_except_option(tail, string) of
				  NONE => NONE
				| SOME str_list => SOME (head::str_list)

fun get_substitutions1 (string_list_list, string) =
    case string_list_list of
	[] => []
      | head_list::tail_list_list => case all_except_option(head_list, string) of 
					 NONE => get_substitutions1(tail_list_list, string)
				       | SOME str_list => str_list @ get_substitutions1(tail_list_list, string)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
