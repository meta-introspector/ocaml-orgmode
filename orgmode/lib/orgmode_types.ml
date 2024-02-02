type keyword =
  | Todo
  | Done
  | Other of string

type date = {
    day   : int;
    month : int;
    year  : int;
  }

type time = {
    hour    : int;
    minutes : int;
  }

type repeater_type =
    Cumulate  (* +  *)
  | CatchUp   (* ++ *)
  | Restart   (* .+ *)

type time_inc =
    Hours
  | Days
  | Weeks
  | Months
  | Years

type repeater = repeater_type * int * time_inc

type warning_delay_type =
    AllOccurrences  (* -  *)
  | FirstOccurrence (* -- *)

type warning_delay = warning_delay_type * int * time_inc

type repeater_or_delay =
    Repeater of repeater
  | Delay of warning_delay

type single_timestamp = {
    active  : bool;
    date    : date;
    time    : time option;
    repeat  : repeater option;
    warning : warning_delay option;
  }

type timestamp =
  | Timestamp of single_timestamp
  | Range of single_timestamp * single_timestamp
  | HourRange of single_timestamp * time

type planning_type =
  | Deadline
  | Scheduled
  | Closed

type planning = planning_type * timestamp


type 'tick_sec item =
  | Item of int * bool * keyword option * char option * string * string list * timestamp list
  (*planning*)
            * planning list
  (*secct*)
            * 'tick_sec list
  (*cate*)
            * 'tick_sec item list


                
(* type 'tick_sec item = {  *)
(*     level      : int; *)
(*     commented  : bool; *)
(*     keyword    : keyword option; *)
(*     priority   : char option; *)
(*     title      : string; *)
(*     tags       : string list; *)
(*     dates      : timestamp list; *)
(*     planning   : planning list; *)
(*     (\* sections   : 'tick_sec list; *\) *)
(*     (\* categories : 'tick_sec item list; *\) *)
(*   } *)


