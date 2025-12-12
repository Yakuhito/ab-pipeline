import os
import glob

output_directories = ['output_99', 'output_95', 'output_90', 'output_80', 'output_50', 'output_10']

# grep '>' virulence.fasta | cut -d'>' -f2 | cut -d' ' -f1
candidates="""WP_000026861.1
WP_000030405.1
WP_000050456.1
WP_000191300.1
WP_000277838.1
WP_000479765.1
WP_000505931.1
WP_000724216.1
WP_000774086.1
WP_000777878.1
WP_000842416.1
WP_000898886.1
WP_000952664.1
WP_000986589.1
WP_001042928.1
WP_001078584.1
WP_001124962.1
WP_001174793.1
WP_001984465.1
WP_001984577.1
WP_005144067.1""".split("\n")

for output_directory in output_directories:
	print(output_directory)

	occurrences = {}
	for cand in candidates:
		occurrences[cand] = 0

	tab_files = glob.glob(os.path.join(output_directory, "*.tab"))

	for tab_file in tab_files:
		with open(tab_file, 'r') as f:
			seen_cands = []
			for line in f:
				if '\t' in line:
					cand = line.split('\t')[1]
					if cand not in seen_cands:
						seen_cands.append(cand)
			for cand in seen_cands:
				occurrences[cand] += 1

	for cand in candidates:
		print(occurrences[cand])
