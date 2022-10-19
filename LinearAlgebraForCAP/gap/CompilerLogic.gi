# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#

# HomalgIdentityMatrix( size, ring ) * matrix -> matrix
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring", "matrix" ],
        src_template := "HomalgIdentityMatrix( size, ring ) * matrix",
        dst_template := "matrix",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# matrix * HomalgIdentityMatrix( size, ring ) -> matrix
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring", "matrix" ],
        src_template := "matrix * HomalgIdentityMatrix( size, ring )",
        dst_template := "matrix",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# NrRows( HomalgIdentityMatrix( size, R ) ) -> size
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring" ],
        src_template := "NrRows( HomalgIdentityMatrix( size, ring ) )",
        dst_template := "size",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# NrCols( HomalgIdentityMatrix( size, R ) ) -> size
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring" ],
        src_template := "NrCols( HomalgIdentityMatrix( size, ring ) )",
        dst_template := "size",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# KroneckerMat( M, HomalgIdentityMatrix( 1 ) ) -> M
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "ring" ],
        src_template := "KroneckerMat( matrix, HomalgIdentityMatrix( 1, ring ) )",
        dst_template := "matrix",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);
