#include "Logger/Log.h"

#include <spdlog/spdlog.h>

void Logger::Test() const
{
    spdlog::info("Logging is working too!");
}