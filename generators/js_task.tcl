namespace eval gen_js {

variable src_vars {}

# Autogenerated with DRAKON Editor 1.28
######### Public #########
proc reset_db {  } {
    variable f_task_rcount
    array unset f_task_rcount
    array set f_task_rcount {}

    variable f_task_type_id
    array unset f_task_type_id
    array set f_task_type_id {}

    variable f_task_name
    array unset f_task_name
    array set f_task_name {}

    variable f_task_properties
    array unset f_task_properties
    array set f_task_properties {}

    variable f_property_rcount
    array unset f_property_rcount
    array set f_property_rcount {}

    variable f_property_type_id
    array unset f_property_type_id
    array set f_property_type_id {}

    variable f_property_task
    array unset f_property_task
    array set f_property_task {}

    variable f_property_name
    array unset f_property_name
    array set f_property_name {}

    variable f_property_is_empty
    array unset f_property_is_empty
    array set f_property_is_empty {}

    variable f_property_body
    array unset f_property_body
    array set f_property_body {}

    variable f_property_vars
    array unset f_property_vars
    array set f_property_vars {}

    variable f_property_signature
    array unset f_property_signature
    array set f_property_signature {}

    variable i_task_name
    array unset i_task_name
    array set i_task_name {}

    variable i_property_task_name
    array unset i_property_task_name
    array set i_property_task_name {}

    variable g_task_next
    set g_task_next 1
    variable g_property_next
    set g_property_next 1
}
proc task_keys {  } {
    variable f_task_rcount
    set names [ array names f_task_rcount ]
    return $names
}
proc task_count {  } {
    variable f_task_rcount
    set names [ array names f_task_rcount ]
    return [ llength $names ]
}
proc task_exists { id } {
    variable f_task_rcount
    return [ info exists f_task_rcount($id) ]
}
proc task_insert { id name } {
    variable g_task_next
    if { $id == {} } {
        set id $g_task_next
    } else {
        if { [ task_exists $id ] } {
            set class_name [ get_task_type_id $id ]
            error "'$class_name' with id $id already exists."
        }
    }
    if { $id >= $g_task_next } {
        set g_task_next [ expr { $id + 1 } ]
    }
    variable i_task_name
    set _key_ "$name"
    if { [ info exists i_task_name($_key_) ] } {
        error "Fields 'name' are not unique for 'task'."
    }
    variable f_task_type_id
    set f_task_type_id($id) "task"
    variable f_task_rcount
    set f_task_rcount($id) 0
    variable f_task_name
    set f_task_name($id) $name
    variable i_task_name
    set _key_ "$name"
    set i_task_name($_key_) $id
    return $id
}
proc get_task_type_id { id } {
    variable f_task_type_id
    if { [ info exists f_task_type_id($id) ] } {
        return $f_task_type_id($id)
    } else {
        return {}
    }
}
proc task_delete { id } {
    variable g_del_list
    array unset g_del_list
    array set g_del_list {}

    if { ![ task_exists $id ] } {
        error "'task' with id '$id' does not exist."
    }
    task_pre_delete $id
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_can_delete"
        $proc_name $pk
    }
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_do_delete"
        $proc_name $pk
    }
    variable f_task_type_id
    unset f_task_type_id($id)
}
proc find_task_by_name { name } {
    variable i_task_name
    set _key_ "$name"
    if { [ info exists i_task_name($_key_) ] } {
        return $i_task_name($_key_)
    } else {
        return {}
    }
}
proc get_task_name { id } {
    variable f_task_name
    if { [ info exists f_task_name($id) ] } {
        return $f_task_name($id)
    } else {
        return {}
    }
}
proc set_task_name { id name } {
    if { ![ task_exists $id ] } {
        error "'task' with id '$id' does not exist."
    }
    set old [ get_task_name $id ]
    if { $old == $name } {
        return
    }
    variable i_task_name
    set _key_ "$name"
    if { [ info exists i_task_name($_key_) ] } {
        error "Fields 'name' are not unique for 'task'."
    }
    set _key_ "$old"
    unset i_task_name($_key_)
    variable f_task_name
    set f_task_name($id) $name
    variable i_task_name
    set _key_ "$name"
    set i_task_name($_key_) $id
}
proc get_task_properties { id } {
    variable f_task_properties
    if { [ info exists f_task_properties($id) ] } {
        return $f_task_properties($id)
    } else {
        return {}
    }
}
proc property_keys {  } {
    variable f_property_rcount
    set names [ array names f_property_rcount ]
    return $names
}
proc property_count {  } {
    variable f_property_rcount
    set names [ array names f_property_rcount ]
    return [ llength $names ]
}
proc property_exists { id } {
    variable f_property_rcount
    return [ info exists f_property_rcount($id) ]
}
proc property_insert { id task name } {
    variable g_property_next
    if { $id == {} } {
        set id $g_property_next
    } else {
        if { [ property_exists $id ] } {
            set class_name [ get_property_type_id $id ]
            error "'$class_name' with id $id already exists."
        }
    }
    if { $id >= $g_property_next } {
        set g_property_next [ expr { $id + 1 } ]
    }
    variable i_property_task_name
    set _key_ "$task,|,$name"
    if { [ info exists i_property_task_name($_key_) ] } {
        error "Fields 'task name' are not unique for 'property'."
    }
    if { $task != {} && ![ task_exists $task ] } {
        error "'task' with id '$task' does not exist."
    }
    variable f_property_type_id
    set f_property_type_id($id) "property"
    variable f_property_rcount
    set f_property_rcount($id) 0
    variable f_property_task
    set f_property_task($id) $task
    variable f_property_name
    set f_property_name($id) $name
    variable i_property_task_name
    set _key_ "$task,|,$name"
    set i_property_task_name($_key_) $id
    if { $task != {} } {
        variable f_task_properties
        if { [ info exists f_task_properties($task) ] } {
            set _col_ $f_task_properties($task)
        } else {
            set _col_ {}
        }
        lappend _col_ $id
        set f_task_properties($task) $_col_
    }
    return $id
}
proc get_property_type_id { id } {
    variable f_property_type_id
    if { [ info exists f_property_type_id($id) ] } {
        return $f_property_type_id($id)
    } else {
        return {}
    }
}
proc property_delete { id } {
    variable g_del_list
    array unset g_del_list
    array set g_del_list {}

    if { ![ property_exists $id ] } {
        error "'property' with id '$id' does not exist."
    }
    property_pre_delete $id
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_can_delete"
        $proc_name $pk
    }
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_do_delete"
        $proc_name $pk
    }
    variable f_property_type_id
    unset f_property_type_id($id)
}
proc find_property_by_task_name { task name } {
    variable i_property_task_name
    set _key_ "$task,|,$name"
    if { [ info exists i_property_task_name($_key_) ] } {
        return $i_property_task_name($_key_)
    } else {
        return {}
    }
}
proc get_property_task { id } {
    variable f_property_task
    if { [ info exists f_property_task($id) ] } {
        return $f_property_task($id)
    } else {
        return {}
    }
}
proc set_property_task { id task } {
    if { ![ property_exists $id ] } {
        error "'property' with id '$id' does not exist."
    }
    set old [ get_property_task $id ]
    if { $old == $task } {
        return
    }
    set name [ get_property_name $id ]
    variable i_property_task_name
    set _key_ "$task,|,$name"
    if { [ info exists i_property_task_name($_key_) ] } {
        error "Fields 'task name' are not unique for 'property'."
    }
    if { $task != {} && ![ task_exists $task ] } {
        error "'task' with id '$task' does not exist."
    }
    if { $old != {} } {
        variable f_task_properties
        if { [ info exists f_task_properties($old) ] } {
            set _col_ $f_task_properties($old)
            set _index_ [ lsearch $_col_ $id ]
            if { $_index_ != -1 } {
                set _col_2 [ lreplace $_col_ $_index_ $_index_ ]
                set f_task_properties($old) $_col_2
            }
        }
    }
    set _key_ "$old,|,$name"
    unset i_property_task_name($_key_)
    variable f_property_task
    set f_property_task($id) $task
    variable i_property_task_name
    set _key_ "$task,|,$name"
    set i_property_task_name($_key_) $id
    if { $task != {} } {
        variable f_task_properties
        if { [ info exists f_task_properties($task) ] } {
            set _col_ $f_task_properties($task)
        } else {
            set _col_ {}
        }
        lappend _col_ $id
        set f_task_properties($task) $_col_
    }
}
proc get_property_name { id } {
    variable f_property_name
    if { [ info exists f_property_name($id) ] } {
        return $f_property_name($id)
    } else {
        return {}
    }
}
proc set_property_name { id name } {
    if { ![ property_exists $id ] } {
        error "'property' with id '$id' does not exist."
    }
    set old [ get_property_name $id ]
    if { $old == $name } {
        return
    }
    set task [ get_property_task $id ]
    variable i_property_task_name
    set _key_ "$task,|,$name"
    if { [ info exists i_property_task_name($_key_) ] } {
        error "Fields 'task name' are not unique for 'property'."
    }
    set _key_ "$task,|,$old"
    unset i_property_task_name($_key_)
    variable f_property_name
    set f_property_name($id) $name
    variable i_property_task_name
    set _key_ "$task,|,$name"
    set i_property_task_name($_key_) $id
}
proc get_property_is_empty { id } {
    variable f_property_is_empty
    if { [ info exists f_property_is_empty($id) ] } {
        return $f_property_is_empty($id)
    } else {
        return {}
    }
}
proc set_property_is_empty { id is_empty } {
    variable f_property_is_empty
    set f_property_is_empty($id) $is_empty
}
proc get_property_body { id } {
    variable f_property_body
    if { [ info exists f_property_body($id) ] } {
        return $f_property_body($id)
    } else {
        return {}
    }
}
proc set_property_body { id body } {
    variable f_property_body
    set f_property_body($id) $body
}
proc get_property_vars { id } {
    variable f_property_vars
    if { [ info exists f_property_vars($id) ] } {
        return $f_property_vars($id)
    } else {
        return {}
    }
}
proc set_property_vars { id vars } {
    variable f_property_vars
    set f_property_vars($id) $vars
}
proc get_property_signature { id } {
    variable f_property_signature
    if { [ info exists f_property_signature($id) ] } {
        return $f_property_signature($id)
    } else {
        return {}
    }
}
proc set_property_signature { id signature } {
    variable f_property_signature
    set f_property_signature($id) $signature
}
######### Private #########
variable g_del_list
array set g_del_list {}
variable f_task_rcount
array set f_task_rcount {}
variable f_task_type_id
array set f_task_type_id {}
variable g_task_next 1
variable f_task_name
array set f_task_name {}
variable f_task_properties
array set f_task_properties {}
variable f_property_rcount
array set f_property_rcount {}
variable f_property_type_id
array set f_property_type_id {}
variable g_property_next 1
variable f_property_task
array set f_property_task {}
variable f_property_name
array set f_property_name {}
variable f_property_is_empty
array set f_property_is_empty {}
variable f_property_body
array set f_property_body {}
variable f_property_vars
array set f_property_vars {}
variable f_property_signature
array set f_property_signature {}
variable i_task_name
array set i_task_name {}
variable i_property_task_name
array set i_property_task_name {}
proc task_pre_delete { id } {
    set type [ get_task_type_id $id ]
    variable g_del_list
    set key "$id,$type"
    if { [ info exists g_del_list($key) ] } {
        return
    } else {
        set g_del_list($key) 1
    }
    ${type}_pre_delete_middle $id
}
proc task_pre_delete_middle { id } {
    task_pre_delete_inner $id
}
proc task_pre_delete_inner { id } {
}
proc task_can_delete { id } {
    set properties [ get_task_properties $id ]
    foreach that $properties {
        variable g_del_list
        set _type_ [ get_property_type_id $that ]
        set _key_ "$that,$_type_"
        if { ![ info exists g_del_list($_key_) ] } {
            error "'task' with id '$id' is referenced by other record."
        }
    }
}
proc task_do_delete { id } {
    set name [ get_task_name $id ]
    variable i_task_name
    set _key_ "$name"
    unset i_task_name($_key_)
    variable f_task_name
    if { [ info exists f_task_name($id) ] } {
        unset f_task_name($id)
    }
    variable f_task_properties
    if { [ info exists f_task_properties($id) ] } {
        unset f_task_properties($id)
    }
    variable f_task_rcount
    unset f_task_rcount($id)
}
proc property_pre_delete { id } {
    set type [ get_property_type_id $id ]
    variable g_del_list
    set key "$id,$type"
    if { [ info exists g_del_list($key) ] } {
        return
    } else {
        set g_del_list($key) 1
    }
    ${type}_pre_delete_middle $id
}
proc property_pre_delete_middle { id } {
    property_pre_delete_inner $id
}
proc property_pre_delete_inner { id } {
}
proc property_can_delete { id } {
}
proc property_do_delete { id } {
    set task [ get_property_task $id ]
    if { $task != {} } {
        variable g_del_list
        set _type_ [ get_task_type_id $task ]
        set _key_ "$task,$_type_"
        if { ![ info exists g_del_list($_key_) ] } {
            variable f_task_properties
            if { [ info exists f_task_properties($task) ] } {
                set _col_ $f_task_properties($task)
                set _index_ [ lsearch $_col_ $id ]
                if { $_index_ != -1 } {
                    set _col_2 [ lreplace $_col_ $_index_ $_index_ ]
                    set f_task_properties($task) $_col_2
                }
            }
        }
    }
    set task [ get_property_task $id ]
    set name [ get_property_name $id ]
    variable i_property_task_name
    set _key_ "$task,|,$name"
    unset i_property_task_name($_key_)
    variable f_property_task
    if { [ info exists f_property_task($id) ] } {
        unset f_property_task($id)
    }
    variable f_property_name
    if { [ info exists f_property_name($id) ] } {
        unset f_property_name($id)
    }
    variable f_property_is_empty
    if { [ info exists f_property_is_empty($id) ] } {
        unset f_property_is_empty($id)
    }
    variable f_property_body
    if { [ info exists f_property_body($id) ] } {
        unset f_property_body($id)
    }
    variable f_property_vars
    if { [ info exists f_property_vars($id) ] } {
        unset f_property_vars($id)
    }
    variable f_property_signature
    if { [ info exists f_property_signature($id) ] } {
        unset f_property_signature($id)
    }
    variable f_property_rcount
    unset f_property_rcount($id)
}

