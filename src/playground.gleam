import utils/levenshtein
import gleam/io

pub fn main() {
  levenshtein.distance("kitten", "sitting")
  |> io.debug
}
