# 设定CMAKE版本
cmake_minimum_required(VERSION 3.20)
# 设定工程的名字和版本
project(RingUI VERSION 1.0)

#设定变量控制例子是否编译，在引入到自定义工程时，关闭例子的编译
option(RINGUI_BUILD_EXAMPLES "Build RingUI demo applications." OFF)
# 设定变量控制是否将RINGUI编译为静态库，这里设置为否
set(RINGUI_BUILD_STATIC_LIB OFF)

set(RINGUI_BUILD_EXAMPLES ON)

# 查找QT库机器组件
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core)

# 添加原目录
add_subdirectory(src)
# 添加例子目录
if(RINGUI_BUILD_EXAMPLES)
    add_subdirectory(example)
endif()
# 打印相关信息便于查看，有是否编译例子，是否编译静态库，以及是否指定RingUI插件的安装目录
message("------------------------ RINGUI ------------------------")
message("Build RingUI example applications.: ${RINGUI_BUILD_EXAMPLES}")
message("Build static library.: ${RINGUI_BUILD_STATIC_LIB}")
message("Path to RingUI plugin.: ${RINGUI_QML_PLUGIN_DIRECTORY}")
