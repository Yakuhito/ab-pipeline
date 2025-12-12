diamond blastp --threads 12 \
        --db ./virulence \
        --query "all_proteins/${genome_id}.fasta" \
        --outfmt '6' qseqid sseqid pident evalue bitscore score \
        --out "output_99/${genome_id}.tab" \
        --max-target-seqs '50' \
        --evalue '0.005' \
        --id '99' \
        --query-cover '80' \
        --quiet