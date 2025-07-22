list=[]
print(type(list))

list1=['p','c','b','m',94,99,99,98]
#list slicing
print(list1)
print(list1[0])
print(list1[-1])
print(list1[0:2])
#double slicing
print(list1[0][0])
print(list1+['h1']) #add element at the end of the list

list1[0] = 'maths'
print(list1)

#delete an element from the list
del(list1[0])
print(list1)

#append
list1.append('C Sharp')
print(list1)

list1[0] = "Sakshi"

#extend 
list1.extend(['a','b',2])
print(list1)

