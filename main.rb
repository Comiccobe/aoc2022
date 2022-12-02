part_1 = 0
part_2 = 0
File.readlines("input.txt").each do |l|
  part_1 += (l[2].ord - 87) + 
             ([3, 6, 0][((-(l[0].ord - 65)) + (l[2].ord - 88)) % 3])
  part_2 += ([1,2,3][((l[0].ord - 65 + 2) + (l[2].ord - 88)) % 3]) +
             ((l[2].ord - 88) * 3)
end
puts part_1
puts part_2