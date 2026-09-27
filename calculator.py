try:
	firstnumber = float(raw_input("What is the first number? "))
	secondnumber = float(raw_input("What is the second number? "))
except ValueError:
	raw_input("That wasn't a number.\n\nPress Enter to exit.")
	raise SystemExit
whatToDo = (raw_input("Add, Subtract, Multiply or Divide? ")).strip().upper()

if (whatToDo == "ADD"):
	print "The answer is ", (firstnumber + secondnumber)
elif (whatToDo == "SUBTRACT" or whatToDo == "SUBRACT"):
	print "The answer is ", (firstnumber - secondnumber)
elif (whatToDo == "MULTIPLY"):
	print "The answer is ", (firstnumber * secondnumber)
elif (whatToDo == "DIVIDE"):
	if (secondnumber == 0):
		print "The second number can't be zero."
	else:
		print "The answer is ", (firstnumber / secondnumber), " with ", (firstnumber % secondnumber), " left over."
else:
	print "That wasn't an option. The options are Add, Subtract, Multiply or Divide."

raw_input("\nPress Enter to exit.")
