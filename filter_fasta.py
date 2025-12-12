import sys

if len(sys.argv) != 5 or sys.argv[1] not in ['include', 'exclude']:
	print("Usage: python3 filter_fasta.py [include|excplude] input.fasta source.tab output.fasta")

include = sys.argv[1] == 'include'
input_fasta = sys.argv[2]
input_tab = sys.argv[3]
output_fasta = sys.argv[4]

ls = open(input_fasta, "r").read().strip().split("\n")
curr_protein_id = ""
curr_protein_text = ""
n = 0
prots = {}
for l in ls:
	if l.startswith(">"):
		if curr_protein_id != "":
			prots[curr_protein_id] = curr_protein_text
			n += 1
		curr_protein_id = l.split(">")[1].split(" ")[0]
		curr_protein_text = l + "\n"
	else:
		curr_protein_text += l

prots[curr_protein_id] = curr_protein_text
n += 1

print(f"Loaded {n} proteins from {input_fasta}.")

tab_ids = [l.split("\t")[0] for l in open(input_tab, "r").read().strip().split("\n") if len(l) > 0]

print(f"Loaded {len(tab_ids)} ids from {input_tab}.")

f = open(output_fasta, "w")
m = 0
for protein_id in prots.keys():
	include_this_protein = protein_id in tab_ids
	if not include:
		include_this_protein = not include_this_protein

	if include_this_protein:
		f.write(prots[protein_id] + "\n")
		m += 1

print(f"Written {m} proteins to {output_fasta}.")