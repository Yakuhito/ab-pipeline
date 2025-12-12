library(pato)
library(dplyr)
library(Biostrings)

# load fasta files
faa_files <- dir(path = "all_proteins", pattern = "\\.fasta$", full.names = TRUE)
ref_genome <- "all_proteins/GCF_009035845.1.fasta"
print(head(faa_files))

# run mmseq
my_mmseq <- mmseqs(faa_files, type = "prot", n_cores = 12, identity=0.5, coverage=0.8)

total_genomes <- length(faa_files)

cluster_genome_counts <- my_mmseq$table %>%
  group_by(Prot_prot) %>%
  summarise(num_genomes = n_distinct(Genome_genome))

threshold <- total_genomes * 95 / 100
core_clusters <- cluster_genome_counts %>%
  filter(num_genomes >= threshold) %>%
  pull(Prot_prot)

ref_genome_name <- basename(ref_genome)
core_proteins_ref <- my_mmseq$table %>%
  filter(Prot_prot %in% core_clusters, Genome_genome == ref_genome_name) %>%
  pull(Genome_prot)

original_protein_ids <- sapply(strsplit(core_proteins_ref, "|", fixed = TRUE), function(x) x[2])
print(paste("Count of protein ids:", length(original_protein_ids)))

faa_seqs <- readAAStringSet(ref_genome)
faa_ids <- sapply(strsplit(names(faa_seqs), " "), function(x) x[1])
core_seqs_ref <- faa_seqs[faa_ids %in% original_protein_ids]

print(paste("Number of core sequences found in reference genome:", length(core_seqs_ref)))
writeXStringSet(core_seqs_ref, "core.fasta")
print("Written to core.fasta")
