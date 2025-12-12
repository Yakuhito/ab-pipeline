import pandas as pd
import os

ls = open("DEG.fasta", "r").read().strip().split("\n")
curr_protein_text = ""
output = ""
for l in ls:
	if l.startswith(">"):
		if curr_protein_text != "":
			if "Not available" not in curr_protein_text:
				output += curr_protein_text + "\n"
		curr_protein_text = l + "\n"
	else:
		curr_protein_text += l.replace("$", "")

if "Not available" not in curr_protein_text:
	output += curr_protein_text

f = open("DEG_filtered.fasta", "w")
f.write(output)
