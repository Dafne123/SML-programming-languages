CM.make "$smlnj-tdp/back-trace.cm";
SMLofNJ.Internals.TDP.mode := true;

fun format_month(m : int) =
    if m >= 0 andalso m < 13
    then m
    else m mod 12 + 1

fun format_day(d : int) =
  if d mod 32 = 0 orelse d > 32
	then d mod 32 + 1
	else d mod 32

val day = format_day(32);

(*fun is_older2(date1 : int list, date2 : int list) = 
    let
        fun check_dates(date1 : int list, date2 : int list) =
    		if null date1 andalso null date2
    		then false
    		else if hd date1 < hd date2
    		then true
    		else if hd date1 = hd date2
    		then check_dates(tl date1, tl date2)
    		else false
    in
        check_dates(date1 : int list, date2 : int list)
    end*)

val testmonth = format_month(24)

fun is_older3(dateFrom : (int * int * int), dateTo : (int * int * int)) =
	let
		val date1 = [#1 dateFrom, format_month(#2 dateFrom), format_day(#3 dateFrom)]
		val date2 = [#1 dateTo, format_month(#2 dateTo), format_day(#3 dateTo)]
        fun check_dates(date1 : int list, date2 : int list) =
    		if null date1 andalso null date2
    		then false
    		else if hd date1 < hd date2
    		then true
    		else if hd date1 = hd date2
    		then check_dates(tl date1, tl date2)
    		else false
    in
        check_dates(date1 : int list, date2 : int list)
    end

val test = is_older3((2010, 10, 12),(2010, 24, 12));

fun number_in_month(dates : (int * int *int) list, month : int) =
    let
        val tot_m = 0;
        val month = format_month(month)
        fun find_months(dates : (int * int *int) list, tot_m) =
            if null dates
            then tot_m 
            else let 
                    val date = (#1 (hd dates), format_month(#2 (hd dates)), format_day(#3 (hd dates)));
                 in
                    if month = #2 date
                    then find_months(tl dates, tot_m + 1)
                    else find_months(tl dates, tot_m)    
                end        
    in
      (*find_months(formatted_dates, month)*)
        find_months(dates , tot_m)
    end

val new_dates = [(1999, 23, 30), (2000, 12, 20)];
val date = (#1 (hd new_dates), format_month(#2 (hd new_dates)), format_day(#3 (hd new_dates)))
val m = 12;
val m_month = format_month(10);
val m_in_dates = number_in_month(new_dates, m);





fun number_in_months(dates : (int * int * int) list, ms : int list) =
    
    let 
        val tot_m = 0;
        fun number_in_month(dates : (int * int *int) list, month : int) =
            let
                val tot_m = 0;
                val month = format_month(month)
                fun find_month(dates : (int * int *int) list, tot_m) =
                    if null dates
                    then tot_m 
                    else    let 
                                val date = (#1 (hd dates), format_month(#2 (hd dates)), format_day(#3 (hd dates)));
                            in
                                if month = #2 date
                                then find_month(tl dates, tot_m + 1)
                                else find_month(tl dates, tot_m)    
                            end        
            in
                (*find_month(formatted_dates, month)*)
                find_month(dates , tot_m)
            end 

        fun find_all_months(dates : (int * int * int) list , months : int list, tot_m : int) =
            if null months
            then tot_m
            else    let 
                        val tot_m = tot_m + number_in_month(dates, hd months)
                    in 
                        find_all_months(dates, tl months, tot_m)
                    end           
    in    
        find_all_months(dates, ms, tot_m)  
    end


fun dates_in_month(dates : (int*int*int) list, month : int) =
    let 
        val new_dates = []
        fun find_dates_in_month(dates : (int * int *int) list, new_dates : (int * int *int) list) =
                    if null dates
                    then new_dates 
                    else    let 
                                val date = (#1 (hd dates), format_month(#2 (hd dates)), format_day(#3 (hd dates)));
                            in
                                if month = #2 date
                                then find_dates_in_month(tl dates, new_dates @ [date])   
                                else find_dates_in_month(tl dates, new_dates)    
                            end 
    in
        find_dates_in_month(dates, new_dates) (* rev *)
    end

val my_dates = [(2001,12,01), (1999, 012, 03), (0000, 01, 01), (1989, 012, 01), (2013, 12, 01)]
val my_months = [12, 1] 
val res = dates_in_month(my_dates, 12);

fun find_dates_in_month(dates : (int * int *int) list, new_dates : (int * int *int) list, month : int) =
    if null dates
    then new_dates 
    else    let 
                val date = (#1 (hd dates), format_month(#2 (hd dates)), format_day(#3 (hd dates)));
            in
                if month = #2 date
                then find_dates_in_month(tl dates, new_dates @ [date], month)   
                else find_dates_in_month(tl dates, new_dates, month)    
            end 

fun dates_in_months(dates : (int*int*int) list, months : int list) = 
    let 
        val new_dates = []
        fun find_dates_in_months(new_dates, months : int list) =
            if null months
            then new_dates
            else new_dates @ find_dates_in_month(dates, new_dates, hd months)
    in 
        find_dates_in_months(new_dates, months)
    end

val my_dates = [(2001,12,01), (1999, 012, 03), (0000, 01, 01), (1989, 012, 01), (2013, 12, 01)]
val my_months = [12, 1] 
val my_test = dates_in_months(my_dates , my_months)

fun get_nth (l : string list, n : int) =
    if null l
    then ""
    else if n <= 1 
    then hd l 
    else get_nth (tl l, n-1) 

val my_strings = []

val strn = get_nth(my_strings, 5)
