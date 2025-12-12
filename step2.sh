CORE_FASTA='core.fasta'

if [ ! -f "human.dmnd" ]; then
    echo "human.dmnd does not exist, downloading genome..."
    datasets download genome accession GCF_000001405.40 --assembly-version latest --include protein --filename human.zip
    unzip -n human.zip
    rm md5sum.txt
    cp ncbi_dataset/data/GCF_000001405.40/protein.faa human.fasta
    echo "saved to 'human.fasta'; creating DIAMOND database..."
    diamond makedb --threads 12 --in human.fasta --db ./human
    echo "human.dmnd created."
fi

if [ ! -f "gut.dmnd" ]; then
    wget https://sourceforge.net/projects/panrv2/files/PanRVPrerequisits/DBs/GFDB.rar -O GFDB.rar 
    unrar x -u GFDB.rar
    cp GFDB/GutFlora.faa gut.fasta
    echo "saved to 'gut.fasta'; creating DIAMOND database..."
    diamond makedb --threads 12 --in gut.fasta --db ./gut
    echo "gut.dmnd created."
fi

diamond blastp --threads 12 \
	--db ./human \
	--query "${CORE_FASTA}" \
	--no-self-hits \
	--outfmt '6' qseqid sseqid pident evalue bitscore score \
	--out 'human.tab' \
	--max-target-seqs '1' \
	--evalue '0.005' \
	--id '40' \
	--query-cover '50' \
	--quiet

python3 filter_fasta.py exclude ${CORE_FASTA} human.tab after-human.fasta

diamond blastp --threads 12 \
	--db ./gut \
	--query after-human.fasta \
	--no-self-hits \
	--outfmt '6' qseqid sseqid pident evalue bitscore score \
	--out 'gut.tab' \
	--max-target-seqs '1' \
	--evalue '0.005' \
	--id '75' \
	--query-cover '50' \
	--quiet

python3 filter_fasta.py exclude after-human.fasta gut.tab non-homologous.fasta