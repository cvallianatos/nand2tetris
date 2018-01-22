# HACK CPU Assemler

def isValid(arg)
# Checking if the line is blank or a comment
   if arg.length > 0
      if arg[0] == "/"
         return false
      else
         return true
      end
   end
end

def A_Instruction(arg, o_file)
   label = Hash.new

   label["SP"] = 0
   label["LCL"] = 1
   label["ARG"] = 2
   label["THIS"] = 3
   label["THAT"] = 4
   label["R0"] = 0
   label["R1"] = 1
   label["R2"] = 2
   label["R3"] = 3
   label["R4"] = 4
   label["R5"] = 5
   label["R6"] = 6
   label["R7"] = 7
   label["R8"] = 8
   label["R9"] = 9
   label["R10"] = 10
   label["R11"] = 11
   label["R12"] = 12
   label["R13"] = 13
   label["R14"] = 14
   label["R15"] = 15
   label["SCREEN"] = 16384
   label["KBD"] = 24576

   # Check if it is a label
    length = arg.length
    str = arg[1..length-1]
    # Check if it is a numeric
#    if str !~ /\D/ 
      o_file.print "0","%015b" % str,"\n" 
    # It is a label. So check if it already exists in the labels array, if not go to the last element and add it
#    end
end

def C_Instruction(arg, o_file)

 comp = Hash.new
   comp["0"] = "0101010"
   comp["1"] = "0111111"
   comp["-1"] = "0111010"
   comp["D"] = "0001100"
   comp["A"] = "0110000"
   comp["!D"] ="0001101"
   comp["!A"] = "0110001"
   comp["-D"] = "0001111"
   comp["-A"] = "0110011"
   comp["D+1"] = "0011111"
   comp["A+1"] = "0110111"
   comp["D-1"] = "0001110"
   comp["A-1"] = "0110010"
   comp["D+A"] = "0000010"
   comp["D-A"] = "0010011"
   comp["A-D"] = "0000111"
   comp["D&A"] = "0000000"
   comp["D|A"] = "0010101"
   comp["M"] = "1110000"
   comp["!M"] = "1110001"
   comp["-M"] = "1110011"
   comp["M+1"] = "1110111"
   comp["M-1"] = "1110010"
   comp["D+M"] = "1000010"
   comp["D-M"] = "1010011"
   comp["M-D"] = "1000111"
   comp["D&M"] = "1000000"
   comp["D|M"] = "1010101"

   dest = Hash.new
   jump = Hash.new

   dest["null"] = "000"
   dest["M"] = "001"
   dest["D"] = "010"
   dest["MD"] = "011"
   dest["A"] = "100"
   dest["AM"] = "101"
   dest["AD"] = "110"
   dest["AMD"] = "111"

   jump["null"] = "000"
   jump["JGT"] = "001"
   jump["JEQ"] = "010"
   jump["JGE"] = "011"
   jump["JLT"] = "100"
   jump["JNE"] = "101"
   jump["JLR"] = "110"
   jump["JMP"] = "111"

    str1 = arg.split('=')
    str2 = str1[1].split(';')
#   print str2, "\n"
    if str2.length == 1
       o_file.print "111”,comp[str1[1]],dest[str1[0]],jump['null'],"\n" 
    end
end

i = 0
a = Array.new
b = Array.new
lineCount = 0
  

# Open asm file for reading

puts "Enter assembler program file name: "
fname = gets
fname = fname.chomp
myFile = File.open(fname+".hack", "w")

File.open(fname+".asm").readlines.each do |line|
   lineCount = lineCount + 1
   a[i] = line.gsub "\r\n", ""
   print i, " ------> ",a[i], "\n"   
   i = i + 1
end

print "***************************\n"

# Print only valid program lines

j = 0
for i in 0..lineCount - 1
	if isValid(a[i])
		b[j] = a[i]
                print b[j], "\n"
		j = j + 1
	end
end 
validLines = j

for i in 0..validLines - 1
   if b[i][0] == "@"
      A_Instruction(b[i], myFile)
   else
      if b[i][0] == "("
         Label_Instruction(arg, myFile)
      else
         C_Instruction(b[i], myFile)
      end
   end
end
myFile.close  