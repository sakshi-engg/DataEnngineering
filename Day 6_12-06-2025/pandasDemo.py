#series
l=[1,2,3,4]
import pandas as pd
#1-d
s=pd.Series(l, index=['a','b','c','d'])
print(s)

#dict
d={'a':2,'c':4,'e':4,'v':6}
se=pd.Series(d,index=['a','c','e','v','r','g'])
print(se)

#Pandas Dataframe
web={'visitors':[200,300,400,500],'day':[1,2,3,4],'bounce':[100,200,120,50]}
df=pd.DataFrame(web)
print(df)

print(df.head(2)) #first 2 rows
print(df.tail(2)) #last 2 columns



