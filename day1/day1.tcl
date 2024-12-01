set open [open "numbers.txt" r]
set lines [split [read $open] \n]
close $open

set numbers1 [list]
set numbers2 [list]

foreach line $lines {
    set numbers [split $line " "]
    
    lappend numbers1 [lindex $numbers 0]
    lappend numbers2 [lindex $numbers 3]
}

proc bubble_sort {list} {
    set swapped 1

    while {$swapped == 1} {
        set swapped 0

        for {set i 0} {$i < [llength $list] - 1} {incr i} {
            if {[lindex $list $i] > [lindex $list [expr $i + 1]]} {
                set temp [lindex $list $i]
                lset list $i [lindex $list [expr $i + 1]]
                lset list [expr $i + 1] $temp
                set swapped 1
            }
        }
    }

    return $list
}

set numbers1 [bubble_sort $numbers1]

set numbers2 [bubble_sort $numbers2]

set sum 0

for {set i 0} {$i < [llength $numbers1]} {incr i} {

    if {[lindex $numbers1 $i] >= [lindex $numbers2 $i]} {
        incr sum [expr [lindex $numbers1 $i] - [lindex $numbers2 $i]]
    } else {
        incr sum [expr [lindex $numbers2 $i] - [lindex $numbers1 $i]]
    }

}

puts $sum

proc similarity {list1 list2} {
    set sum 0

    for {set i 0} {$i < [llength $list1]} {incr i} {
        incr sum [expr [occurs $list2 [lindex $list1 $i]] * [lindex $list1 $i]]
    }

    return $sum
}

proc occurs {list item} {
    set count 0

    foreach element $list {
        if {$element == $item} {
            incr count
        }
    }

    return $count
}

puts [similarity $numbers1 $numbers2]