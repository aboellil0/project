set a 10
set b 20.5
set d 3
set f 7

puts [expr $a + $b]          
puts [expr $a - $b]      
puts [expr $a * $b]  
puts [expr $a / $b]        
puts [expr $a ** $d]
puts [expr $a ** $b]


puts "lab 2 ---------------------"

set num 15 
if {$num > 100} {
  puts "the num is large than 100"
} elseif {$num > 70} {
  puts "the num is large than 70"
} elseif {$num > 50} { 
  puts "the num is large than 50"
} elseif {$num > 40} { 
  puts "the num is large than 40"
} elseif {$num > 20} { 
  puts "the num is large than 20"
} elseif {$num > 10} { 
  puts "the num is large than 10"
}  


puts "lab 3 ---------------------"

set performance "Good"

switch $performance {
  "Excellent" {
    puts "the employee performance is Excellent"
  }
  " Very Good" {
    puts "the employee performance is  Very Good"
  }
  "Good" {
    puts "the employee performance is Good"
  }
  "Up Normal" {
    puts "the employee performance is Up Normal"
  }
  "Normal" {
    puts "the employee performance is Normal"
  }
  "Bad" {
    puts "the employee performance is Bad"
  }
}


puts "lab 4 ---------------------"

set values(0) 16
set values(1) 25
set values(2) 36
set values(3) 49

puts "###################################"
puts "Value \tsqrt \tSquare \tCubic"
for {set var 0} {$var < 4} {incr var} {
  # body...
  set val $values($var)
  puts "$val \t[expr sqrt($val)] \t[expr $val ** 2] \t[expr $val ** 3]"
}
puts "###################################"



puts "lab 5 ---------------------"

set i 0
set cc 0
while {$i <200} {
  incr i +7
  incr cc
  
  if {$cc == 4} {
    continue
  }
  if {$cc == 10} {
    break
  }
  puts "$i"
}


puts "lab 6 ----------------------"



set mm {1 2 3 4 5 6 7}

foreach m $mm {
  set chekvar [expr $m ** 2]
  if {$chekvar > 10 || $chekvar < 0} {
    break
  }
  puts "$chekvar"
} 


puts "lab 7 ----------------------"

set example "intake45"
set result [split $example ""]
set counts 0
foreach ch $result {
  incr counts  
}

puts "$counts"


puts "lab 8 ----------------------"


set reversedch ""

for {set var $counts} {$var >= 0} {incr var -1} {
  # body...
  set element [lindex $result $var] ;#the element from a list by its index [lindex (the lest) (index)]
  append reversedch $element
  
}

puts "$reversedch"



  