proc add_dog { tokens } {
    #item 270
    set output {}
    #item 274
    set prev {}
    foreach token $tokens {
        #item 275
        lassign $token type text
        #item 276
        if {$prev == {}} {
            #item 279
            if {($type == "op") && ($text == "@")} {
                #item 283
                set prev $token
            } else {
                #item 286
                lappend output $token
            }
        } else {
            #item 284
            if {$type == "token"} {
                #item 292
                lappend output \
                  [ list "token" "@$text" ]
            } else {
                #item 288
                lappend output $prev
                #item 287
                lappend output $token
            }
            #item 290
            set prev {}
        }
    }
    #item 310
    if {$prev == {}} {
        
    } else {
        #item 313
        lappend output $prev
    }
    #item 271
    return $output
}

proc build_task_proc { task } {
    #item 111
    set task_id [ find_task_by_name $task ]
    #item 114
    set props [ get_task_properties $task_id ]
    #item 115
    set body {}
    foreach prop_id $props {
        #item 118
        set prop [ get_property_name $prop_id ]
        set is_empty [ get_property_is_empty $prop_id ]
        set algo [ make_algo_name $task $prop]
        #item 123
        lappend body "this._$prop = null"
        #item 120
        if {$is_empty} {
            #item 128
            lappend body "this.$prop = function\(newValue\) \{"
            lappend body "    if \(typeof newValue != \"undefined\"\) \{"
            lappend body "        this._$prop = newValue"
            lappend body "        return"  
            lappend body "    \}"
            #item 126
            lappend body "    return this._$prop"
        } else {
            #item 129
            lappend body "this.$prop = function\(\) \{"
            #item 125
            lappend body "    var value = this._$prop"
            lappend body "    if \(value != null\) \{"
            lappend body "        return value"
            lappend body "    \}"
            #item 119
            lappend body "    value = ${algo}.call\(this\)"
            #item 127
            lappend body "    this._$prop = value"
            lappend body "    return value"
        }
        #item 124
        lappend body "\}"
    }
    #item 113
    return [list -1 $task {procedure public {} {}} $body]
}

