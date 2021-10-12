#!/usr/bin/julia

CAP_OPERATION_NAMES = [
    "ObjectConstructor",
    "ObjectDatum",
    "MorphismConstructor",
    "MorphismDatum",
    "IdentityMorphism",
    "PreCompose",
    "FiberProduct",
]

for operation_name in CAP_OPERATION_NAMES
    eval(Meta.parse("" * operation_name * " = (cat, args...) -> cat.operations[\"" * operation_name * "\"](cat, args...)"))
end

# CapCategory
struct CapCategory
	name::String
	operations::Dict
end

CapCategory(name) = CapCategory(name, Dict())
CapCategory() = CapCategory("A CAP category")

function Base.show(io::IO, cat::CapCategory)
	print(io, cat.name)
end

# CapCategoryObject
struct CapCategoryObject
	cat::CapCategory
	object_datum::Any
end

function Base.show(io::IO, obj::CapCategoryObject)
	print(io, "An object in " * obj.cat.name)
end

# CapCategoryMorphism
struct CapCategoryMorphism
	cat::CapCategory
	source::CapCategoryObject
	morphism_datum::Any
	range::CapCategoryObject
end

function Base.show(io::IO, obj::CapCategoryMorphism)
	print(io, "A morphism in " * obj.cat.name)
end

# IntegersCategory
IntegersCategory = CapCategory("Category of integers")
IntegersCategory.operations["ObjectConstructor"] = (cat, object_datum) -> CapCategoryObject(cat, object_datum)
IntegersCategory.operations["ObjectDatum"] = (cat, obj) -> obj.object_datum
IntegersCategory.operations["MorphismConstructor"] = (cat, source, morphism_datum, range) -> CapCategoryMorphism(cat, source, morphism_datum, range)
IntegersCategory.operations["IdentityMorphism"] = (cat, obj) -> MorphismConstructor(cat, obj, 0, obj)
IntegersCategory.operations["PreCompose"] = (cat, mor1, mor2) -> MorphismConstructor(cat, mor1.source, 0, mor2.range)
IntegersCategory.operations["FiberProduct"] = (cat, morphisms) -> ObjectConstructor(cat, isempty(morphisms) ? 0 : gcd(map(mor -> ObjectDatum(cat, mor.source), morphisms)))

# tests
obj1 = ObjectConstructor(IntegersCategory, 12)
obj2 = ObjectConstructor(IntegersCategory, 14)
obj3 = ObjectConstructor(IntegersCategory, 16)

range = ObjectConstructor(IntegersCategory, 336)

mor1 = MorphismConstructor(IntegersCategory, obj1, 0, range)
mor2 = MorphismConstructor(IntegersCategory, obj2, 0, range)
mor3 = MorphismConstructor(IntegersCategory, obj3, 0, range)

fiber_product = FiberProduct(IntegersCategory, [mor1, mor2, mor3])
print(ObjectDatum(IntegersCategory, fiber_product))

empty_fiber_product = FiberProduct(IntegersCategory, [])
print(ObjectDatum(IntegersCategory, empty_fiber_product))

mor4 = MorphismConstructor(IntegersCategory, obj1, 0, obj2)
mor5 = MorphismConstructor(IntegersCategory, obj2, 0, obj3)
composition = PreCompose(IntegersCategory, mor4, mor5)
print(composition.source == obj1)
print(composition.range == obj3)
