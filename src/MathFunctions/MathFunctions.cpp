#include "MathFunctions.h"

#include "mysqrt.h"

namespace mathfunctions
{
    double sqrt(double x)
    {
        return detail::mysqrt(x);
    }
}
