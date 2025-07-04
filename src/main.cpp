#include <fmt/core.h>
#include <spdlog/spdlog.h>

int main() {
    fmt::print("Hello, {}!\n", "world");
    spdlog::info("Logging is working too!");
    return 0;
}
