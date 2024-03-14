import gleeunit/should
import utils/levenshtein

pub fn levenshtein_distance_test() {
  levenshtein.distance("kitten", "sitting")
  |> should.equal(3)
  levenshtein.distance("kitten test play2", "sitting test play")
  |> should.equal(4)
}
