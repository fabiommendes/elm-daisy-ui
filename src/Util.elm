module Util exposing (..)


iff : Bool -> c -> c -> c
iff a b c =
    if a then
        b

    else
        c


runConfig : a -> List (a -> a) -> a
runConfig init props =
    List.foldl (\f acc -> f acc) init props


mcons : Maybe a -> List a -> List a
mcons mx xs =
    case mx of
        Just x ->
            x :: xs

        _ ->
            xs
