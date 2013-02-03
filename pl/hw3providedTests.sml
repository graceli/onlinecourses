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

longest_capitalized(["longer1", "long", "longer2"]) = "";
longest_capitalized(["Longer1", "long", "Longer2"]) = "Longer1";
longest_capitalized(["Long", "Long", "Longer"]) = "Longer";

rev_string("test") = "tset";
rev_string("AbC") = "CbA";
