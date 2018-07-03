# semmed-biolink
normalization of sememd db to biolink model


### Steps

- Run download_convert.sh to download SemMedDB and related files and convert mysql dump to csv
- Run the ipynbs in order

01-initial_data_clean.ipynb
- Expand predicates with OR operations into individual predicates
- Convert cuis that are entrez ids into cuis
- Change neg props to the same prop with a negative flag
- Make a separate nodes table

02-normalize_node_types_to_biolink.ipynb
- For each node, get the UMLS semantic type for each umls cui
- Map umls semantic types to biolink node types (blm_to_umls_nodes.json)
- Nodes with no matching type are removed

03-filter_nodes_edges.ipynb
- Remove edges with nodes with no umls type or label
- Remove the following predicates: ['compared_with', 'higher_than', 'lower_than', 'different_from', 'different_than', 
'same_as','OCCURS_IN', 'PROCESS_OF', 'DIAGNOSES', 'METHOD_OF', 'USES','AUGMENTS', 'ADMINISTERED_TO', 'COMPLICATES']

04-filter_biolink
 - Filter specific domain and ranges for: CAUSES, LOCATION_OF, TREATS, PREDISPOSES, PREVENTS
 - rename 'converts_to' edge to 'derives_into'
 - rename 'isa' edge to 'subclass of'
 - rename 'disrupts' edge to 'affects'
 - rename 'associated_with' edge to 'related_to'
 - rename 'STIMULATES' edge to 'positively_regulates'
 - rename 'INHIBITS' edge to 'negatively_regulates'
 - associated_with/related_to edges with domain: gene, range: disease; rename to gene_associated_with_condition

05-xrefs
Get xrefs from a variety of sources
- Drugs: 
UMLS has mesh xrefs. From mesh, we can get UNII and CAS. From UNII_FDA, we can get inchikeys 
(lookup using cas or unii). From chembl, we can get chembl IDs from the inchikeys
So: UMLS -> mesh -> unii/cas -> inchikey -> chembl
insane, I know.
- Anatomy: uberon has umls xrefs
- disease: DO has umls, umls has NCI, ICD10PCS, SNOMEDCT_US, ICD10CM, OMIM
- proteins: umls has uniprot xrefs
- biological_process_or_activity/activity_and_behavior: umls has GO
- gene: umls has HGNC and OMIM

06-neo4j
 - reformat for neo4j import

### Result
Start:  
20,620,113 edges  
268,918 nodes  
32 predicates  
15 node types  
  
End:  
14,033,126 edges  
165,658 nodes  
18 predicates  
13 node types  
