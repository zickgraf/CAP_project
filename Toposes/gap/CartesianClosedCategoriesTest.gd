# THIS FILE WAS AUTOMATICALLY GENERATED

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

#! @Chapter Examples and Tests

#! @Section Test functions

#! @Description
#! The arguments are
#! * a CAP category $cat$
#! * objects $a, b, c, d$
#! * a morphism $\alpha: a \rightarrow b$
#! * a morphism $\beta: c \rightarrow d$
#! * a morphism $\gamma: a \times b \rightarrow 1$
#! * a morphism $\delta: c \times d \rightarrow 1$
#! * a morphism $\epsilon: 1 \rightarrow \mathrm{Hom}(a,b)$
#! * a morphism $\zeta: 1 \rightarrow \mathrm{Hom}(c,d)$
#! This function checks for every operation
#! declared in CartesianClosedCategories.gd
#! if it is computable in the CAP category $cat$.
#! If yes, then the operation is executed
#! with the parameters given above and
#! compared to the equivalent computation in
#! the opposite category of $cat$.
#! Pass the option 'verbose := true' to output more information.
#! @Arguments cat, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta
DeclareGlobalFunction( "CartesianClosedCategoriesTest" );
