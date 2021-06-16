#!/usr/bin/ghci

data CapCategory = CapCategory {
    name :: String,
    internal_object_constructor :: CapCategory -> ObjectDatum -> CapCategoryObject,
    internal_object_datum :: CapCategory -> CapCategoryObject -> ObjectDatum,
    internal_morphism_constructor :: CapCategory -> CapCategoryObject -> MorphismDatum -> CapCategoryObject -> CapCategoryMorphism,
    internal_fiber_product :: CapCategory -> [CapCategoryMorphism] -> CapCategoryObject
}

-- TODO: any type, not only Int
type ObjectDatum = Int
data CapCategoryObject = CapCategoryObject {
    cap_category_of_object :: CapCategory,
    stored_object_datum :: ObjectDatum
}

-- TODO: any type, not only Int
type MorphismDatum = Int
data CapCategoryMorphism = CapCategoryMorphism {
    cap_category_of_morphism :: CapCategory,
    source :: CapCategoryObject,
    internal_morphism_datum :: MorphismDatum,
    range :: CapCategoryObject
}

instance Show CapCategory where
   show cat = name cat

instance Show CapCategoryObject where
   show object = "An object in " ++ name (cap_category_of_object object)

instance Show CapCategoryMorphism where
   show morphism = "A morphism in " ++ name (cap_category_of_morphism morphism)

object_constructor :: CapCategory -> ObjectDatum -> CapCategoryObject
object_constructor cat object_datum = internal_object_constructor cat cat object_datum

object_datum :: CapCategory -> CapCategoryObject -> ObjectDatum
object_datum cat object = internal_object_datum cat cat object

morphism_constructor :: CapCategory -> CapCategoryObject -> ObjectDatum -> CapCategoryObject -> CapCategoryMorphism
morphism_constructor cat source morphism_datum range = internal_morphism_constructor cat cat source morphism_datum range

fiber_product :: CapCategory -> [CapCategoryMorphism] -> CapCategoryObject
fiber_product cat morphisms = internal_fiber_product cat cat morphisms

main = do
    let integers_category = CapCategory {
        name = "Category of integers",
        internal_object_constructor = \cat object_datum -> CapCategoryObject { cap_category_of_object = cat, stored_object_datum = object_datum },
        internal_object_datum = \cat object -> stored_object_datum object,
        internal_morphism_constructor = \cat source morphism_datum range -> CapCategoryMorphism { cap_category_of_morphism = cat, source = source, internal_morphism_datum = morphism_datum, range = range },
        internal_fiber_product = \cat morphisms -> object_constructor cat (foldl gcd 0 (map (\mor -> object_datum cat (source mor)) morphisms))
    }
    let obj1 = object_constructor integers_category 12
    let obj2 = object_constructor integers_category 14
    let obj3 = object_constructor integers_category 16
    let range = object_constructor integers_category 336
    let mor1 = morphism_constructor integers_category obj1 0 range
    let mor2 = morphism_constructor integers_category obj2 0 range
    let mor3 = morphism_constructor integers_category obj3 0 range
    
    let fiber_product_obj = fiber_product integers_category [mor1, mor2, mor3]
    putStrLn (show (object_datum integers_category fiber_product_obj))
