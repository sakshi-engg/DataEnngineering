#create a list 
shoppingcart = ["apple","banana","cherry"]
print("Initial List - ",shoppingcart)

#add new item bread
shoppingcart.append("bread")
print("List after adding bread - ", shoppingcart[-1])

#remove banana
del(shoppingcart[1])
print("List after removing banana - ", shoppingcart)

#check is cherry present
for i in range(len(shoppingcart)):
    curItem= shoppingcart[i]
    if(curItem == 'cherry'):
        print("Cheery is present at index",i)   

#print total items in list
print("Printing total items using print() - ", shoppingcart)

#Printing list using for loop
print("Printing using for loop")
for i in range(len(shoppingcart)):
    print("Items at index ",i, "is ",shoppingcart[i])

t=['s',2]
print(t)
t=('s',2)
print(t)
print(type(t))
