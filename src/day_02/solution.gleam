import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import utils

fn is_within_threshold(pair: #(Int, Int)) {
  let threshold = int.absolute_value(pair.0 - pair.1)
  threshold < 4 && threshold > 0
}

fn is_safe_report(list_of_pairs: List(#(Int, Int))) {
  let only_increasing_report =
    list.all(list_of_pairs, fn(pair) {
      pair.0 < pair.1 && is_within_threshold(pair)
    })
  let only_decreasing_report =
    list.all(list_of_pairs, fn(pair) {
      pair.0 > pair.1 && is_within_threshold(pair)
    })

  bool.exclusive_or(only_increasing_report, only_decreasing_report)
}

fn create_report_variatons(report: List(Int)) {
  let variatons = report
  variatons
  |> list.repeat(list.length(report))
  |> list.index_map(fn(variaton, index) {
    list.append(list.take(variaton, index), list.drop(variaton, index + 1))
    |> list.window_by_2
  })
}

fn check_report_variations(report_varations: List(List(#(Int, Int)))) {
  report_varations |> list.map(is_safe_report)
}

fn part_1() {
  utils.get_lines("src/day_02/input_p1.txt")
  |> list.map(utils.line_to_list_nums)
  |> list.map(list.window_by_2)
  |> list.map(is_safe_report)
  |> list.filter(fn(ok_report) { ok_report })
  |> list.length()
}

fn part_2() {
  utils.get_lines("src/day_02/input_p1.txt")
  |> list.map(utils.line_to_list_nums)
  |> list.map(create_report_variatons)
  |> list.map(check_report_variations)
  |> list.filter(fn(report) { list.contains(report, True) })
  |> list.length()
}

pub fn main() {
  part_1() |> io.debug()
  io.println("")
  part_2() |> io.debug()
}
