# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Example: transforms `function() local x; x := 1; return x^2; end` into `function() return 1^2; end()`.
#!   Details: Replaces references to local variables of a function by the value of the corresponding binding of the function.
#!   If the option `inline_gvars_only` is set to `true`, this is only done if the value is a reference to a global variable.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitInlinedBindings" );