
Require Import CoqOfOCaml.CoqOfOCaml.
Require Import CoqOfOCaml.Settings.



Inductive keyword : Set :=
| Todo : keyword
| Done : keyword
| Other : string -> keyword.

Module date.
  Record record : Set := Build {
    day : int;
    month : int;
    year : int;
  }.
  Definition with_day day (r : record) :=
    Build day r.(month) r.(year).
  Definition with_month month (r : record) :=
    Build r.(day) month r.(year).
  Definition with_year year (r : record) :=
    Build r.(day) r.(month) year.
End date.
Definition date := date.record.

Module time.
  Record record : Set := Build {
    hour : int;
    minutes : int;
  }.
  Definition with_hour hour (r : record) :=
    Build hour r.(minutes).
  Definition with_minutes minutes (r : record) :=
    Build r.(hour) minutes.
End time.
Definition time := time.record.

Inductive repeater_type : Set :=
| Cumulate : repeater_type
| CatchUp : repeater_type
| Restart : repeater_type.

Inductive time_inc : Set :=
| Hours : time_inc
| Days : time_inc
| Weeks : time_inc
| Months : time_inc
| Years : time_inc.

Definition repeater : Set := repeater_type * int * time_inc.

Inductive warning_delay_type : Set :=
| AllOccurrences : warning_delay_type
| FirstOccurrence : warning_delay_type.

Definition warning_delay : Set := warning_delay_type * int * time_inc.

Inductive repeater_or_delay : Set :=
| Repeater : repeater -> repeater_or_delay
| Delay : warning_delay -> repeater_or_delay.

Module single_timestamp.
  Record record : Set := Build {
    active : bool;
    date : date;
    time : option time;
    repeat : option repeater;
    warning : option warning_delay;
  }.
  Definition with_active active (r : record) :=
    Build active r.(date) r.(time) r.(repeat) r.(warning).
  Definition with_date date (r : record) :=
    Build r.(active) date r.(time) r.(repeat) r.(warning).
  Definition with_time time (r : record) :=
    Build r.(active) r.(date) time r.(repeat) r.(warning).
  Definition with_repeat repeat (r : record) :=
    Build r.(active) r.(date) r.(time) repeat r.(warning).
  Definition with_warning warning (r : record) :=
    Build r.(active) r.(date) r.(time) r.(repeat) warning.
End single_timestamp.
Definition single_timestamp := single_timestamp.record.

Inductive timestamp : Set :=
| Timestamp : single_timestamp -> timestamp
| Range : single_timestamp -> single_timestamp -> timestamp
| HourRange : single_timestamp -> time -> timestamp.

Inductive planning_type : Set :=
| Deadline : planning_type
| Scheduled : planning_type
| Closed : planning_type.

Definition planning : Set := planning_type * timestamp.

Inductive item (tick_sec : Set) : Set :=
| Item :
  int -> bool -> option keyword -> option ascii -> string -> list string ->
  list timestamp -> list planning -> list tick_sec -> list (item tick_sec) ->
  item tick_sec.

Arguments Item {_}.
