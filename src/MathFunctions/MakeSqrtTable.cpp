// A simple program building a sqrt table
#include <cmath>
#include <fstream>
#include <iostream>

int main(int argc, char* argv[])
{
    // ensure we have enough args
    if (argc < 2) {
        return EXIT_FAILURE;
    }

    std::ofstream fout(argv[1], std::ios_base::out);
    const bool fileOpen = fout.is_open();
    if (fileOpen) {
        fout << "double sqrtTable[] = {";
        for (int i = 0; i < 10; i++) {
            fout << sqrt(static_cast<double>(i)) << ",";
        }
        // close the table with a zero (to make its syntax correct)
        fout << "0};" << std::endl;
        fout.close();
    }
    return fileOpen ? EXIT_SUCCESS : EXIT_FAILURE;
}
