package main

import "core:fmt"
import "core:os"
import "core:strings"

main :: proc() {
  data, ok := os.read_entire_file("input.txt");
  if !ok {
    fmt.println("Can't read file.");
    return;
  }
  defer delete(data, context.allocator);

	input := string(data);
  for character, i in input {
    if i > 2 {
      unique := true;
      for j := i - 3; j < i+1; j += 1 {
    	  for k := j + 1; k < i+1; k += 1 {
    	    if input[j] == input[k] {
            unique = false;
          }
        }
      }
      if unique == true {
        fmt.println("Part 1: ", i + 1);
        break;
      }
    }
  }
  for character, i in input {
    if i > 12 {
      unique := true;
      for j := i - 13; j < i+1; j += 1 {
    	  for k := j + 1; k < i+1; k += 1 {
    	    if input[j] == input[k] {
            unique = false;
          }
        }
      }
      if unique == true {
        fmt.println("Part 2: ", i + 1);
        break;
      }
    }
  }
};