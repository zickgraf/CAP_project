all: homalg_compatibility doc test

.PHONY: test

homalg_compatibility:
	gap load_cap_sheaves.g
	gap load_sheaves_cap.g

test: CAP_test Modules_test GradedModules_test Linear_test Generalized_test GroupRepresentations_test InternalExteriorAlgebra_test CompilerForCAP_test

CAP_test:
	cd CAP && make test

Modules_test:
	cd ModulePresentationsForCAP && make test

GradedModules_test:
	cd GradedModulePresentationsForCAP && make test

Linear_test:
	cd LinearAlgebraForCAP && make test

Generalized_test:
	cd GeneralizedMorphismsForCAP && make test

GroupRepresentations_test:
	cd GroupRepresentationsForCAP && make test

InternalExteriorAlgebra_test:
	cd InternalExteriorAlgebraForCAP && make test

CompilerForCAP_test:
	cd CompilerForCAP && make test

# BEGIN PACKAGE JANITOR
doc: doc_CAP doc_ActionsForCAP doc_AttributeCategoryForCAP doc_CompilerForCAP doc_ComplexesAndFilteredObjectsForCAP doc_DeductiveSystemForCAP doc_FreydCategoriesForCAP doc_GeneralizedMorphismsForCAP doc_GradedModulePresentationsForCAP doc_GroupRepresentationsForCAP doc_HomologicalAlgebraForCAP doc_InternalExteriorAlgebraForCAP doc_LinearAlgebraForCAP doc_ModulePresentationsForCAP doc_ModulesOverLocalRingsForCAP doc_MonoidalCategories doc_ToricSheaves

doc_CAP:
	$(MAKE) -C CAP doc

doc_ActionsForCAP:
	$(MAKE) -C ActionsForCAP doc

doc_AttributeCategoryForCAP:
	$(MAKE) -C AttributeCategoryForCAP doc

doc_CompilerForCAP:
	$(MAKE) -C CompilerForCAP doc

doc_ComplexesAndFilteredObjectsForCAP:
	$(MAKE) -C ComplexesAndFilteredObjectsForCAP doc

doc_DeductiveSystemForCAP:
	$(MAKE) -C DeductiveSystemForCAP doc

doc_FreydCategoriesForCAP:
	$(MAKE) -C FreydCategoriesForCAP doc

doc_GeneralizedMorphismsForCAP:
	$(MAKE) -C GeneralizedMorphismsForCAP doc

doc_GradedModulePresentationsForCAP:
	$(MAKE) -C GradedModulePresentationsForCAP doc

doc_GroupRepresentationsForCAP:
	$(MAKE) -C GroupRepresentationsForCAP doc

doc_HomologicalAlgebraForCAP:
	$(MAKE) -C HomologicalAlgebraForCAP doc

doc_InternalExteriorAlgebraForCAP:
	$(MAKE) -C InternalExteriorAlgebraForCAP doc

doc_LinearAlgebraForCAP:
	$(MAKE) -C LinearAlgebraForCAP doc

doc_ModulePresentationsForCAP:
	$(MAKE) -C ModulePresentationsForCAP doc

doc_ModulesOverLocalRingsForCAP:
	$(MAKE) -C ModulesOverLocalRingsForCAP doc

doc_MonoidalCategories:
	$(MAKE) -C MonoidalCategories doc

doc_ToricSheaves:
	$(MAKE) -C ToricSheaves doc

# END PACKAGE JANITOR

ci-test: homalg_compatibility doc
	cd CAP && make ci-test
	cd ModulePresentationsForCAP && make ci-test
	cd GradedModulePresentationsForCAP && make ci-test
	cd LinearAlgebraForCAP && make ci-test
	cd GeneralizedMorphismsForCAP && make ci-test
	cd GroupRepresentationsForCAP && make ci-test
	cd InternalExteriorAlgebraForCAP && make ci-test
	#cd CompilerForCAP && make ci-test
	cd FreydCategoriesForCAP && make doc
