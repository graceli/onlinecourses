fun number_before_reading_sum (sum : int, numbers: int list) =
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
	      then number_before_reading_sum (sum, reverse_list (tl numbers_reverse))
	      else count_list (numbers)
	  end
      end