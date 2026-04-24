data = str(input("enter machine code: "))
length = int(input("enter length: "))


j=0
for i in range(length+1):
    print(f'when {i} => data <= "{data[j:j+16]}";')
    j += 16