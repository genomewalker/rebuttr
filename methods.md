MMseqs2 search and coverage filtering (methods snippet)

Tools and versions
- MMseqs2 (version: <insert version used>)
- samtools (version: <insert version>)
- Python 3.x (scripts provided in `scripts/`)

Sequence database provenance
- Database: <insert DB name, e.g., NCBI nr or GTDB>
- Download date: <YYYY-MM-DD>
- Number of sequences: <insert N sequences>

MMseqs2 search and convertalis
1. Create an MMseqs2 database from query sequences (if needed):
   - `mmseqs createdb queries.fasta queries_db`
2. Create an MMseqs2 database from the target/reference database (example using nr):
   - `mmseqs createdb nr.fasta nr_db`
3. Run MMseqs2 search (example parameters recommended):
   - `mmseqs search queries_db nr_db result tmp --threads 8 -e 1e-5` (e-value cutoff used during search)
4. Convert to tabular format including required fields:
   - `mmseqs convertalis queries_db nr_db result result.tsv --format-output "query,target,evalue,bits,pident,alnlen,qcov,tcov"`

Filtering and sensitivity testing
- We recommend applying an initial e-value cutoff of `1e-5` for comparability across DBs, then testing bitscore thresholds at `20` (permissive), `35` (moderate), and `50` (stringent). Secondary conservative filters for reporting primary claims are: percent identity `>= 30%` and query coverage `>= 50%`.

- Use `scripts/make_sensitivity.py` to produce `supplementary/Table_Sx_sensitivity.csv` and `supplementary/Table_Sx_detailed.csv` from the MMseqs2 `result.tsv` file.

Coverage metrics from per‑target depth files (if BAMs available)
- Generate per-target depth files from BAMs using `samtools depth` (example):
  - `samtools depth -a -r <refname> sample.bam > coverage_per_target/<refname>.depth`
- Use `scripts/compute_coverage_metrics.py` to compute breadth (% positions with depth>0), mean depth, and a coverage evenness metric (1 - sd(depth)/mean(depth), clipped to [0,1]). Conservative pass criteria: cov_evenness >= 0.5 and breadth >= 5%.

Reporting
- Include the full sensitivity table in Supplementary (per bitscore threshold) and per-hit detailed table showing which hits pass each threshold and conservative filters.
- In the Methods, report the exact MMseqs2 command lines, tool versions, and database provenance (name, download date, size). For results reported in the main text, state the conservative filter thresholds and sensitivity ranges tested.