proc build_tasks { functions } {
    #item 74
    reset_db
    #item 75
    set tasks {}
    set prop_funs {}
    set other_funs {}
    foreach fun $functions {
        #item 45
        lassign $fun id name signature body
        #item 76
        lassign [ parse_name $name ] task prop
        #item 328
        if {$prop == ""} {
            #item 332
            lappend other_funs $fun
        } else {
            #item 46
            lappend tasks $task
            #item 331
            lappend prop_funs $fun
        }
    }
    #item 78
    set tasks [ lsort -unique $tasks ]
    foreach task $tasks {
        #item 84
        task_insert "" $task
    }
    foreach fun $prop_funs {
        #item 71
        lassign $fun id name signature body
        #item 86
        lassign [ parse_name $name ] task prop
        #item 73
        set is_empty \
        [is_empty_body $body]
        #item 91
        set task_id [ find_task_by_name $task ]
        #item 87
        set prop_id \
        [property_insert $id $task_id $prop]
        #item 72
        set_property_is_empty $prop_id $is_empty
        set_property_body $prop_id $body
        set_property_signature $prop_id $signature
    }
    foreach task $tasks {
        #item 135
        set task_id [ find_task_by_name $task ]
        set props [ get_task_properties $task_id ]
        set names [ get_task_prop_names $task_id ]
        foreach prop_id $props {
            #item 130
            enrich_body $task_id $prop_id $task $names
        }
    }
    foreach task $tasks {
        #item 339
        set task_id [ find_task_by_name $task ]
        set props [ get_task_properties $task_id ]
        foreach prop_id $props {
            #item 343
            set prop_name [ get_property_name $prop_id ]
            set signature [ get_property_signature $prop_id ]
            set empty [ get_property_is_empty $prop_id ]
            set body [ get_property_body $prop_id ]
            set algo [ make_algo_name $task $prop_name ]
            #item 345
            if {$empty} {
                
            } else {
                #item 337
                set fun2 [ list $prop_id $algo {} $body ]
                lappend other_funs $fun2
                #item 361
                if {[is_output $signature]} {
                    #item 362
                    set invoker [ make_invoker $task_id $prop_id ]
                    lappend other_funs $invoker
                } else {
                    
                }
            }
        }
    }
    foreach task $tasks {
        #item 95
        set task_proc [ build_task_proc $task ]
        #item 96
        lappend other_funs $task_proc
    }
    #item 333
    set all_funs $other_funs
    #item 44
    return $all_funs
}

