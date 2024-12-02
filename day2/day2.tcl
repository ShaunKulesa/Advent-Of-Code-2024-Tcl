set open [open "numbers.txt" r]
set lines [split [read $open] \n]
close $open

set safeNumbers [list]

proc is_increasing {a b} {
    if {$a < $b} {
        return true
    } else {
        return false
    }
}

proc is_safe {levels giveway} {
    set increasing [is_increasing [lindex $levels 0] [lindex $levels 1]]
    set fails 0

    for {set i 0} {$i < [expr [llength $levels] - 1]} {incr i} {
        set current [lindex $levels $i]
        set next [lindex $levels [expr {$i + 1}]]
        set difference [expr $next - $current]

        if {$difference == 0} {
            incr fails 1
            continue
        }

        if {$increasing && ![is_increasing $current $next]} {
            incr fails 1
            continue
        }

        if {!$increasing && [is_increasing $current $next]} {
            incr fails 1
            continue
        }
        
        if {$difference <= 3 && $difference >= -3} {
            continue
        } else {
            incr fails 1
            continue
        }
    }

    if {$fails > $giveway} {
        return false
    }

    return true
}

foreach line $lines {
    set levels [split $line " "]
    
    if {[is_safe $levels 1]} {
        lappend safeNumbers $levels
    }

}

puts [llength $safeNumbers]