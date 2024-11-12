let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for d in 1...10
{
  print(d)
}

for score in individualScores 
{
      if score > 50 
      {
        teamScore += 3
 }
  else {
       teamScore += 1
       }
 }
 print(teamScore)

var numbers = [1,2,3,4,5]

for number in numbers {
   print(number)
}

// nested loop
let levels = 4

for i in 1...levels + 1 {
    for _ in 1...i {
        print(i,terminator:"")
    }
    
    print() // Move to the next line after each row
}