proc contains_dot { text } {
    #item 11
    set pos \
    [string first "." $text]
    #item 7
    if {$pos == -1} {
        #item 10
        return 0
    } else {
        #item 6
        return 1
    }
}

proc enrich_body { task_id prop_id task names } {
    #item 153
    set body [ get_property_body $prop_id ]
    set prop_name [ get_property_name $prop_id ]
    #item 169
    set body2 {}
    set vars {}
    foreach line $body {
        #item 170
        lassign [ substitute_vars $task $prop_name $line $names ] \
           line_vars line2
        #item 323
        lappend body2 $line2
        #item 324
        set vars [ concat $vars $line_vars ]
    }
    #item 325
    set_property_body $prop_id $body2
    #item 326
    set vars [ lsort -unique $vars ]
    #item 327
    set_property_vars $prop_id $vars
}

proc find_vars { task_id prop_id } {
    #item 393
    variable src_vars
    #item 394
    set src_vars {}
    #item 397
    set task [ get_task_name $task_id ] 
    set name [ get_property_name $prop_id ]
    #item 396
    find_vars_core $task_id $name $prop_id {}
    #item 395
    set result [ lsort -unique $src_vars ]
    #item 424
    return $result
}

proc find_vars_core { task_id original prop_id stack } {
    #item 403
    variable src_vars
    #item 409
    set name [ get_property_name $prop_id ]
    #item 404
    if {[lsearch $stack $name] == -1} {
        #item 420
        lappend stack $name
        #item 408
        set vars [ get_property_vars $prop_id ]
        #item 410
        if {$vars == {}} {
            #item 412
            lappend src_vars $name
        } else {
            foreach var $vars {
                #item 415
                set id [ find_property_by_task_name $task_id $var ]
                #item 416
                find_vars_core $task_id $original $id $stack
            }
        }
    } else {
        #item 417
        set task [ get_task_name $task_id ]
        #item 407
        error "$task.$original: cycle detected at $name"
    }
}

