#include "mysqrt.h"

#include <cmath>
#include <iostream>

#include "SqrtTable.h"

namespace mathfunctions
{
    namespace detail
    {
        // a hack square root calculation using simple operations
        double mysqrt(double x)
        {
            if (x <= 0)
            {
                return 0;
            }

        #if defined(HAVE_LOG) && defined(HAVE_EXP)
            double result = std::exp(std::log(x) * 0.5);
            std::cout << "Computing sqrt of " << x << " to be " << result
                      << " using math log and exp functions"
                      << std::endl;
        #else
            double result = x;

            if (x >= 1 && x < 10) {
                std::cout << "Use the sqrt table to find initial value"
                          << std::endl;
                result = sqrtTable[static_cast<int>(x)];
            }

            // do 10 iterations
            for (int i = 0; i < 10; ++i)
            {
                std::cout << "Computing sqrt of " << x << " to be " << result << std::endl;

                if (result <= 0)
                {
                    result = 0.1;
                }
                double delta = x - (result * result);
                result = result + 0.5 * delta / result;
            }

            std::cout << "(Final) Computing sqrt of " << x << " to be " << result << std::endl;
        #endif

            return result;
        }
    }
}