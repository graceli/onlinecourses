fun is_older (date1 : int*int*int, date2 : int*int*int) =
(* year month day *)
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
end

fun number_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then 0
    else if (#2 (hd dates))=month
    then 1 + number_in_month (tl dates, month)
    else number_in_month (tl dates, month)

fun number_in_months (dates : (int*int*int) list, months : int list) =
    if null dates
    then 0
    else if null months
    then 0
    else number_in_month (dates, hd months) + number_in_months (dates, tl months)

fun dates_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then []
    else if (#2 (hd dates))=month
    then hd dates :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

fun dates_in_months (dates : (int*int*int) list, months : int list) =
    if null dates
    then []
    else if null months
    then []
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months)

fun get_nth (strings : string list, n : int) =
(* what if n is greater than the length of the list?
   If the list is null this function will run on the null list *)
    if n=1
    then hd strings
    else get_nth (tl strings, n-1)

fun date_to_string (date : int*int*int) =
let
    val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    val yearInt = (#1 date);
    val monthInt = (#2 date);
    val dayInt = (#3 date);
in
    get_nth(months, monthInt) ^ " " ^ Int.toString(dayInt) ^ ", " ^ Int.toString(yearInt)
end

fun number_before_reaching_sum (sum : int, numbers: int list) =
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
      end

fun what_month (dayOfYear : int) =
    let
	val daysInAMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    in
	number_before_reaching_sum (dayOfYear, daysInAMonth) + 1
    end

fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else
	what_month(day1) :: month_range(day1+1, day2)

(* This problem is just the solution to max int but using is_older solution for problem 1 *)
(* Currently I am still confused as to how to use options in ML and I can't come up with how max is implemented at
the top of my head right now *)
fun oldest (dates : (int*int*int) list) =
    if null dates
    then NONE
    else
	let
	    val oldestDate = oldest (tl dates);
	in
	    if isSome oldestDate andalso is_older(valOf oldestDate, hd dates)
	    then oldestDate
	    else SOME(hd dates)
	end