proc format_args { vars } {
    #item 382
    set result {}
    foreach arg $vars {
        #item 386
        lappend result [list $arg {}]
    }
    #item 383
    return $result
}

proc get_task_prop_names { task_id } {
    #item 159
    set props [ get_task_properties $task_id ]
    #item 162
    set result {}
    foreach prop_id $props {
        #item 164
        set name [ get_property_name $prop_id ]
        #item 165
        lappend result $name
    }
    #item 163
    return $result
}

proc is_empty_body { body } {
    #item 52
    if {[llength $body] == 1} {
        #item 55
        set line1 [ lindex $body 0 ]
        #item 56
        if {$line1 == {}} {
            #item 57
            return 1
        } else {
            #item 58
            return 0
        }
    } else {
        #item 58
        return 0
    }
}

proc is_output { signature } {
    #item 354
    set params [ lindex $signature 2 ]
    #item 355
    set line1 [ lindex $params 0 ]
    set directive [ lindex $line1 0 ]
    #item 356
    if {$directive == "#output"} {
        #item 359
        return 1
    } else {
        #item 360
        return 0
    }
}

proc is_this { type text } {
    #item 239
    if {($type == "token") && ($text == "this")} {
        #item 243
        return 1
    } else {
        #item 244
        return 0
    }
}

