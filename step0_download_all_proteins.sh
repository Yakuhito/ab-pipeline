mv README.md README.md.bak

datasets download genome taxon 'Acinetobacter baumannii' \
	--annotated \
	--assembly-level complete \
	--assembly-source refseq \
	--exclude-atypical \
	--mag 'exclude' \
	--include protein \
	--released-after '01/01/2006' \
	--dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory ./
rm ncbi_dataset.zip
rm md5sum.txt
mv README.md.bak README.md

source_dir="ncbi_dataset"
output_dir="all_proteins"

mkdir -p "$output_dir"

find "$source_dir" -type f -name "protein.faa" | while read -r file; do
    dir_name=$(basename "$(dirname "$file")")
    cp "$file" "$output_dir/$dir_name.fasta"
done

find "$output_dir" -type f -name "*.fasta" -exec sed -i '/^>/!s/J/L/g' {} \; -print
