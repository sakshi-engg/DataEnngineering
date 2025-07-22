def calculator():
    print("Welcome to Simple Calculator")

    num1 = float(input("Enter first number: "))
    num2 = float(input("Enter second number: "))

    print("\nChoose operation:")
    print("1. Add (+)")
    print("2. Subtract (-)")
    print("3. Multiply (*)")
    print("4. Divide (/)")

    choice = input("Enter your choice (1/2/3/4): ")

    if choice == '1':
        print(f"\nResult: {num1} + {num2} = {num1 + num2}")
    elif choice == '2':
        print(f"\nResult: {num1} - {num2} = {num1 - num2}")
    elif choice == '3':
        print(f"\nResult: {num1} * {num2} = {num1 * num2}")
    elif choice == '4':
        if num2 == 0:
            print("\nError: Cannot divide by zero!")
        else:
            print(f"\nResult: {num1} / {num2} = {num1 / num2}")
    else:
        print("\n Invalid choice! Please select 1 to 4.")

calculator()
