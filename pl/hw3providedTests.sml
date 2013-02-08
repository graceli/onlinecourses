print "Tests for only_capitals\n";

(* Empty list *)
only_capitals([]) = [];

(* All capitals *)
only_capitals(["Alice", "Bob", "Carol"]) = ["Alice", "Bob", "Carol"];

(* All capitals with single-lettered and multi-lettered words *)
only_capitals(["A", "Bob", "C"]) = ["A", "Bob", "C"];

(* Mixed capital and lower case *)
only_capitals(["hello", "Bob", "my", "name", "is"]) = ["Bob"];

print "Tests for longest_string1\n";

longest_string1(["this", "longer", "longest"]) = "longest";
longest_string1([]) = "";
longest_string1(["long", "longest", "longer"]) = "longest";
longest_string1(["same1", "same2", "same3"]) = "same1";
longest_string1(["longest", "longer", "long"]) = "longest";
longest_string1(["longer1", "long", "longer2"]) = "longer1";

longest_string2(["same1", "same2", "same3"]) = "same3";
longest_string2(["longer1", "long", "longer2"]) = "longer2";

longest_string3(["same1", "same2", "same3"]) = "same1";
longest_string3(["longer1", "long", "longer2"]) = "longer1";

longest_string4(["same1", "same2", "same3"]) = "same3";
longest_string4(["longer1", "long", "longer2"]) = "longer2";

print "Test for longest_capitalized\n";
longest_capitalized(["longer1", "long", "longer2"]) = "";
longest_capitalized(["Longer1", "long", "Longer2"]) = "Longer1";
longest_capitalized(["Long", "Long", "Longer"]) = "Longer";

print "Test for rev_string";
rev_string("test") = "tset";
rev_string("AbC") = "CbA";

print "Test for first_answer\n";
first_answer (fn x => if x mod 2 = 0 then SOME x else NONE) [1, 3, 5, 8] = 8;
first_answer (fn x => if x mod 2 = 0 then SOME x else NONE) [1, 2, 5, 8] = 2;

(* Should be no answer *)
(* first_answer (fn x => if x mod 2 = 0 then SOME x else NONE) [1, 3, 5, 7]; *)

print "Tests for all_answers\n";
all_answers (fn x => if x mod 2 = 0 then SOME [x] else NONE) [2,4,6,8] = SOME [2,4,6,8];
all_answers (fn x => if x mod 2 = 0 then SOME [x] else NONE) [2,4,6,3] = NONE;
all_answers (fn x => if x mod 2 = 0 then SOME [x] else NONE) [1,2,4,6,8] = NONE;

print "Test 9 (a - c)\n";
count_wildcards (Variable "a")=0;
count_wildcards (TupleP [Wildcard, Wildcard])=2;
count_wildcards (ConstructorP ("a", TupleP ([Wildcard, ConstP 1])))=1;

count_wild_and_variable_lengths (ConstructorP ("a", TupleP ([Wildcard, TupleP([Variable ("a"), Variable ("abc")])])))=5;

check_pat (TupleP[Variable "a", Variable "b", Variable "c", Variable "d", TupleP[Variable "a", Variable "b", TupleP[Variable "e", Variable "f"]]]) = false;

check_pat(TupleP[Variable "a", Variable "b", Variable "c", Variable "d", TupleP[Variable "z", Variable "g", TupleP[Variable "e", Variable "f"]]]) = true;

(* Patterns *)
val test_pattern1 = Variable "a";
val test_pattern2 = TupleP [Variable "a", Variable "b", Wildcard];
val test_pattern3 = ConstructorP ("a", Variable "b");

val test_value1 = Const 17;
val test_value2 = Tuple[Unit, Const 1, Const 2];
val test_value3 = Constructor ("a", Unit);

(* Matching cases *)
match (test_value1, test_pattern1) = SOME [("a",test_value1)];
match (test_value2, test_pattern2) = SOME [("a", Unit), ("b", Const 1)];
match (test_value3, test_pattern3) = SOME [("b", Unit)];

(* Non-matching cases *)
val test_value_nomatch2 = Tuple[Unit, Unit];
val test_value_nomatch3 = Constructor ("b", Unit);
match (test_value_nomatch2, test_pattern2) = NONE;
match (test_value_nomatch3, test_pattern3) = NONE;

print "Tests for first_match\n";
first_match (test_value1, [test_pattern1, test_pattern3, TupleP [Variable "z"]]) = SOME [("a", Const 17)];
first_match (test_value1, [test_pattern2, test_pattern3]) = NONE;
