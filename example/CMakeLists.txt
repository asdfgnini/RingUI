cmake_minimum_required(VERSION 3.16)

project(example VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(example
    src/main.cpp
)


qt_add_qml_module(example
    URI example
    VERSION 1.0
    SOURCES src/CircularReveal.cpp src/CircularReveal.h
    RESOURCES example.qrc
)


target_link_libraries(example
    PRIVATE Qt6::Quick
)




