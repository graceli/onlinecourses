(* My initial horrible imperative programming-paradigm solution *)
(* fun is_older (date1 : int*int*int, date2 : int*int*int) =
let 
    val year1 = (#1 date1);
    val year2 = (#1 date2);
    val month1 = (#2 date1);
    val month2 = (#2 date2);
    val day1 = (#3 date1);
    val day2 = (#3 date2);
in
    if year1 < year2
    then true
    else if year1=year2
    then if month1<month2
	 then true
	 else if month1=month2
	 then if day1<day2
	      then true
	      else false
	 else false
    else false
end *)

fun is_older (date1 : int*int*int, date2 : int*int*int) =
    let
	val smaller_year = #1 date1 < #1 date2;
	val same_year_smaller_month = (#1 date1 = #1 date2) andalso (#2 date1 < #2 date2);
	val same_year_same_month_smaller_day = (#1 date1 = #1 date2) andalso (#2 date1 = #2 date2) andalso #3 date1 < #2 date2;
    in
	smaller_year 
	orelse same_year_smaller_month 
	orelse same_year_same_month_smaller_day
    end
	
fun number_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then 0
    else if #2 (hd dates) = month
    then 1 + number_in_month (tl dates, month)
    else number_in_month (tl dates, month)

fun number_in_months (dates : (int*int*int) list, months : int list) =
    if null months
    then 0
    else number_in_month (dates, hd months) + number_in_months (dates, tl months)

fun dates_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then []
    else if #2 (hd dates) = month
    then hd dates :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

fun dates_in_months (dates : (int*int*int) list, months : int list) =
    if null months
    then []
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months)

fun get_nth (strings : string list, n : int) =
    if n = 1
    then hd strings
    else get_nth (tl strings, n - 1)

fun date_to_string (date : int*int*int) =
    let
	val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	val yearInt = #1 date;
	val monthInt = #2 date;
	val dayInt = #3 date;
    in
	get_nth (months, monthInt) ^ " " ^ Int.toString (dayInt) ^ ", " ^ Int.toString (yearInt)
    end

(* My initial horrible and horribly long solution *)
(* fun number_before_reaching_sum (sum : int, numbers: int list) =
  if null numbers
  then 0
  else
      let
	  fun reverse_list (numbers : int list) =
	      if null numbers
	      then []
	      else reverse_list (tl numbers) @ [hd numbers]
						   
	  fun sum_list (numbers : int list) =
	      if null numbers
	      then 0
	      else hd numbers + sum_list(tl numbers)
					
	  fun count_list (numbers : int list) =
              if null numbers
              then 0
              else 1 + count_list(tl numbers)
      in
	  let
	      val numbers_reverse = reverse_list (numbers);
	      val sumOfList = sum_list (numbers_reverse);
	  in
	      if sumOfList>=sum
	      then number_before_reaching_sum (sum, reverse_list (tl numbers_reverse))
	      else count_list (numbers)
	  end
      end *)

(* A better algorithm which leads to a much more elegant solution: remove elements from list, and deduct from total sum. The index of the element such that the next element sums to sum or more is the element such that sum - hd list_so_far <= 0 *)
fun number_before_reaching_sum (sum : int, numbers : int list) =
    let
	val sum_diff = sum - hd numbers;
    in
	if sum_diff <= 0 
	then 0 
	else 1 + number_before_reaching_sum (sum_diff, tl numbers)
    end

fun what_month (day_of_year : int) =
    let
	val days_in_a_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    in
	number_before_reaching_sum (day_of_year, days_in_a_month) + 1
    end

fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1 + 1, day2)

fun oldest (dates : (int*int*int) list) =
    if null dates
    then NONE
    else
	let
	    val oldest_date = oldest (tl dates);
	in
	    if isSome oldest_date andalso is_older (valOf oldest_date, hd dates)
	    then oldest_date
	    else SOME (hd dates)
	end

(* Do challenge problems at some point *)
