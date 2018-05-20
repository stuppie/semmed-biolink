# semmed-biolink
normalization of sememd db to biolink model


### Steps
1. start with output of [notebook 2](https://github.com/mmayers12/semmed/blob/master/nbs/02-building_the_graph.ipynb) from @mmayers12 https://github.com/mmayers12/semmed/tree/master/nbs
  - General cleanup of malformed edges and nodes
  - Collapse duplicate edges while preserving PMIDs
2. The following predicates were removed: ['compared_with', 'higher_than', 'lower_than', 'different_from', 'different_than', 'same_as', 'occurs_in', 'process_of', 'DIAGNOSES', 'METHOD_OF', 'USES']
3. Associations (an edge with a domain and range of a certain type) with less than 1000 instances were removed. This removed 1711/2051 associations, but only about 1% of all edges.
4. The following node types were removed (and all edges using one of those): ['Concepts & Ideas', 'Organizations', 'Geographic Areas', 'Occupations', 'Devices', 'Procedures']
5. Semmed node types were mapped to biolink classes (see: https://github.com/stuppie/semmed-biolink/blob/master/04-filter_biolink.ipynb)
6. Allowed domains and ranges for each predicate were defined and edges not conforming were filtered out. (See: https://github.com/stuppie/semmed-biolink/blob/master/04-filter_biolink.ipynb)

#### Additional changes
- Rename 'isa' edge to 'subclass of', rename 'disrupts' edge to 'affects', rename 'associated_with' edge to 'related_to'
- associated_with/related_to edges with domain: gene, range: disease; rename to gene_associated_with_condition, and leave the rest alone
- inhibits edges with domain: chemical_substance or genomic entity, range: genomic_entity or disease -> negatively_regulates_entity_to_entity
- inhibits edges with domain: chemical_substance or genomic entity, range: biological_process -> negatively_regulates
- stimulates edges with domain: chemical_substance or genomic entity, range: genomic_entity or disease -> positively_regulates_entity_to_entity
- stimulates edges with domain: chemical_substance or genomic entity, range: biological_process -> positively_regulates



### Result
Start:  
20,620,113 edges  
268,918 nodes  
3089 association types  
32 predicates  
15 node types  
  
End:  
14155503 edges  
218102 nodes  
113 association types  
18 predicates  
8 node types  
