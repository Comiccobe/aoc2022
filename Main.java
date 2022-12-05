import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

class Main {
  public static void main(String[] args) {
    try {
			Scanner scanner = new Scanner(new File("input.txt"));
      int part1 = 0;
      int part2 = 0;

			while (scanner.hasNextLine()) {
        String line = scanner.nextLine();
        String[] parts = line.split(",");
        
        String[] range1 = parts[0].split("-");
        int min1 = Integer.parseInt(range1[0]);
        int max1 = Integer.parseInt(range1[1]);

        String[] range2 = parts[1].split("-");
        int min2 = Integer.parseInt(range2[0]);
        int max2 = Integer.parseInt(range2[1]);

        if (min1 >= min2 && max1 <= max2) {
          part1++;
        } else if (min2 >= min1 && max2 <= max1) {
          part1++;
        }

        if (min1 <= max2 && max1 >= min2) {
          part2++;
        }
			}
			scanner.close();

      System.out.println("Part 1: " + part1);
      System.out.println("Part 2: " + part2);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
  }
}