#!/usr/bin/python3

CAP_OPERATION_NAMES = [
    "ObjectConstructor",
    "ObjectDatum",
    "MorphismConstructor",
    "MorphismDatum",
    "IdentityMorphism",
    "PreCompose",
    "FiberProduct",
]

def get_function_for_operation(operation_name):
    return lambda cat, *args: getattr(cat, operation_name)(cat, *args)

for operation_name in CAP_OPERATION_NAMES:
    globals()[operation_name] = get_function_for_operation(operation_name)

class CapCategory:
    name = "A CAP category"

    def __init__(self, *args):
        if len(args) > 0:
            self.name = args[0]

    def __str__(self):
        return self.name

    def __repr__(self):
        return self.name

class CapCategoryObject:
    def __init__(self, cat, **kwargs):
        self.CapCategory = cat
        for key, value in kwargs.items():
            setattr(self, key, value)

    def __str__(self):
        return "An object in " + self.CapCategory.name

    def __repr__(self):
        return "An object in " + self.CapCategory.name

class CapCategoryMorphism:
    def __init__(self, cat, source, range, **kwargs):
        self.CapCategory = cat
        self.Source = source
        self.Range = range
        for key, value in kwargs.items():
            setattr(self, key, value)

    def __str__(self):
        return "An morphism in " + self.CapCategory.name

    def __repr__(self):
        return "An morphism in " + self.CapCategory.name

import math

IntegersCategory = CapCategory("Category of integers")
IntegersCategory.ObjectConstructor = lambda cat, object_datum: CapCategoryObject(cat, Integer = object_datum)
IntegersCategory.ObjectDatum = lambda cat, obj: obj.Integer
IntegersCategory.MorphismConstructor = lambda cat, source, morphism_datum, range: CapCategoryMorphism(cat, source, range)
IntegersCategory.IdentityMorphism = lambda cat, obj: MorphismConstructor(cat, obj, 0, obj )
IntegersCategory.PreCompose = lambda cat, mor1, mor2: MorphismConstructor(cat, mor1.Source, 0, mor2.Range )
IntegersCategory.FiberProduct = lambda cat, morphisms: ObjectConstructor(cat, math.gcd(*map(lambda mor: ObjectDatum(cat, mor.Source), morphisms)))

obj1 = ObjectConstructor(IntegersCategory, 12)
obj2 = ObjectConstructor(IntegersCategory, 14)
obj3 = ObjectConstructor(IntegersCategory, 16)

range = ObjectConstructor(IntegersCategory, 336)

mor1 = MorphismConstructor(IntegersCategory, obj1, 0, range)
mor2 = MorphismConstructor(IntegersCategory, obj2, 0, range)
mor3 = MorphismConstructor(IntegersCategory, obj3, 0, range)

fiber_product = FiberProduct(IntegersCategory, [mor1, mor2, mor3])
print(ObjectDatum(IntegersCategory, fiber_product))

mor4 = MorphismConstructor(IntegersCategory, obj1, 0, obj2)
mor5 = MorphismConstructor(IntegersCategory, obj2, 0, obj3)
composition = PreCompose(IntegersCategory, mor4, mor5)
print(composition.Source == obj1)
print(composition.Range == obj3)
