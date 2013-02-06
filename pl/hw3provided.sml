(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** My Solution ****)
fun only_capitals (string_list) =
    List.filter (fn s => Char.isUpper(String.sub(s, 0))) string_list

fun longest_string1 (string_list) =
    (* Why can't I define fn x y as opposed to f(x,y)? -- I think as I remember it, that is only syntactic sugar for function calls where the function has currying. *)
    List.foldl (fn (x, acc) => if String.size(x) > String.size(acc) then x else acc) "" string_list

fun longest_string2 (string_list) =
    List.foldl (fn (x, acc) => if String.size(acc) > String.size(x) then acc else x) "" string_list

fun longest_string_helper f = 
    fn string_list 
       => List.foldl (fn (x, acc) => if f (String.size(x), String.size(acc)) then x else acc) "" string_list

(* Picks the element closer to the front of the list *)
val longest_string3 = longest_string_helper (fn (x, acc) => x > acc);

(* Picks the element closer to the end of the list *)
val longest_string4 = longest_string_helper (fn (x, acc) => x >= acc);

val longest_capitalized = longest_string1 o only_capitals;

val rev_string = String.implode o List.rev o String.explode;

(* Q7 *)
fun first_answer f = 
    fn list => case list of 
		   [] => raise NoAnswer
		 | xs::xs' => case f xs of 
				  NONE => first_answer f xs'
				| SOME result_val => result_val

(* This is a bad solution to all_answers *)
(* It has duplicate cases handled in accumulator when all_answers returns NONE *)
(* I'm sure there is a better solution but I just haven't thought of it yet *)
fun all_answers f =
    fn list => case list of
		   [] => SOME []
		 | xs::xs' => 
		   let
		       fun accumulator (acc, lst_opt_lst) =
			   case lst_opt_lst of
			       [] => SOME acc
			     | lst_opt::rest => case lst_opt of
						    NONE => NONE
						  | SOME v => accumulator (acc @ v, rest)
		   in
		       case f xs of
			   NONE => NONE
			 | SOME result_val => accumulator (result_val, [all_answers f xs'])
		   end

(* Q9 *)
val count_wildcards = g (fn x => 1) (fn y => 0);

val count_wild_and_variable_lengths = g (fn x => 1) (fn y => String.size y);

fun count_some_var (string, pattern) =
    g (fn x => 0) (fn y => if y = string then 1 else 0) pattern

(* Q10 *)

(* Q11 *)

(* This solution should work if match was properly defined *)
(* fun first_match (value, pattern_list) =
    first_answer (match value) pattern_list
    handle NoAnswer => NONE; *)

(**** for the challenge problem only ****)
datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)
