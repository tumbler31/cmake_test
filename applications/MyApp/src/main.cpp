#include <fmt/core.h>

#include "Logger/log.h"


int main() {
    fmt::print("Hello, {}!\n", "world");
    Logger logger;
    logger.Test();
    Logger2 logger2;
    logger2.Test();
    return 0;
}
