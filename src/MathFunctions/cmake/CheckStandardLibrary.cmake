include(CheckCXXSourceCompiles)

function(Check_Standard_Library HAVE_LOG HAVE_EXP)
    check_cxx_source_compiles("
        #include <cmath>
        int main() {
            std::log(1.0);
            return 0;
        }
    " HAVE_LOG_LOCAL)
    check_cxx_source_compiles("
        #include <cmath>
        int main() {
            std::exp(1.0);
            return 0;
        }
    " HAVE_EXP_LOCAL)

    set(${HAVE_LOG} ${HAVE_LOG_LOCAL} PARENT_SCOPE)
    set(${HAVE_EXP} ${HAVE_EXP_LOCAL} PARENT_SCOPE)
endfunction()
