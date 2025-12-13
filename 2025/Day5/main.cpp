#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <tuple>
#include <algorithm>

#define RED_TEXT "\e[31m"
#define GREEN_TEXT "\e[32m"
#define PLAIN_TEXT "\e[0m"

using namespace std;

bool llRangeSort(std::tuple<long,long> a, std::tuple<long,long> b)
{
    return std::get<0>(a) < std::get<0>(b);
}

long freshIngredientCount(const char* fileName)
 {
    std::ifstream infile(fileName);
    
    int delimIndex;
    std::string line;
    std::vector<std::tuple<long, long>>* freshRanges = new std::vector<std::tuple<long, long>>();
    std::vector<long>* ids = new std::vector<long>();

    while (std::getline(infile, line))
    {
        delimIndex = line.find('-');
        if (delimIndex > 0)
        {
            freshRanges->push_back(
                {
                    std::stol(line.substr(0, delimIndex)),
                    std::stol(line.substr(delimIndex + 1))
                });
        }
        else if (line != "")
        {
            ids->push_back(std::stol(line));
        }
    }
    std::sort(freshRanges->begin(), freshRanges->end(), llRangeSort);
    std::sort(ids->begin(), ids->end());

    long freshCount = 0;
    for (long & id : *ids)
    {
        for (auto itor = freshRanges->begin(); itor < freshRanges->end(); itor++)
        {
            if (get<0>(*itor) <= id && id <= get<1>(*itor))
            {
                freshCount++;
                // todo set start itor for the next loop
                break;
            }
        }
    }

    // clean up
    delete freshRanges;
    delete ids;

    return freshCount;
 }

template <typename T>
bool test(const char* testName, T v1, T v2)
{
    if (v1 == v2) {
        cout << PLAIN_TEXT << testName << GREEN_TEXT << " PASSED" << PLAIN_TEXT << endl;
        return true;
    }
    cout << PLAIN_TEXT << testName << RED_TEXT << " FAILED!" << PLAIN_TEXT << " Got " << v1 << " expected " << v2 << endl;
    return false;
}

// g++ ./main.cpp -o out.exe && ./out.exe
int main()
{    
    test("Test1", freshIngredientCount("eric_input.txt"), 3l);

    cout << "Final output: " << freshIngredientCount("input.txt") << endl;
    return 0;
}
