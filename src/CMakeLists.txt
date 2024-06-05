# 指定cmake版本
cmake_minimum_required(VERSION 3.20)

# 判断是否使能静态库编译和，当前QT版本是否大于等于6.2
if (RINGUI_BUILD_STATIC_LIB AND (QT_VERSION VERSION_GREATER_EQUAL "6.2"))
    project(ringui VERSION 1.0)
else ()
    project(ringuiplugin VERSION 1.0)
endif ()

#配置通用编译
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


#导入Qt相关依赖包
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick Qml)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick)

# 获取QT安装目录的路径
set(QT_SDK_DIR "${Qt${QT_VERSION_MAJOR}_DIR}/../../..")
cmake_path(SET QT_SDK_DIR NORMALIZE ${QT_SDK_DIR})

#设置QML插件输出目录，可以通过外部设置，如果外部没有设置就默认到<QT_SDK_DIR_PATH>\qml\RingUI目录下
set(RINGUI_QML_PLUGIN_DIRECTORY "" CACHE PATH "Path to RINGUI plugin")
# 判断插件输出目录是否为空，为空则安装到安装目录下qml/RingUI
if (NOT RINGUI_QML_PLUGIN_DIRECTORY)
    set(RINGUI_QML_PLUGIN_DIRECTORY ${QT_SDK_DIR}/qml/RingUI)
endif ()

# 编译器设置，判断版本是否大于等于6.3，不满足就手动设置
if (QT_VERSION VERSION_GREATER_EQUAL "6.3")
    qt_standard_project_setup()
else ()
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif ()

#遍历所有Cpp文件
file(GLOB_RECURSE CPP_FILES *.cpp *.h *.cxx)
foreach (filepath ${CPP_FILES})
    # message("filepath:${filepath}")
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
    list(APPEND sources_files ${filename})
endforeach (filepath)

# 测试清楚路径之后的文件是否正确
# foreach(sources_files ${sources_files})
#     message("sources_files:${sources_files}")
# endforeach(sources_files)

# 判断当前QT版本是否大于6.2
if (QT_VERSION VERSION_GREATER_EQUAL "6.2")

    #遍历所有qml文件
    file(GLOB_RECURSE QML_PATHS *.qml qmldir)
    foreach (filepath ${QML_PATHS})
        if (${filepath} MATCHES "QML/")
            string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
            if (${filename} MATCHES "qmldir")
                list(APPEND resource_files ${filename})
            else ()
                list(APPEND qml_files ${filename})
            endif ()
        endif ()
    endforeach (filepath)

    #遍历所有资源文件
    file(GLOB_RECURSE RES_PATHS *.png *.jpg *.svg *.ico *.ttf *.webp *.js *.qm)
    foreach (filepath ${RES_PATHS})
        if (${filepath} MATCHES "QML/")
            string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
            list(APPEND resource_files ${filename})
        endif ()
    endforeach (filepath)


    #修改资源文件导出路径，将文件copy到安装目录下的路径
    foreach (filepath IN LISTS qml_files resource_files)
        string(REPLACE "QML/imports/" "" filename ${filepath})
        # 使用filename的名字替换filepath,在程序中使用filename 就等同于使用filepath一样
        set_source_files_properties(${filepath} PROPERTIES QT_RESOURCE_ALIAS ${filename})
    endforeach ()

    foreach(resource_files ${resource_files})
        message("resource_files:${resource_files}")
    endforeach(resource_files)
endif()

# 设置编译类型
if (RINGUI_BUILD_STATIC_LIB)
    set(LIB_TYPE "STATIC")
else ()
    set(LIB_TYPE "SHARED")
endif ()

# 设置插件名字
if (RINGUI_BUILD_STATIC_LIB)
    set(PLUGIN_TARGET_NAME "")
else ()
    #如果是动态库，则使用插件目标作为其自己的支持目标来定义 QML 模块，在这种情况下，模块必须在运行时动态加载，并且不能由其他目标直接链接到
    set(PLUGIN_TARGET_NAME ${PROJECT_NAME})
endif ()


# 判断当前QT版本是否大于6.2
if (QT_VERSION VERSION_GREATER_EQUAL "6.2")
    #如果是Qt6.2版本以上，则使用qt_add_library，qt_add_qml_module函数添加资源文件
    if (RINGUI_BUILD_STATIC_LIB)
        set(RINGUI_QML_PLUGIN_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/RingUI)
    endif ()
    qt_add_library(${PROJECT_NAME} ${LIB_TYPE})
    qt_add_qml_module(${PROJECT_NAME}
            PLUGIN_TARGET ${PLUGIN_TARGET_NAME}
            OUTPUT_DIRECTORY ${RINGUI_QML_PLUGIN_DIRECTORY}
            VERSION 1.0
            URI "RingUI"
            #修改qmltypes文件名称。默认fluentuiplugin.qmltypes，使用默认名称有时候import FluentUI 1.0会爆红，所以修改成plugins.qmltypes
            TYPEINFO "plugins.qmltypes"
            SOURCES ${sources_files}
            QML_FILES ${qml_files}
            RESOURCES ${resource_files}
            RESOURCE_PREFIX "/qt/qml"

    )
endif()


if (MINGW)
    set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")
endif ()


#MSVC Debug 添加后缀d，与Qt插件风格保持一致
if (MSVC)
    set_target_properties(${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "d")
endif ()

#链接库
target_link_libraries(${PROJECT_NAME} PUBLIC
        Qt${QT_VERSION_MAJOR}::Core
        Qt${QT_VERSION_MAJOR}::Quick
        Qt${QT_VERSION_MAJOR}::Qml
)
#安装
install(DIRECTORY ${RINGUI_QML_PLUGIN_DIRECTORY} DESTINATION ${CMAKE_INSTALL_PREFIX}/imports)
