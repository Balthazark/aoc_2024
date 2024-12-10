import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

fn create_sorted_list(tuples: List(#(Int, Int))) {
  let list1 =
    list.map(tuples, fn(tuple) { tuple.0 })
    |> list.sort(int.compare)

  let list2 =
    list.map(tuples, fn(tuple) { tuple.1 })
    |> list.sort(int.compare)

  list.zip(list1, list2)
}

fn create_similarty_list(tuples: List(#(Int, Int))) {
  let list1 = list.map(tuples, fn(tuple) { tuple.0 })
  let list2 = list.map(tuples, fn(tuple) { tuple.1 })
  list1 |> list.map(fn(num) { num * list.count(list2, fn(a) { num == a }) })
}

fn part_1() {
  let filepath = "src/day_01/input.txt"
  let assert Ok(content) = simplifile.read(filepath)
  content
  |> string.split("\n")
  |> list.map(fn(pair_with_spaces) { string.split(pair_with_spaces, "   ") })
  |> list.map(fn(pair_without_spaces) {
    let assert Ok(firsts) = list.first(pair_without_spaces)
    let assert Ok(seconds) = list.last(pair_without_spaces)
    let assert Ok(firsts_as_number) = int.parse(firsts)
    let assert Ok(seconds_as_number) = int.parse(seconds)
    #(firsts_as_number, seconds_as_number)
  })
  |> create_sorted_list()
  |> list.map(fn(sorted_pairs) {
    int.absolute_value(sorted_pairs.0 - sorted_pairs.1)
  })
  |> list.fold(0, int.add)
}

fn part_2() {
  let filepath = "src/day_01/input_p2.txt"
  let assert Ok(content) = simplifile.read(filepath)
  content
  |> string.split("\n")
  |> list.map(fn(pair_with_spaces) { string.split(pair_with_spaces, "   ") })
  |> list.map(fn(pair_without_spaces) {
    let assert Ok(firsts) = list.first(pair_without_spaces)
    let assert Ok(seconds) = list.last(pair_without_spaces)
    let assert Ok(firsts_as_number) = int.parse(firsts)
    let assert Ok(seconds_as_number) = int.parse(seconds)
    #(firsts_as_number, seconds_as_number)
  })
  |> create_similarty_list()
  |> list.fold(0, int.add)
}

pub fn main() {
  part_1() |> io.debug()
  part_2() |> io.debug()
}
