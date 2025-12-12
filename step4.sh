if [ ! -f "DEG.dmnd" ]; then
    echo "DEG.dmnd does not exist, downloading database..."
    wget http://tubic.org/deg/public/download/DEG10.aa.gz -O DEG.fasta.gz
    gunzip DEG.fasta.gz
    echo "saved to 'DEG.fasta'; filtering & creating DIAMOND database..."
    python3 step4_filter_deg.py
    diamond makedb --threads 12 --in DEG_filtered.fasta --db ./DEG
    echo "DEG.dmnd created."
fi

if [ ! -f "VFDB.dmnd" ]; then
    echo "VFDB.dmnd does not exist, downloading database..."
    wget https://www.mgc.ac.cn/VFs/Down/VFDB_setB_pro.fas.gz -O VFDB.fasta.gz
    gunzip VFDB.fasta.gz
    echo "saved to 'VFDB.fasta; creating DIAMOND database..."
    diamond makedb --threads 12 --in VFDB.fasta --db ./VFDB
    echo "VFDB.dmnd created."
fi

diamond blastp --threads 12 \
    --db ./DEG \
    --query localized.fasta \
    --outfmt '6' qseqid sseqid pident evalue bitscore score \
    --out 'deg.tab' \
    --max-target-seqs '1' \
    --min-score '100' \
    --id '35' \
    --quiet

python3 filter_fasta.py include localized.fasta deg.tab deg-homologous.fasta

diamond blastp --threads 12 \
    --db ./VFDB \
    --query deg-homologous.fasta \
    --outfmt '6' qseqid sseqid pident evalue bitscore score \
    --out 'vfdb.tab' \
    --max-target-seqs '1' \
    --min-score '100' \
    --id '35' \
    --quiet

python3 filter_fasta.py include deg-homologous.fasta vfdb.tab virulence.fasta
