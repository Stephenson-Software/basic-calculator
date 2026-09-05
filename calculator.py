firstnumber = float(raw_input("What is the first number? "))
secondnumber = float(raw_input("What is the second number? "))
whatToDo = (raw_input("Add, Subract, Multiply or Divide? ")).upper()

if (whatToDo == "ADD"):
	print "The answer is ", (firstnumber + secondnumber)
elif (whatToDo == "SUBRACT"):
	print "The answer is ", (firstnumber - secondnumber)
elif (whatToDo == "MULTIPLY"):
	print "The answer is ", (firstnumber * secondnumber)
elif (whatToDo == "DIVIDE"):
	if (secondnumber == 0):
		print "The second number can't be zero."
	else:
		print "The answer is ", (firstnumber / secondnumber), " with ", (firstnumber % secondnumber), " left over."
else:
	print "That wasn't an option."

raw_input("\nPress Enter to exit.")
