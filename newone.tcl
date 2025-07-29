

proc if_name_exist name {
  set list2 [list mohamed ahmed mohamed elsayed aboellil]
  set isfound 0
  foreach item $list2 {
    if {$item == $name} {
      puts found
      set isfound 1
      break
    }
  }
  if {!$isfound} {
    puts not_found
  }
  
}


proc if_name_exist name {
  set list2 [list mohamed ahmed mohamed elsayed aboellil]
  set check_b [lsearch $list2 $name]
  if {$check_b >= 0} {
    puts found
  } else {
    puts not_found
  }
}

if_name_exist mohamed


puts "lab 1 ---------------------"

proc factorial num {
  set result 1
  set max [expr $num + 1]
  for {set i 2} {$i < $max} {incr i} {
    set result [expr $result * $i]
  }
  return $result
}

puts [factorial 5]


proc factorial_2 num {
  if {$num == 0 || $num == 1} {
    return 1
  }

  return [expr $num * [factorial_2 [expr $num - 1]]]
}

puts [factorial_2 5]


puts "lab 2 ---------------------"

proc if_dublicate_1 given_list {
  set var [lsort $given_list]
  set var_length [llength $given_list]
  for {set i 0} {$i < $var_length} {incr i} {
    set item_1 [lindex $var $i]
    set item_2 [lindex $var [expr $i + 1]]
    if {$item_1 == $item_2} {
      return "there a dublicate"
    }
  }
  return "there is no dublicate"
}

puts [if_dublicate_1 {mohamed ahmed mohamed elsayed}]


puts "lab 3 ---------------------"

proc max_value given_list {
  set var [lsort $given_list]
  set var_length [llength $given_list]
  set max_num [lindex $var 0]
  for {set i 0} {$i < $var_length} {incr i} {
    if {[lindex $var $i] > $max_num} {
      set max_num [lindex $var $i]
    }
  }
  
  return $max_num
}


puts [max_value {0 5 9 1 5 4 3 2 7}]


puts "lab 4 ---------------------"

proc print_the_Fibonacci max_num {
  set Fibonacci {0 1}
  for {set i 2} {$i < $max_num} {incr i} {
    set item_0 [lindex $Fibonacci [expr {$i - 1}]]
    set item_1 [lindex $Fibonacci [expr {$i - 2}]]
    lappend Fibonacci [expr {$item_0 + $item_1}]
  }
  puts $Fibonacci
}

print_the_Fibonacci 7

puts "lab 5 ----------------------"

proc replace_proc {list_name replace_element insert_element} {
  set index_to_replace [lsearch $list_name $replace_element]
  set new_list [lreplace $list_name $index_to_replace $index_to_replace $insert_element]
  set new_list [lreplace $new_list 1 1 ]
  puts $new_list
}

replace_proc {item_0 item_1 item_2 item_3 item_4} item_4 item_edited


puts "lab 6 ----------------------"

if {[catch {replace_proc {item_0 item_1 item_2 item_3 item_4} item_4 item_edited} err result_error]} {
  puts "there is an error"
}

puts "lab 7 ----------------------"

proc even_numbers list_name {
  set new_list {}
  foreach item $list_name {
    if {[expr $item % 2] == 0} {
      lappend new_list $item
    }
  }
  puts $new_list
} 

even_numbers {0 1 2 3 4 5 6 7 8}









