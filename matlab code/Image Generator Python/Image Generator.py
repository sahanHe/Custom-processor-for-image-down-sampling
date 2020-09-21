fout = open("Imageout.txt","w")
fin = open("Image.txt","r")
count=0
for line in fin:
    line = line[:-1]
    fout.write("\t")
    fout.write(str(count))
    fout.write("\t")
    fout.write(":")
    fout.write("\t")
    fout.write(line)
    fout.write(";")
    fout.write("\n")

    count += 1