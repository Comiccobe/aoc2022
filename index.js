const r = require("fs")
  .readFileSync("input.txt")
  .toString()
  .split("\n")
  .map(l => l
    .split('')
    .map(c => c.charCodeAt(0))
    .map(n => n > 90 ? n - 96 : n - 38))

console.log(
  "Part 1: ", 
  r.map(l => [l.slice(0, l.length / 2), l.slice(-l.length / 2)])
   .map(l => l[0].filter(v => l[1].includes(v)))
   .map(l => l.filter((v, i, s) => s.indexOf(v) === i))
   .flat()
   .reduce((a, n) => a + n, 0),
  "Part 2: ",
  r.reduce(
    (a, l, i) => !a[Math.floor(i/3)]
      ? [...a, [l]]
      : [...a.slice(0, -1), [...a[a.length-1], l]],
    [])
  .map(g => g[0].filter(v => g[1].includes(v) && g[2].includes(v)))
  .map(l => l.filter((v, i, s) => s.indexOf(v) === i))
  .flat()
  .reduce((a, n) => a + n, 0)
)