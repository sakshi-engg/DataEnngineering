#Numpy Functions
import numpy as np

na = np.array([[4,5,6,7], [5,6,7,8]])
print(na)

#create an array 4*4 reshape to 1*16
import numpy as np

arr = np.arange(1, 17).reshape(4, 4)
print("Original 4x4 array:\n", arr)

reshaped = arr.reshape(1, 16)
print("\nReshaped to 1x16:\n", reshaped)

a=np.arange(1,11,2).reshape(5,1)
print(a)

