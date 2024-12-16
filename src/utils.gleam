import gleam/int
import gleam/list
import gleam/string
import simplifile

pub fn get_lines(filepath: String) {
  let assert Ok(content) = simplifile.read(filepath)
  content
  |> string.split("\n")
}

pub fn line_to_list_nums(line: String) {
  line |> string.split(" ") |> list.map(unsafe_parse_int)
}

pub fn unsafe_parse_int(number: String) {
  let assert Ok(string_as_number) = int.parse(number)
  string_as_number
}
