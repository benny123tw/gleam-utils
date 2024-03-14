import gleam/int
import gleam/list
import gleam/string
import gleam/result

pub fn distance(one: String, other: String) -> Int {
  case one, other {
    _, _ if one == other -> 0
    "", string | string, "" -> string.length(string)
    one, other -> {
      let one = string.to_graphemes(one)
      let other = string.to_graphemes(other)
      do_distance(one, other, list.range(0, list.length(other)), 1)
    }
  }
}

fn do_distance(
  one: List(String),
  other: List(String),
  distance_list: List(Int),
  step: Int,
) -> Int {
  case one {
    [] ->
      list.last(distance_list)
      |> result.unwrap(-1)
    [first, ..rest] -> {
      update_distance_list(other, distance_list, first, step, [step])
      |> do_distance(rest, other, _, step + 1)
    }
  }
}

fn update_distance_list(
  other: List(String),
  distance_list: List(Int),
  grapheme: String,
  last_distance: Int,
  acc: List(Int),
) -> List(Int) {
  case other, distance_list {
    [], _ -> list.reverse(acc)
    [first, ..rest], [first_dist, ..rest_dist] -> {
      let difference = case grapheme == first {
        True -> 0
        False -> 1
      }
      let min = int.min(first_dist + difference, last_distance + 1)
      let min = case rest_dist {
        [second_dist, ..] -> int.min(min, second_dist + 1)
        _ -> min
      }
      update_distance_list(rest, rest_dist, grapheme, min, [min, ..acc])
    }
    _, [] -> panic("Invalid state")
  }
}
