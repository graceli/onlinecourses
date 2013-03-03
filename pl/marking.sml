(*
exception NoAnswer

fun first_answer f a_list =
    case a_list of
	[] => raise NoAnswer
      | a::a_list' => case f(a) of
			  SOME v => v
			| _ => first_answer f a_list'

*)

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

val check_pat = 
    let
	fun get_var_names p =
	    case p of
		TupleP ps => List.foldl (fn (p,i) => (get_var_names p) @ i) [] ps
	      | Variable x => [x]
	      | _ => []
			 
	fun is_duplicate (str_list : string list) =
	    case str_list of
		[] => true
	      | s::str_list' => not (List.exists (fn x => x = s) str_list') andalso is_duplicate str_list'
    in
	is_duplicate o get_var_names
    end
