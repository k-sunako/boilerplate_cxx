cmake_minimum_required(VERSION 3.14...3.22)

project(
  Foo_gui
  VERSION 1.0
  LANGUAGES CXX
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(../cmake/CPM.cmake)

CPMAddPackage(
  NAME imgui
  GITHUB_REPOSITORY ocornut/imgui
  GIT_TAG v1.89.8
  VERSION v1.89.8
)

find_package(OpenGL)
find_package(glfw3 3.3 REQUIRED)

CPMAddPackage(NAME Foo SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..)

file(GLOB_RECURSE sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
file(GLOB sources_imgui CONFIGURE_DEPENDS "${imgui_SOURCE_DIR}/*.cpp")
# 自宅の Manjaro では glfw-wayland が必要
set(sources_imgui_backends
  "${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp"
  "${imgui_SOURCE_DIR}/backends/imgui_impl_glfw.cpp")

include_directories(${imgui_SOURCE_DIR})
include_directories(${imgui_SOURCE_DIR}/backends)

add_executable(${PROJECT_NAME} ${sources} ${sources_imgui} ${sources_imgui_backends})

set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 17)

target_compile_options(${PROJECT_NAME} PUBLIC "$<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/permissive->")

target_link_libraries(${PROJECT_NAME} PRIVATE Foo::Foo glfw OpenGL::GL)

target_include_directories(
  ${PROJECT_NAME} PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
)
