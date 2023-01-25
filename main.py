instructions = {
    "set_immediate":                 "0000",
    "set_register":                  "0001",
    "set_memory":                    "0010",
    "set_LUT":                       "0011",
    "move":                          "0100",
    "store":                         "0101",
    "jump":                          "0110",
    "and_register":                  "0111",
    "or_register":                   "1000",
    "xor_register":                  "1001",
    "right_shift":                   "1010",
    "left_shift":                    "1011",
    "reduced_xor":                   "1100",
    "add_immediate":                 "1101",
    "not_equal_register":            "1110",
    "done":                          "1111"
}

registers = {
  "r0":  "00000",
  "r1":  "00001",
  "r2":  "00010",
  "r3":  "00011",
  "r4":  "00100",
  "r5":  "00101",
  "r6":  "00110",
  "r7":  "00111",
  "r8":  "01000",
  "r9":  "01001",
  "r10": "01010",
  "r11": "01011",
  "r12": "01100",
  "r13": "01101",
  "r14": "01110",
  "r15": "01111"
}

assembly = open("assembly.txt","r")
machine = open("machine_code","a")
machine.truncate(0)
while(True):
  #read next line
  line = assembly.readline()
  #if line is empty, you are done with all lines in the file
  if not line:
    break
  #you can access the line

  words = line.replace("\n", "").split(" ")

  if (not words[0] in instructions):
    
    print("its fucked: ", "|" + words[0] + "|")
    break 
  str = instructions[words[0]]
  if (len(words) > 1):
    if (words[1] in registers):
      machine.write(registers[words[1]])
    elif (len(words[1]) > 0):
      print(words)
      # Changes immediate values formatted #num to 5 bit binary
      immediate = int(words[1].replace("#",""))
      binary = format(immediate, '#07b')
      binary = binary.replace("0b","")
      str += binary

  if (len(str) < 9):
     print(str, " ", len(str))
     str += "00000"
  machine.write(str+"\n")
assembly.close()
machine.close()