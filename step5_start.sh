if [ ! -f "virulence.dmnd" ]; then
    echo "creating DIAMOND database for 'virulence.fasta'..."
    diamond makedb --threads 12 --in virulence.fasta --db ./virulence
    echo "virulence.dmnd created."
fi

mkdir -p output_99
rm output_99/*
mkdir -p output_95
rm output_95/*
mkdir -p output_90
rm output_90/*
mkdir -p output_80
rm output_80/*
mkdir -p output_50
rm output_50/*
mkdir -p output_10
rm output_10/*

for fasta_file in all_proteins/*.fasta; do
    genome_id=$(basename "$fasta_file" .fasta)

    echo "Processing ${genome_id}..."
    
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
done

for fasta_file in all_proteins/*.fasta; do
    genome_id=$(basename "$fasta_file" .fasta)

    echo "Processing ${genome_id}..."
    
    diamond blastp --threads 12 \
        --db ./virulence \
        --query "all_proteins/${genome_id}.fasta" \
        --outfmt '6' qseqid sseqid pident evalue bitscore score \
        --out "output_95/${genome_id}.tab" \
        --max-target-seqs '50' \
        --evalue '0.005' \
        --id '95' \
        --query-cover '80' \
        --quiet
done

for fasta_file in all_proteins/*.fasta; do
    genome_id=$(basename "$fasta_file" .fasta)

    echo "Processing ${genome_id}..."
    
    diamond blastp --threads 12 \
        --db ./virulence \
        --query "all_proteins/${genome_id}.fasta" \
        --outfmt '6' qseqid sseqid pident evalue bitscore score \
        --out "output_90/${genome_id}.tab" \
        --max-target-seqs '50' \
        --evalue '0.005' \
        --id '90' \
        --query-cover '80' \
        --quiet
done

for fasta_file in all_proteins/*.fasta; do
    genome_id=$(basename "$fasta_file" .fasta)

    echo "Processing ${genome_id}..."
    
    diamond blastp --threads 12 \
        --db ./virulence \
        --query "all_proteins/${genome_id}.fasta" \
        --outfmt '6' qseqid sseqid pident evalue bitscore score \
        --out "output_80/${genome_id}.tab" \
        --max-target-seqs '50' \
        --evalue '0.005' \
        --id '80' \
        --query-cover '80' \
        --quiet
done

for fasta_file in all_proteins/*.fasta; do
    genome_id=$(basename "$fasta_file" .fasta)

    echo "Processing ${genome_id}..."
    
    diamond blastp --threads 12 \
        --db ./virulence \
        --query "all_proteins/${genome_id}.fasta" \
        --outfmt '6' qseqid sseqid pident evalue bitscore score \
        --out "output_50/${genome_id}.tab" \
        --max-target-seqs '50' \
        --evalue '0.005' \
        --id '50' \
        --query-cover '80' \
        --quiet
done

for fasta_file in all_proteins/*.fasta; do
    genome_id=$(basename "$fasta_file" .fasta)

    echo "Processing ${genome_id}..."
    
    diamond blastp --threads 12 \
        --db ./virulence \
        --query "all_proteins/${genome_id}.fasta" \
        --outfmt '6' qseqid sseqid pident evalue bitscore score \
        --out "output_10/${genome_id}.tab" \
        --max-target-seqs '50' \
        --evalue '0.005' \
        --id '10' \
        --query-cover '80' \
        --quiet
done