proc is_variable { type text } {
    #item 250
    if {($type == "token") && ([string match @* $text])} {
        #item 254
        return 1
    } else {
        #item 255
        return 0
    }
}

proc join_tokens { tokens } {
    #item 301
    set result ""
    foreach token $tokens {
        #item 303
        set text [ lindex $token 1 ]
        #item 304
        append result $text
    }
    #item 302
    return $result
}

proc make_algo_name { task prop } {
    #item 320
    return "${task}__p_$prop"
}

proc make_invoker { task_id prop_id } {
    #item 368
    set task [ get_task_name $task_id ]
    set prop [ get_property_name $prop_id ]
    #item 387
    set vars [ find_vars $task_id $prop_id ]
    #item 376
    set args [ format_args $vars ]
    #item 374
    set signature [list procedure public $args {}]
    #item 369
    set name "${task}_${prop}"
    #item 371
    set body {}
    #item 372
    lappend body "var _task = new $task\(\)"
    foreach var $vars {
        #item 427
        lappend body "_task.$var\($var\)"
    }
    #item 373
    lappend body "return _task.$prop\(\)"
    #item 370
    return [ list {} $name $signature $body ]
}

proc normalize_name { text } {
    #item 25
    if {[contains_dot $text]} {
        #item 321
        lassign [parse_name $text] task prop
        #item 28
        return [ make_algo_name $task $prop]
    } else {
        #item 30
        return $text
    }
}

proc parse_name { text } {
    #item 18
    set parts \
    [split $text "."]
    #item 19
    return $parts
}

proc substitute_vars { task prop_name line names } {
    #item 262
    set vars {}
    set line2 ""
    #item 185
    set trimmed [ string trim $line ]
    #item 186
    if {([string match //* $trimmed]) || ($trimmed == "")} {
        #item 344
        set line2 $line
    } else {
        #item 189
        set tokens [hl::lex $line]
        #item 293
        set tokens [ add_dog $tokens ]
        #item 191
        set tokens2 {}
        
        set normal_192 1
        foreach token $tokens {
            #item 197
            lassign $token type text
            #item 227
            if {[is_this $type $text]} {
                #item 233
                error \
                 "$task.$prop_name: no access to this object"
                set normal_192 0
                break
            } else {
                
            }
            #item 194
            if {[is_variable $type $text]} {
                #item 261
                set clean [ string range $text 1 end ]
                #item 257
                if {[lsearch $names $clean] == -1} {
                    #item 260
                    error \
                     "$task.$prop_name: unknown var $text"
                    set normal_192 0
                    break
                } else {
                    
                }
                #item 263
                lappend vars $clean
                #item 256
                lappend tokens2 \
                  [list "token" "this.$clean\(\)"]
            } else {
                #item 200
                lappend tokens2 $token
            }
        }
        if {$normal_192 == 1} {
            #item 314
            set line2 [ join_tokens $tokens2 ]
        }
    }
    #item 322
    return [ list $vars $line2 ]
}

}
